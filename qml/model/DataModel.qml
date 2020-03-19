import QtQuick 2.0
import Felgo 3.0

Item {
    property alias dispatcher: logicConnection.target
    property alias userSignedIn: _.userSignedIn
    property alias token: _.token

    // whether api is busy (ongoing network requests)
    readonly property bool isBusy: api.busy

    // model data properties
    readonly property alias publicRepos: jsonPublicReposModel
    readonly property alias todoDetails: _.todoDetails

    // action success signals
    signal todoStored(var todo)

    // action error signals
    signal fetchTodosFailed(var error)
    signal fetchTodoDetailsFailed(int id, var error)
    signal storeTodoFailed(var todo, var error)

    // listen to actions from dispatcher
    Connections {
        id: logicConnection

        onFetchPublicRepos: {
            fetchDelay.search = search
            fetchDelay.searchChanged = true

            var cached = cache.getValue("public_repos")
            if(cached)
                _.publicRepos = cached

            if (!fetchDelay.running) {
                _.getPublicRepos(search)
                fetchDelay.searchChanged = false
            }
            fetchDelay.start();
        }

        // action 2 - fetchTodoDetails
        onFetchTodoDetails: {
            // check cached todo details first
            var cached = cache.getValue("todo_"+id)
            if(cached) {
                _.todoDetails[id] = cached
                todoDetailsChanged() // signal change within model to update UI
            }

            // load from api
            api.getTodoById(id,
                            function(data) {
                                // cache data first
                                cache.setValue("todo_"+id, data)
                                _.todoDetails[id] = data
                                todoDetailsChanged()
                            },
                            function(error) {
                                // action failed if no cached data
                                if(!cached) {
                                    fetchTodoDetailsFailed(id, error)
                                }
                            })
        }

        // action 3 - storeTodo
        onStoreTodo: {
            // store with api
            api.addTodo(todo,
                        function(data) {
                            // NOTE: Dummy REST API always returns 201 as id of new todo
                            // To simulate a new todo, we set correct local id based on current model
                            data.id = _.todos.length + 1

                            // cache newly added item details
                            cache.setValue("todo_"+data.id, data)

                            // add new item to todos
                            _.todos.unshift(data)

                            // cache updated todo list
                            cache.setValue("todos", _.todos)
                            todosChanged()

                            todoStored(data)
                        },
                        function(error) {
                            storeTodoFailed(todo, error)
                        })
        }

        // action 4 - clearCache
        onClearCache: {
            cache.clearAll()
        }

        onSignIn: {
            api.postSignInCode(code,
                               function(data) {
                                   console.log(data)
                                   var tokenIndex = data.lastIndexOf("access_token=") + 13
                                   if (tokenIndex !== 12) {
                                       var token = data.substring(tokenIndex, tokenIndex + 40)
                                       cache.setValue("token", token)
                                       _.token = token
                                   }
                                   _.userSignedIn = true
                               },
                               function(error) {
                                   console.log("error while singing in")
                               })
        }

        onLogout: _.token = ""
    }

    // you can place getter functions here that do not modify the data
    // pages trigger write operations through logic signals only

    // rest api for data access
    RestAPI {
        id: api
        maxRequestTimeout: 10000
    }

    // storage for caching
    Storage {
        id: cache
    }

    // private
    Item {
        property var publicRepos: []
        property var todoDetails: ({})

        property bool userSignedIn: false
        property string token: cache.getValue("token") !== undefined
                               ? cache.getValue("token") : ""

        id: _

        Component.onCompleted: userSignedIn = _.token !== ""

        function getPublicRepos(search) {
            api.getPublicRepos(
                        search,
                        function(data) {
                            // cache data before updating model property
                            cache.setValue("public_repos",
                                           search === "" ? data : data.items)
                            _.publicRepos = search === "" ? data : data.items
                        },
                        function(error) {
                            // action failed if no cached data
                            if(!cache.getValue("public_repos"))
                                fetchTodosFailed(error)
                        })
        }
    }

    JsonListModel {
        id: jsonPublicReposModel
        source: _.publicRepos
        keyField: "id"
    }

    Timer {
        property bool searchChanged: false
        property string search

        id: fetchDelay
        interval: 1000
        onTriggered: if (searchChanged) {
                         _.getPublicRepos(search)
                         searchChanged = false
                     }
    }
}
