import QtQuick 2.14
import QtQuick.Controls 2.14

TabButton {
    text: qsTr("SET ME!")
    icon.source: "qrc:/icons/error.svg"
    icon.width: Style.tabButtonIconWidth
    icon.height: Style.tabButtonIconHeight
    display: AbstractButton.TextUnderIcon
}
