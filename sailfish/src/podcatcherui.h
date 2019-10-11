/**
 * This file is part of Podcatcher for Sailfish OS.
 * Author: Johan Paul (johan.paul@gmail.com)
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
#ifndef PODCATCHERUI_H
#define PODCATCHERUI_H

#include <QObject>
#include <QList>
#include <sailfishapp.h>

#include <MGConfItem>

#include "podcastmanager.h"
#include "podcastchannelsmodel.h"
#include "mediametadataextractor.h"

class PodcatcherUI : QObject
{
    Q_OBJECT
public:
    explicit PodcatcherUI();

    Q_INVOKABLE void addPodcast(QString rssUrl, QString logoUrl = QString());
    Q_INVOKABLE void deletePodcasts(int channelId);
    //Q_INVOKABLE bool isDownloading();
    Q_INVOKABLE bool isLiteVersion();
    Q_INVOKABLE void refreshChannels();
    Q_INVOKABLE QString versionString();
    Q_INVOKABLE void importFromGPodder(QString username, QString password);

    Q_PROPERTY(bool isDownloading READ isDownloading NOTIFY isDownloadingChanged)

    void downloadNewEpisodes(QString channelId);

signals:
    void showInfoBanner(QString text);
    void downloadedBytesUpdated(int bytes);
    void downloadingPodcasts(bool downloading);
    void streamingUrlResolved(QString streamUrl, QString streamTitle);
    void playFileWithInternalPlayer(QString fileName);

    void isDownloadingChanged(bool isDownloading);

public slots:

private slots:
    void onShowChannel(QString channelId);
    void onRefreshEpisodes(int channelId);
    void onDownloadPodcast(int channelId, int index);
    void onPlayPodcast(int channelId, int index);
    void onDownloadingPodcast(bool isDownloading);
    void onCancelDownload(int channelId, int index);
    void onCancelQueueing(int channelId, int index);
    void onDeleteChannel(QString channelId);
    void onAllListened(QString channelId);
    void onDeletePodcast(int channelId, int index);
    void onMarkAsUnplayed(int channelId, int index);
    void onStartStreaming(int channelId, int index);
    void onStreamingUrlResolved(QString streamUrl, QString streamTitle);
    void onAutoDownloadChanged(int channelId, bool autoDownload);
    void onMediaPlayerChanged();


private:
    PodcastManager m_pManager;
    MediaMetaDataExtractor m_mMDE;
    PodcastChannelsModel *m_channelsModel;
    PodcastChapterModel *m_chapterModel;
    PodcastEpisodesModelFactory *modelFactory;
    QMap<QString, QString> logoCache;
    QQuickView* view;

    MGConfItem *m_mediaPlayerConf;
    QString m_mediaPlayerPath;

    bool isDownloading();


};

#endif // PODCATCHERUI_H
