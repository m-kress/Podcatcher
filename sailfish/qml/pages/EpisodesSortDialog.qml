import QtQuick 2.0
import Sailfish.Silica 1.0


Dialog {
    id: episodesSortDialog

    property var sortByFields: ["dbid","published", "state", "title"]

    DialogHeader{
        id: dlgHeader
        title: qsTr("Sorting of the Episodes")
    }

    Column{
        width: parent.width
        anchors.top: dlgHeader.bottom
        ComboBox{
            id: cbBy
            label: qsTr("Sort by")

            menu: ContextMenu{
                MenuItem{
                    text: qsTr("ID")
                }
                MenuItem{
                    text: qsTr("publication date")
                }

                MenuItem{
                    text: qsTr("state")
                }

                MenuItem{
                    text: qsTr("title")
                }
            }
        }

        ComboBox{
            id: cbOrder
            label: qsTr("Sort order")

            menu: ContextMenu{
                MenuItem{
                    text: qsTr("descending")
                }

                MenuItem{
                    text: qsTr("ascending")
                }


            }

        }

    }

    onAccepted: {

        channel.sortBy = sortByFields[cbBy.currentIndex];
        channel.sortDescending = (cbOrder.currentIndex <1);
    }

    onOpened:{
        cbBy.currentIndex = sortByFields.indexOf(channel.sortBy);
        cbOrder.currentIndex = channel.sortDescending?0:1;
    }

}
