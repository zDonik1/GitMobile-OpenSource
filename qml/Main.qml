import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls.Material 2.12
import "model"
import "logic"
import "pages"


App {
    // You get free licenseKeys from https://felgo.com/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://felgo.com/licenseKey>"

    // init Material theme
    Material.accent: "#D87C47"
    Material.foreground: "#374146"

    // app initialization
    Component.onCompleted: {
        // if device has network connection, clear cache at startup
        // you'll probably implement a more intelligent cache cleanup for your app
        // e.g. to only clear the items that aren't required regularly
        if(isOnline) {
            logic.clearCache()
        }

        // fetch todo list data
        logic.fetchTodos()
        logic.fetchDraftTodos()
    }

    onInitTheme: {
        Theme.tabBar.titleColor = Material.accent
        Theme.tabBar.backgroundColor = Material.background
        Theme.tabBar.showIcon = true
        Theme.tabBar.titleOffColor = Material.foreground

        Theme.colors.backgroundColor = Material.background
        Theme.colors.tintColor = Material.foreground
    }

    // business logic
    Logic {
        id: logic
    }

    // model
    DataModel {
        id: dataModel
        dispatcher: logic // data model handles actions sent by logic

        // global error handling
        onFetchTodosFailed: nativeUtils.displayMessageBox("Unable to load todos", error, 1)
        onFetchTodoDetailsFailed: nativeUtils.displayMessageBox("Unable to load todo "+id, error, 1)
        onStoreTodoFailed: nativeUtils.displayMessageBox("Failed to store "+viewHelper.formatTitle(todo))
    }

    // helper functions for view
    ViewHelper {
        id: viewHelper
    }

    // view
    Navigation {
        id: navigation
        navigationMode: navigationModeTabs
        tabPosition: Qt.BottomEdge

        NavigationItem {
            title: qsTr("Search Repos")
            icon: IconType.search

            NavigationStack {
                ListPage {
                    id: listPage
                    title: qsTr("Repositories")
                    showSearch: true

                    delegate: SimpleRow {
                        iconSource: IconType.book
                        style: StyleSimpleRow {
                            dividerHeight: 0
                        }
                    }

                    model: [
                        {
                            text: "Some C++ repo",
                            detailText: "Trying to experiment new C++ features"
                        },
                        {
                            text: "Learning Qt Quick",
                            detailText: "Project showcasing Qt Quick features"
                        },
                        {
                            text: "Mobile github on Felgo",
                            detailText: "Making github service for mobile devices"
                        }
                    ]
                }
            }
        }

        NavigationItem {
            title: qsTr("My Repos")
            icon: IconType.list


            NavigationStack {
                Page {
                    title: qsTr("My Repositories")
                }

                // login page lies on top of previous items and overlays if user is not logged in
                LoginPage {
                    visible: opacity > 0
                    enabled: visible
                    opacity: dataModel.userLoggedIn ? 0 : 1 // hide if user is logged in

                    Behavior on opacity {  // page fade in/out
                        NumberAnimation {
                            duration: 250
                        }
                    }
                }
            }
        }

        NavigationItem {
            title: qsTr("Profile") // use qsTr for strings you want to translate
            icon: IconType.user

            NavigationStack {
                ProfilePage {
                    // handle logout
                    onLogoutClicked: {
                        logic.logout()

                        // jump to main page after logout
                        navigation.currentIndex = 0
                        navigation.currentNavigationItem.navigationStack.popAllExceptFirst()
                    }
                }

                // login page lies on top of previous items and overlays if user is not logged in
                LoginPage {
                    visible: opacity > 0
                    enabled: visible
                    opacity: dataModel.userLoggedIn ? 0 : 1 // hide if user is logged in

                    Behavior on opacity {  // page fade in/out
                        NumberAnimation {
                            duration: 250
                        }
                    }
                }
            }
        }
    }
}
