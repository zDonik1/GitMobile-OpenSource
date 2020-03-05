import QtQuick 2.14
import QtQuick.Controls 2.4

Item {
    property string name: "SET ME"

    Label {
        anchors.centerIn: parent
        text: qsTr("You are on page " + name)
    }
}
