/**
 * This file is part of Podcatcher for Sailfish OS.
 * Author: Moritz Carmesin (carolus@carmesinus.de)
 *
 * Podcatcher for Sailfish OS is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Podcatcher for Sailfish OS is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Podcatcher for Sailfish OS.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import Sailfish.Silica 1.0

Cover{

    transparent: true

    Image {
        id: icon
        source: "qrc:///icons/256x256/harbour-podcatcher.png"
        anchors.horizontalCenter: parent.horizontalCenter
        width : parent.width - 2* Theme.paddingLarge
        fillMode: Image.PreserveAspectFit

        anchors.top: parent.top
        anchors.topMargin: Theme.paddingLarge
        smooth: true
    }

    Label {
        id: label
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: icon.bottom
        anchors.topMargin: Theme.paddingLarge
        font.pixelSize: Theme.fontSizeMedium
        color: Theme.primaryColor
        text: qsTr("Podcatcher")
    }




    /* //ui.isDownloading updates don't get here???
    Column{
        anchors.fill: parent

        Label {
            id: label
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: Theme.fontSizeSmall
            text: qsTr("Podcatcher")
        }

       BusyIndicator{
            size: BusyIndicatorSize.Medium
            anchors.horizontalCenter: parent.horizontalCenter
            //running: ui.isDownloading
            visible: true
        }
        Label{
            //text: qsTr("downloading: ") + ui.isDownloading
            text: ui.isDownloading
            visible: true
        }
    }*/



    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: "image://theme/icon-cover-refresh"
            onTriggered: ui.refreshChannels()
        }

        CoverAction {
            iconSource: (appWindow.player.audioPlayer.playbackState === Audio.PlayingState)?
                            "image://theme/icon-cover-pause":"image://theme/icon-cover-play"
            onTriggered: (appWindow.player.audioPlayer.playbackState === Audio.PlayingState)?
                             appWindow.player.audioPlayer.pause(): appWindow.player.audioPlayer.play();
        }
    }
}


