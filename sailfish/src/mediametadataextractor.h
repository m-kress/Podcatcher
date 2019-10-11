#ifndef MEDIAMETADATAEXTRACTOR_H
#define MEDIAMETADATAEXTRACTOR_H

#include <QObject>
#include <qquickimageprovider.h>
#include <QAbstractListModel>
#include <QImage>

#include "podcastepisode.h"

#include <xiphcomment.h>

class MediaMetaDataExtractor;

class CoverImageProvider: public QQuickImageProvider{
public:
    CoverImageProvider(MediaMetaDataExtractor& mmde):
        QQuickImageProvider(QQuickImageProvider::Image),
        m_mmde(mmde)
    {
    }

    QImage requestImage(const QString &id, QSize *size, const QSize &requestedSize);

    MediaMetaDataExtractor& m_mmde;
};


class PodcastChapterModel: public QAbstractListModel{
    Q_OBJECT
public:

    PodcastChapterModel(QObject *parent = Q_NULLPTR);

    enum ChapterRoles {
        TitleRole = Qt::UserRole + 1,
        DescriptionRole,
        StartRole,
        URLRole
    };


    int rowCount(const QModelIndex &parent) const;
    QVariant data(const QModelIndex &index, int role) const;
    QHash<int, QByteArray> roleNames() const;

    void setChapters(QList<PodcastChapter>* chapters);

protected:
     QHash<int, QByteArray> m_roleNames;
     QList<PodcastChapter>* m_chapters;

public slots:
     void onChaptersChanged(QList<PodcastChapter>* chapters);
};

class MediaMetaDataExtractor : public QObject
{
    Q_OBJECT
    QString m_title;

    QString m_podcast;

    QImage m_cover;

    QList<PodcastChapter> m_chapters;

public:
    explicit MediaMetaDataExtractor(QObject *parent = nullptr);

    Q_INVOKABLE void inspect(QString url);
    Q_PROPERTY(QString title READ title NOTIFY titleChanged)
    Q_PROPERTY(QString podcast READ podcast NOTIFY podcastChanged)

    CoverImageProvider imageProvider;
    QImage getCover();
    QList<PodcastChapter>* chapters();



protected:
    void reset();

    void inspectMP3(const QString &url);
    void inspectM4A(const QString &url);
    void inspectOGG(const QString &url);
    void inspectOPUS(const QString &url);

    void parseXiphComments(TagLib::Ogg::XiphComment *tag);

    QString title() const
    {
        return m_title;
    }

    QString podcast() const
    {
        return m_podcast;
    }


signals:

    void titleChanged(QString title);

    void podcastChanged(QString podcast);

    void chaptersChanged(QList<PodcastChapter> * chapters);

public slots:

};

#endif // MEDIAMETADATAEXTRACTOR_H
