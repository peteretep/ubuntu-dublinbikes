import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import "JSONListModel" as JSON

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"
    applicationName: "uReadIt"
    id: window

    width: units.gu(50)
    height: units.gu(75)

    PageStack {
        id: pageStack
        anchors.fill: parent
        Component.onCompleted: pageStack.push(subreddits)

        Page {
            id: subreddits
            anchors.fill: parent
            title: 'uReadIt'

                Row {
                    id: subredditControls
                    spacing: units.gu(1)

                    Label {
                        id: goLabel
                        objectName: "label"
                        text: "Subreddit:"
                        y: subreddit.height/2 - goLabel.height/2
                    }
                    TextField {
                        id: subreddit
                        width: subreddits.width - (goLabel.width + goButton.width + subredditControls.spacing*2)
                        placeholderText: 'Ubuntu'
                    }
                    Button {
                        id: 'goButton'
                        text: 'Go'
                        color: 'green'
                    }
                }

                ListView {
                    id: articleList
                    anchors.top: subredditControls.bottom
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    JSON.JSONListModel {
                        id: bikeStationFeed
                        source: "http://api.citybik.es/dublin.json"

                        query: "$[*]"
                    }
                    model: bikeStationFeed.model

                    delegate: ListItem.Subtitled {
                        text: model.name

                    }
                }
        }

        Page {
            id: articleView
            title: 'Article'
        }
    }

}
