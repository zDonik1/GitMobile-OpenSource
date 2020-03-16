import QtQuick 2.0
import Felgo 3.0

Page {
    signal accepted(string search)

    property alias model: listView.model
    property alias delegate: listView.delegate

    id: root

    SearchBar {
        id: searchBar
        showDivider: true
        onAccepted: root.accepted(text)
    }

    AppListView {
        id: listView
        anchors {
            top: searchBar.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        clip: true

        model: [
            {
                repoName: "Some C++ repo",
                repoDescription: "Trying to experiment new C++ features",
            },
            {
                repoName: "Learning Qt Quick",
                repoDescription: "Project showcasing Qt Quick features"
            },
            {
                repoName: "Mobile github on Felgo",
                repoDescription: "Making github service for mobile devices"
            }
        ]

        PullToRefreshHandler {
            onRefresh: root.accepted(searchBar.text)
        }
    }
}
