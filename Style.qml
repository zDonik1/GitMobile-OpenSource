pragma Singleton
import QtQuick 2.14
import QtQuick.Controls.Material 2.14

Item {
    // TabButton
    readonly property int tabButtonIconWidth: 20
    readonly property int tabButtonIconHeight: tabButtonIconWidth
    readonly property color tabButtonDefaultColor: Material.foreground

    // NavBar
    readonly property color navBarBackgroundColor: Material.foreground
    readonly property color navBarForegroundColor: "#ffffff"
    readonly property int navBarTextSize: 20

    // RepoDelegate
    readonly property color repoDelegateBorderColor: Material.foreground
    readonly property int repoDelegatePadding: 12
    readonly property int repoDelegateBorderHeight: 1

    readonly property color repoDelegateNameColor: Material.foreground
    readonly property int repoDelegateNameTextSize: 20

    readonly property color repoDelegateDescriptionColor: Qt.lighter(Material.foreground)
    readonly property int repoDelegateDescriptionTextSize: 16

    readonly property int repoDelegateIconSize: 25
    readonly property color repoDelegateIconColor: Material.foreground

    // ProfilePageView
    readonly property int profilePageProfileHeight: 110
    readonly property int profilePageAvatarCircleRadius: 35

    readonly property color profilePageNicknameColor: Material.foreground
    readonly property int profilePageNicknameSize: 22

    readonly property int profilePageProfileBorderSize: 1
    readonly property color profilePageProfileBorderColor: Material.foreground

    readonly property int profilePageButtonSpacing: 2
    readonly property int profilePageMargins: 20
}
