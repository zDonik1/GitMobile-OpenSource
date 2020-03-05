import QtQuick 2.14
import QtQuick.Controls 2.14

PageView {
    ListView {
        anchors.fill: parent
        model: listModel
        delegate: RepoDelegate {
            repoName: name
            repoDescription: description
        }
    }

    ListModel {
        id: listModel

        ListElement {
            name: "MyRepo"
            description: "This is my new repos"
        }

        ListElement {
            name: "C++Repo"
            description: "Some random C++ repo"
        }

        ListElement {
            name: "LearningQtQuick"
            description: "This is me learning Qt Quick"
        }
    }
}
