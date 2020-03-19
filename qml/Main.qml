import Felgo 3.0
import QtQuick 2.0
import QtQuick.Controls.Material 2.12
import "model"
import "logic"
import "pages"
import "components"
import "private"


App {
    // You get free licenseKeys from https://felgo.com/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the Felgo Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from https://felgo.com/licenseKey>"

    // init Material theme
    Material.accent: "#D87C47"
    Material.foreground: "#374146"

    // app initialization
    Component.onCompleted: {
        // if device has network connection, clear cache at startup
        // you'll probably implement a more intelligent cache cleanup for your app
        // e.g. to only clear the items that aren't required regularly
        if(isOnline) {
            logic.clearCache()
        }

        // fetch todo list data
        logic.fetchPublicRepos("")
        logic.fetchDraftTodos()

        if (settings.getValue("code") === undefined)
            settings.setValue("code", "")

        if (!dataModel.userSignedIn)
            authPage.url = "https://github.com/login/oauth/authorize?client_id="
                    + PrivateSettings.clientId

        console.log("main: " + dataModel.userSignedIn)
        console.log("main: " + dataModel.token)
    }

    onInitTheme: {
        Theme.colors.textColor = Material.foreground
        Theme.colors.backgroundColor = Material.background
        Theme.colors.disclosureColor = Material.background
        Theme.colors.tintColor = Material.accent
        Theme.colors.secondaryBackgroundColor = Material.foreground

        Theme.navigationBar.backgroundColor
                = Theme.colors.secondaryBackgroundColor
        Theme.navigationBar.titleColor = Theme.colors.backgroundColor

        Theme.tabBar.titleColor = Theme.colors.tintColor
        Theme.tabBar.backgroundColor = Theme.colors.backgroundColor
        Theme.tabBar.showIcon = true
        Theme.tabBar.titleOffColor = Theme.colors.textColor
    }

    // business logic
    Logic {
        id: logic
    }

    // model
    DataModel {
        id: dataModel
        dispatcher: logic // data model handles actions sent by logic

        // global error handling
        onFetchTodosFailed: nativeUtils.displayMessageBox("Unable to load todos", error, 1)
        onFetchTodoDetailsFailed: nativeUtils.displayMessageBox("Unable to load todo "+id, error, 1)
        onStoreTodoFailed: nativeUtils.displayMessageBox("Failed to store "+viewHelper.formatTitle(todo))
    }

    // helper functions for view
    ViewHelper {
        id: viewHelper
    }

    Navigation {
        id: navigation
        navigationMode: navigationModeTabs
        tabPosition: Qt.BottomEdge

        NavigationItem {
            title: qsTr("Search Repos")
            icon: IconType.search

            NavigationStack {
                navigationBar.rightBarItem: ActivityIndicatorBarItem {
                    visible: dataModel.isBusy
                }

                ReposListPage {
                    title: qsTr("Repositories")
                    model: dataModel.publicRepos
                    delegate: RepoDelegate {
                        imageSource: owner.avatar_url
                        imageSize: dp(35)
                        repoName: name
                        repoDescription: description
                    }

                    onAccepted: logic.fetchPublicRepos(search)
                }
            }
        }

        NavigationItem {
            id: navItemMyRepos
            title: qsTr("My Repos")
            icon: IconType.list


            NavigationStack {
                ReposListPage {
                    title: qsTr("My Repositories")
                    delegate: RepoDelegate {
                        imageSource: Qt.resolvedUrl("../assets/repo.svg")
                        imageSize: dp(25)
                    }
                }
            }
        }

        NavigationItem {
            id: navItemProfile
            title: qsTr("Profile") // use qsTr for strings you want to translate
            icon: IconType.user

            NavigationStack {
                ProfilePage {
                    onLogoutClicked: {
                        logic.logout()
                        navigation.currentIndex = 0
                        navigation.currentNavigationItem.navigationStack.popAllExceptFirst()
                    }
                }
            }
        }
    }

    GithubOAuthPage {
        id: authPage
        x: navItemMyRepos.page.x
        y: navItemMyRepos.page.y
        width: navItemMyRepos.page.width
        height: navItemMyRepos.page.height
        opacity: navigation.currentIndex === 1 || navigation.currentIndex === 2
                 ? dataModel.userSignedIn ? 0 : 1
                 : 0
    }
}
