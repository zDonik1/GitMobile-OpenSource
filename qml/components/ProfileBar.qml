import QtQuick 2.12
import Felgo 3.0

Item {
    signal avatarClicked

    property int contentHeight: 60
    property int avatarSize: 40
    property url avatarUrl: "../../assets/myprofile.jpg"
    property string nickname: "zDonik"
    property int nicknameSize: 24
    property int borderThickness: 1

    id: root
    height: contentHeight + borderThickness

    Item {
        id: avatar
        height: contentHeight
        width: height

        RoundedImage {
            id: image
            anchors.centerIn: parent
            width: avatarSize
            height: avatarSize
            source: avatarUrl
            radius: avatarSize / 2
            fillMode: Image.PreserveAspectCrop

            MouseArea {
                anchors.fill: parent
                onClicked: avatarClicked()
            }
        }
    }

    AppText {
        anchors {
            left: avatar.right
            verticalCenter: avatar.verticalCenter
        }
        text: "@" + nickname
        font.pixelSize: nicknameSize
    }

    Rectangle {
        id: border
        anchors {
            top: avatar.bottom
            left: root.left
            right: root.right
        }
        height: borderThickness
        color: Theme.colors.secondaryBackgroundColor
    }
}

