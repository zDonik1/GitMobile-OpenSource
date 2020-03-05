import QtQuick 2.14
import QtGraphicalEffects 1.0

Item {
    property string repoName: "SET REPO NAME"
    property string repoDescription: "SET REPO DESCRIPTION"

    height: (content.height > imageHolder.height
             ? content.height : imageHolder.height) + Style.repoDelegatePadding
    anchors {
        left: parent.left
        right: parent.right
    }

    Item {
        id: imageHolder
        anchors.verticalCenter: parent.verticalCenter
        height: icon.height + Style.repoDelegatePadding
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
            leftMargin: Style.repoDelegatePadding
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

    Rectangle {
        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }
        width: parent.width - 30
        height: Style.repoDelegateBorderHeight
        color: Style.repoDelegateBorderColor
    }
}
