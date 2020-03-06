import QtQuick 2.14
import QtGraphicalEffects 1.0

Item {
    property string repoName: "SET REPO NAME"
    property string repoDescription: "SET REPO DESCRIPTION"

    height: (content.height > icon.height
             ? content.height : icon.height)
            + Style.repoDelegatePadding * 2
    anchors {
        left: parent.left
        right: parent.right
    }

    Item {
        id: imageHolder
        anchors.verticalCenter: parent.verticalCenter
        height: parent.height
        width: height

        Image {
            id: icon
            anchors.centerIn: parent
            source: "qrc:/icons/book.svg"
            width: Style.repoDelegateIconSize
            height: Style.repoDelegateIconSize
        }

        ColorOverlay {
            anchors.fill: icon
            source: icon
            color: Style.repoDelegateIconColor
        }
    }

    Item {
        id: content
        anchors {
            verticalCenter: parent.verticalCenter
            left: imageHolder.right
        }
        height: textName.height + textName.height

        Text {
            anchors.top: parent.top
            id: textName
            text: qsTr(repoName)
            color: Style.repoDelegateNameColor
            font.pixelSize: Style.repoDelegateNameTextSize
        }

        Text {
            id: textDescription
            anchors.top: textName.bottom
            text: qsTr(repoDescription)
            color: Style.repoDelegateDescriptionColor
            font.pixelSize: Style.repoDelegateDescriptionTextSize
        }
    }
}
