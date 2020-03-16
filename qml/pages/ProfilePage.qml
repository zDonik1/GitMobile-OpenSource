import QtQuick 2.1
import Felgo 3.0

import "../components"

Page {
    signal logoutClicked

    property int buttonSpacing: dp(10)

    id: root
    title: qsTr("Profile")

    ProfileBar {
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
        contentHeight: dp(100)
        avatarSize: dp(70)
        nicknameSize: sp(24)
        borderThickness: dp(1)

        onAvatarClicked: root.state === "" ? root.state = "changeAvatar"
                                           : root.state = ""
    }

    AppButton {
        id: buttonLogout
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
            bottomMargin: dp(30)
        }
        text: qsTr("Logout")
        onClicked: logoutClicked()
    }

    Item {
        id: avatarChangeButtons
        height: buttonGallery.height + buttonCamera.height + buttonSpacing
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height

        AppButton {
            id: buttonGallery
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("From Gallery")
            visible: root.state === "" ? avatarChangeButtons.y < root.height
                                       : true
        }

        AppButton {
            id: buttonCamera
            anchors {
                top: buttonGallery.bottom
                topMargin: buttonSpacing
                horizontalCenter: parent.horizontalCenter
            }
            text: qsTr("From Camera")
            visible: root.state === "" ? avatarChangeButtons.y < root.height
                                       : true
        }

        Behavior on y {
            NumberAnimation {
                id: animation
                duration: 800
                easing.type: Easing.OutBack
            }
        }
    }

    states: [
        State {
            name: "changeAvatar"

            PropertyChanges {
                target: avatarChangeButtons
                y: buttonLogout.y - avatarChangeButtons.height - buttonSpacing
            }
        }
    ]
}
