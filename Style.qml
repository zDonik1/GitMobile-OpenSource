pragma Singleton
import QtQuick 2.14
import QtQuick.Controls.Material 2.14

Item {
    // TabButton
    property int tabButtonIconWidth: 20
    property int tabButtonIconHeight: tabButtonIconWidth
    property color tabButtonDefaultColor: Material.foreground

    // NavBar
    property color navBarBackgroundColor: Material.foreground
    property color navBarForegroundColor: "#ffffff"
    property int navBarTextSize: 20

    // RepoDelegate
    property color repoDelegateBorderColor: Material.foreground
    property int repoDelegatePadding: 15
    property int repoDelegateBorderHeight: 1

    property color repoDelegateNameColor: Material.foreground
    property color repoDelegateDescriptionColor: Qt.lighter(Material.foreground)

    property int repoDelegateNameTextSize: 16
    property int repoDelegateDescriptionTextSize: 12

    property int repoDelegateIconSize: 20
    property color repoDelegateIconColor: Material.foreground
}
