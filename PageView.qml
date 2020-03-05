import QtQuick 2.14
import QtQuick.Controls 2.4

Item {
    property string name: "SET ME"
    property bool isTemplate: false

    Label {
        visible: isTemplate
        anchors.centerIn: parent
        text: qsTr("You are on page " + name)
    }
}
