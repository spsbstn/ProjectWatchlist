#ifndef TVSHOWOBJECT_H
#define TVSHOWOBJECT_H

#include <QObject>
#include "tvshow.h"

class TvShowObject : public QObject
{
    Q_OBJECT

    // Don´t know if NOTIFY-Signals are needed, but they would be defined as in the first example
    Q_PROPERTY(QString title READ getTitle WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(int season READ getSeason WRITE setSeason)
    Q_PROPERTY(int episode READ getEpisode WRITE setEpisode)
    Q_PROPERTY(QString genre READ getGenre WRITE setGenre)

public:
    // Make a TvShow into a TvShowObject
    TvShowObject(const TvShow& show);

    // getter-functions
    QString getTitle() const { return title; }
    int    getSeason() const { return season; }
    int   getEpisode() const { return episode; }
    QString getGenre() const { return genre; }

    // Setter - functions
    void setTitle  (const QString& name) { title = name; emit titleChanged(); }
    void setSeason (int seas)            { season = seas; }
    void setEpisode(int ep)              { episode = ep; }
    void setGenre  (const QString& gen)  { genre = gen; }

signals:
    void titleChanged();

public slots:

    // Don´t know why private members are needed when they´re already
    // defined in Q_PROPERTY but the example did the same ...
private:
    QString title;
    int     season;
    int     episode;
    QString genre;

    explicit TvShowObject(QObject *parent = 0);
    TvShowObject();
    TvShowObject(const TvShowObject&);
};

#endif // TVSHOWOBJECT_H
