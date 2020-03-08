import Felgo 3.0

Page {
    title: qsTr("Profile")

    signal logoutClicked

    AppButton {
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: dp(30)
        }
        text: qsTr("Logout")
        onClicked: logoutClicked()
    }
}
