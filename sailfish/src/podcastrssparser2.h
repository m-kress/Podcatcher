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
#ifndef PODCASTRSSPARSER2_H
#define PODCASTRSSPARSER2_H

#include <QObject>

#include "podcastchannel.h"
#include "podcastepisode.h"


class QXmlStreamReader;

class PodcastRSSParser2 : public QObject
{
    Q_OBJECT
public:
    explicit PodcastRSSParser2(QObject *parent = nullptr);
    
    static bool populateChannelFromChannelXML(PodcastChannel *channel, const QByteArray &xmlReply);
    
    static  QList<PodcastEpisode *>* populateEpisodesFromChannelXML(const QByteArray &xmlReply, QObject* episodeParent);
    
    static bool isValidPodcastFeed(const QByteArray &xmlReply);
    
    static QList<QString> parseGPodderSubscription(QByteArray gpodderXml);
    
signals:
    
public slots:
    
private:
    static bool parseRSSChannel(PodcastChannel* channel, QXmlStreamReader & xml);
    static  bool parseAtomChannel(PodcastChannel* channel, QXmlStreamReader & xml);

    static bool parseRSSImage(PodcastChannel *channel, QXmlStreamReader &xml);
    static bool parseAtomImage(PodcastChannel *channel, QXmlStreamReader &xml);

    static  QList<PodcastEpisode *>* episodesFromRSS(QXmlStreamReader &xml, QObject* episodeParent);
    static  QList<PodcastEpisode *>* episodesFromAtom(QXmlStreamReader &xml, QObject* episodeParent);
    
    static QDateTime parsePubDate(const QString &pubDate);
    static QString trimPubDate(const QString &pubdate) {
        QString parsedString = pubdate;

        // Remove optional day field.
        // Input is <pubDate>Wed, 6 Jul 2005 13:00:00 PDT</pubDate>
        // So we remove the start with "Wed, "
        if (parsedString.indexOf(',') > 0) {
            parsedString = parsedString.mid(pubdate.indexOf(',') + 2);
        }

        //qDebug() << "Trimmed feed URL: " << parsedString;
        return parsedString;
    }
    //    static bool containsEnclosure(const QDomNodeList &itemNodes);
    //    static bool isEmptyItem(const QDomNode &node);
    
};

#endif // PODCASTRSSPARSER2S_H
