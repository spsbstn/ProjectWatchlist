#ifndef TvShow_H
#define TvShow_H

#include <QString>


#define OLD_SEASON -1


class TvShow
{
public:
    // constructor with default values
    TvShow(const QString& name = "", int seas = 1, int ep = 1,const QString& gen = "");

    // set all the members individually
    void setTitle  (const QString& name) { title = name; }
    void setSeason (int delta)           { season += delta; }
    void setEpisode(int delta)           { episode += delta; }
    void setGenre  (const QString& gen)  { genre = gen; }

    // getter-functions
    QString getTitle() const { return title; }
    int    getSeason() const { return season; }
    int   getEpisode() const { return episode; }
    QString getGenre() const { return genre; }

    // Return string for printing TvShow to console
    QString toString() const;


private:
    QString title;
    int     season;
    int     episode;
    QString genre;

};

#endif // TvShow_H
