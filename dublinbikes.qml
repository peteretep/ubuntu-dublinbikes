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
    applicationName: "Dublin Bikes"
    id: window

    width: units.gu(50)
    height: units.gu(75)


    Page {
        id: bikeStations
        anchors.fill: parent
        title: 'Dublin Bikes'


            Row{
                id: headersRow
                Label{
                    text:"Bikes"
                }
                Label{
                    text:"Free Stands"
                }
            }

            ListView {
                id: articleList
                anchors.top: headersRow.bottom
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                JSON.JSONListModel {
                    id: bikeStationFeed
                    source: "http://api.citybik.es/dublin.json"
                    query: "$[*]"
                }
                model: bikeStationFeed.model

                delegate: ListItem.ValueSelector {
                    text:model.name
                    values:["Bikes: "+ model.bikes, "Free Stands: "+model.free, "Total Stands: "+model.number]
                    icon: UbuntuShape {
                        Rectangle{
                            height:parent.height
                            width:parent.width/2
                            Label{
                                anchors.centerIn: parent
                                text:model.bikes
                                color:"white"
                                fontSize: "small"
                            }
                            color: (model.bikes==0) ? "red" : "green"
                        }
                        Rectangle {
                            height:parent.height
                            width:parent.width/2
                            x:parent.width/2
                            Label{
                                anchors.centerIn: parent
                                text:model.free
                                color:"white"
                                fontSize: "small"
                            }
                            color: (model.free===0) ? "red" : "green"
                        }
                        radius: "medium"
                    }

                }
            }

    }



}
