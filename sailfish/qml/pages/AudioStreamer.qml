/**
 * This file is part of Podcatcher for N9.
 * Author: Johan Paul (johan.paul@gmail.com)
 *
 * Podcatcher for N9 is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Podcatcher for N9 is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Podcatcher for N9.  If not, see <http://www.gnu.org/licenses/>.
 */
import QtQuick 2.2
import QtMultimedia 5.0

import Sailfish.Silica 1.0

DockedPanel {
    id: streamerItem

    signal playStream(string url, string title)
    signal stopStream(string url)

    property string title


    height: buttonGroup.height + 2* Theme.paddingLarge

    width: parent.width

    dock: Dock.Bottom
    modal: false
    open: false

    opacity: 1

    Rectangle{
        anchors.fill: parent
        color: Theme.highlightDimmerColor
        opacity: .9
    }

    function durationText(curPos) {
        var curPosSecs = Math.floor((parseInt(curPos) / 1000));

        var curPlayTimeSecs = (curPosSecs % 60);
        var curPlayTimeMins = Math.floor((curPosSecs / 60));
        var curPlayTimeHours = Math.floor((curPosSecs / 3600));

        if (curPlayTimeHours == 0) {
            curPlayTimeHours = ""
        } else if (curPlayTimeHours < 10) {
            curPlayTimeHours = "0" + curPlayTimeHours.toString();
        }

        if (curPlayTimeHours > 0) {
            curPlayTimeMins = curPlayTimeMins % 60;
        }

        if (curPlayTimeSecs < 10) {
            curPlayTimeSecs = "0" + curPlayTimeSecs;
        }

        if (curPlayTimeMins < 10) {
            curPlayTimeMins = "0" + curPlayTimeMins;
        }

        if (curPlayTimeHours.toString().length > 0) {
            curPlayTimeHours = curPlayTimeHours + " : ";
        }

        var playtimeString = curPlayTimeHours.toString() + curPlayTimeMins.toString() + " : " + curPlayTimeSecs.toString();

        return playtimeString;
    }


    Column {
        id: buttonGroup
        spacing: Theme.paddingMedium
        width: parent.width
        anchors.bottom: parent.bottom
        anchors.margins: Theme.paddingMedium
        anchors.bottomMargin: Theme.paddingLarge

        Label {
            id: streamTitleLabel
            text: title
            width: parent.width //- durationLabel.width
            height: Text.paintedHeight
            anchors.horizontalCenter: parent.horizontalCenter
            elide: Text.ElideRight
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: Theme.fontSizeSmall
        }


        Slider{
            id: playbackPosition
            width: parent.width
            height: Theme.iconSizeMedium
            minimumValue: 0
            maximumValue: audioPlayer.duration
            value: audioPlayer.position

            onValueChanged: {
                if(audioPlayer.playbackState == Audio.PlayingState){
                    audioPlayer.seek(playbackPosition.value)
                }
            }

        }

        Row {
            spacing: Theme.paddingSmall
            anchors.horizontalCenter: parent.horizontalCenter

            IconButton {
                id: rewBtn
                icon.source: "image://theme/icon-m-left?" + (pressed
                                                             ? Theme.highlightColor
                                                             : Theme.primaryColor)
                onClicked: {
                    console.log("Setting audio position to " + audioPlayer.position - 10000 + "s")
                    audioPlayer.seek(audioPlayer.position - 10000);
                }

                enabled: audioPlayer.playbackState == Audio.PlayingState ||
                         audioPlayer.playbackState == Audio.PausedState
            }


            IconButton {
                id: playBtn
                icon.source: "image://theme/icon-m-play?" + (pressed
                                                             ? Theme.highlightColor
                                                             : Theme.primaryColor)
                enabled: audioPlayer.playbackState !== Audio.PlayingState
                onClicked: {
                    audioPlayer.play();
                }
            }


            IconButton {
                id: pauseBtn
                icon.source: "image://theme/icon-m-pause?" + (pressed
                                                              ? Theme.highlightColor
                                                              : Theme.primaryColor)
                enabled: audioPlayer.playbackState == Audio.PlayingState

                onClicked: {
                    audioPlayer.pause();
                }
            }



            IconButton {
                id:ffBtn
                icon.source: "image://theme/icon-m-right?" + (pressed
                                                              ? Theme.highlightColor
                                                              : Theme.primaryColor)

                enabled: audioPlayer.playbackState == Audio.PlayingState ||
                         audioPlayer.playbackState == Audio.PausedState


                onClicked: {
                    console.log("Setting audio position to " + audioPlayer.position + 10000 + "s")
                    //audioPlayer.position = audioPlayer.position + 10000
                    audioPlayer.seek(audioPlayer.position + 10000);
                }
            }



            IconButton {
                id: closeBtn

                icon.source: "image://theme/icon-m-close?" + (pressed
                                                              ? Theme.highlightColor
                                                              : Theme.primaryColor)


                onClicked: {
                    audioPlayer.stop();
                    hide();
                }
            }


        }

        Label {
            id: durationLabel
            text: durationText(audioPlayer.position);
            font.pixelSize: Theme.fontSizeTiny
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }


    onPlayStream: {
        audioPlayer.source = url;
        streamerItem.title = title;
        audioPlayer.play();
    }



    Audio {
        id: audioPlayer

        onPlaying: {
            console.log("Ok, we started playing...");
        }

        onStopped: {
            //stopStream(audioPlayer.source);
            //hide();
        }
    }


}
