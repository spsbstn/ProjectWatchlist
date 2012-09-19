#ifndef TvShow_H
#define TvShow_H

#include <QString>
#include <QObject>


#define OLD_SEASON -1


class TvShow
{
    Q_OBJECT

    // Don´t know if NOTIFY-Signals are needed, but they would be defined as in the first example
    Q_PROPERTY(QString title READ getTitle WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(int season READ getSeason WRITE setSeason)
    Q_PROPERTY(int episode READ getEpisode WRITE setEpisode)
    Q_PROPERTY(QString genre READ getGenre WRITE setGenre)

public:
    // constructor with default values
    TvShow(QObject* parent = 0);
    TvShow(const QString& name = "", int seas = 1, int ep = 1,const QString& gen = "");

    // updates season and episode members. If no second argument is passed, season will not be changed
    void updateLastWatched(int ep, int seas = OLD_SEASON);
    // only increases episode-member by one
    void watchedOneEp();

    // set all the members individually
    void setTitle  (const QString& name) { title = name; }
    void setSeason (int seas)            { season = seas; }
    void setEpisode(int ep)              { episode = ep; }
    void setGenre  (const QString& gen)  { genre = gen; }

    // getter-functions
    QString getTitle() const { return title; }
    int    getSeason() const { return season; }
    int   getEpisode() const { return episode; }
    QString getGenre() const { return genre; }

    // Return string for printing TvShow to console
    QString toString();

private:
    QString title;
    int     season;
    int     episode;
    QString genre;
};

#endif // TvShow_H
