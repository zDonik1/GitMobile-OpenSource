import QtQuick 2.0
import QtWebView 1.1
import Felgo 3.0
import "../model"
import "../private"

Page {
    property alias url: webView.url

    visible: opacity > 0
    enabled: visible

    WebView {
        id: webView
        anchors.fill: parent

        onUrlChanged: {
            console.log(url)
            var stringUrl = url.toString()
            var codeIndex = stringUrl.lastIndexOf("code=") + 5
            if (codeIndex !== 4) {
                var code = stringUrl.substring(codeIndex, codeIndex + 20)
                logic.signIn(code)
            }
        }
    }

    AppActivityIndicator {
        anchors.centerIn: parent
        width: dp(200)
        height: width
        visible: webView.loading
    }

    Behavior on opacity {
        NumberAnimation {
            duration: 250
        }
    }
}
