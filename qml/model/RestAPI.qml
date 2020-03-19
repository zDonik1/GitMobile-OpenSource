import QtQuick 2.0
import Felgo 3.0
import "../private"

Item {

    // loading state
    readonly property bool busy: HttpNetworkActivityIndicator.enabled

    // configure request timeout
    property int maxRequestTimeout: 5000

    // initialization
    Component.onCompleted: {
        // immediately activate loading indicator when a request is started
        HttpNetworkActivityIndicator.setActivationDelay(0)
    }

    // private
    QtObject {
        id: _
        property url url: "https://api.github.com"

        function fetch(url, success, error) {
            console.log(encodeURI(url));
            HttpRequest.get(encodeURI(url))
            .timeout(maxRequestTimeout)
            .then(function(res) { success(res.body) })
            .catch(function(err) { error(err) });
        }

        function post(url, data, success, error) {
            console.log(encodeURI(url));
            HttpRequest.post(encodeURI(url))
            .timeout(maxRequestTimeout)
            .set('Content-Type', 'application/json')
            .send(data)
            .then(function(res) { success(res.body) })
            .catch(function(err) { error(err) });
        }
    }


    // public rest api functions

    function getPublicRepos(search, success, error) {
        if (search === "") {
            _.fetch(_.url + "/repositories", success, error)
        }
        else {
            _.fetch(_.url + "/search/repositories?q=" + search, success, error)
        }
    }

    function postSignInCode(code, success, error) {
        _.post("https://github.com/login/oauth/access_token",
               {
                   client_id: PrivateSettings.clientId,
                   client_secret: PrivateSettings.clientSecret,
                   code: code
               },
               success, error)
    }

    function addTodo(todo, success, error) {
        _.post(_.todoUrl, todo, success, error)
    }
}
