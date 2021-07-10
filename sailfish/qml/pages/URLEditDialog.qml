import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
    DialogHeader{
        id: dlgHeader
        title: qsTr("Edit feed URL")
    }
    property string url: ""

    Column{
        width: parent.width
        anchors.top: dlgHeader.bottom

        TextField{
            id: txtNewFeedURL
            label: qsTr("feed URL")
            text: url
        }

    }

    onDone: {
         if (result == DialogResult.Accepted) {
            ui.changeFeedURLIfValid(channel.channelId, txtNewFeedURL.text);
       }
    }
}
