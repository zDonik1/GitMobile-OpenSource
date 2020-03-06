import QtQuick 2.14
import QtQuick.Controls 2.14
import QtGraphicalEffects 1.0

PageView {
    Item {
        id: profile
        height: Style.profilePageProfileHeight

        Item {
            id: avatar
            height: parent.height
            width: height

            Image {
                id: imageAvatar
                anchors.centerIn: parent
                sourceSize.width: cropCircle.width
                sourceSize.height: cropCircle.width
                source: "qrc:/assets/myprofile.jpg"
                visible: false
            }

            Rectangle {
                id: cropCircle
                width: Style.profilePageAvatarCircleRadius * 2
                height: width
                radius: width / 2
                visible: false
            }

            OpacityMask {
                anchors.fill: imageAvatar
                source: imageAvatar
                maskSource: cropCircle
            }
        }

        Text {
            anchors {
                left: avatar.right
                verticalCenter: parent.verticalCenter
            }
            text: "@zDonik"
            color: Style.profilePageNicknameColor
            font.pixelSize: Style.profilePageNicknameSize
        }
    }

    Rectangle {
        id: border
        anchors.top: profile.bottom
        width: parent.width
        height: Style.profilePageProfileBorderSize
        color: Style.profilePageProfileBorderColor
    }

    Button {
        id: buttonGallery
        anchors {
            bottom: buttonCamera.top
            bottomMargin: Style.profilePageButtonSpacing
            horizontalCenter: parent.horizontalCenter
        }

        text: qsTr("From Gallery")
    }

    Button {
        id: buttonCamera
        anchors {
            bottom: parent.bottom
            bottomMargin: Style.profilePageMargins
            horizontalCenter: parent.horizontalCenter
        }
        text: qsTr("From Camera")
    }
}
