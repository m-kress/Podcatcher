/**
 * This file is part of Podcatcher for Sailfish OS.
 * Authors: Johan Paul (johan.paul@gmail.com)
 *          Moritz Carmesin (carolus@carmesinus.de)
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


BackgroundItem{

    function openChannelSettings(){
        channelDetailsPage.channelDescriptionText = channel.description
        channelDetailsPage.channelName = channel.title
        appWindow.pageStack.push(channelDetailsPage);
    }

    width: parent.width
    height: channelLogo.height

    ChannelDetailsPage{
        id: channelDetailsPage
    }

    PodcastChannelLogo {
        id: channelLogo;
        anchors.left: parent.left
        anchors.leftMargin: 0
        channelLogo: channel.logo
        height: Theme.itemSizeExtraLarge
        width: height
    }
    Label {
        id: channelDescription
        height: channelLogo.height
        width: parent.width- channelLogo.width - Theme.paddingMedium - btnMore.width // mTheme.horizontalPageMargin
        anchors.left: channelLogo.right
        anchors.leftMargin:  Theme.paddingMedium
        text: channel.description
        font.pixelSize: Theme.fontSizeSmall
        wrapMode: Text.WordWrap
        truncationMode: TruncationMode.Fade
    }

    IconButton{
        id: btnMore
        icon.source: "image://theme/icon-m-right"

        anchors.bottom: channelLogo.bottom
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        onClicked: openChannelSettings()
    }


    onClicked: openChannelSettings()
}
