import QtQuick 2.0
import Felgo 3.0

ListPage {
    id: listPage
    showSearch: true

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
}
