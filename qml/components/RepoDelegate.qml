import QtQuick 2.12
import QtGraphicalEffects 1.0
import Felgo 3.0

Item {
    property var item: (typeof(modelData) !== "undefined" ) ? modelData : null

    property string repoName: item.repoName
    property string repoDescription: item.repoDescription
    property alias imageSource: icon.source
    property alias imageSize: icon.height
    property alias imageColor: colorOverlay.color
    property bool colorize: false
    property int padding: dp(10)

    height: content.height + padding * 2
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
            fillMode: Image.PreserveAspectFit
            sourceSize.height: height
        }

        ColorOverlay {
            id: colorOverlay
            anchors.fill: icon
            source: icon
            color: Theme.colors.textColor
            visible: colorize
        }
    }

    Item {
        id: content
        anchors {
            verticalCenter: parent.verticalCenter
            left: imageHolder.right
        }
        height: textName.height + textName.height

        AppText {
            anchors.top: parent.top
            id: textName
            text: qsTr(repoName)
            fontSize: 19
            elide: "ElideRight"
        }

        AppText {
            id: textDescription
            anchors.top: textName.bottom
            text: qsTr(repoDescription)
            fontSize: 15
            color: Qt.lighter(Theme.colors.textColor)
            elide: "ElideRight"
        }
    }
}
