#ifndef TvShow_H
#define TvShow_H

#define OLD_SEASON -1
#include <QString>

class TvShow
{
public:
    // constructor with default values
    TvShow(QString name = "", int seas = 1, int ep = 1, QString gen = "");

    // updates season and episode members. If no second argument is passed, season will not be changed
    void updateLastWatched(int ep, int seas = OLD_SEASON);
    // only increases episode-member by one
    void watchedOneEp() { updateLastWatched(this->episode += 1); }

    // set all the members individually
    void setTitle  (QString name) { title = name; }
    void setSeason (int seas)     { season = seas; }
    void setEpisode(int ep)       { episode = ep; }
    void setGenre  (QString gen)  { genre = gen; }

private:
    QString title;
    int     season;
    int     episode;
    QString genre;
};

#endif // TvShow_H
