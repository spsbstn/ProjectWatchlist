#ifndef TVSHOWDATA_H
#define TVSHOWDATA_H

// Stores multible TvShows in a Vector

#include <vector>
#include <QList>
#include "tvshow.h"


class TvShowData
{
public:
    TvShowData();
    // Adds show to the back of the vector, returns ShowIndex
    // (-1 if successfully added)
    // TODO : Inform User if already added
    int addShow(const QString &name);
    // Overloaded functions: removes show either via the show-object or
    // via its name. The function returns the index, the show was deleted at,
    // or -1 if it wasn´t found.
    int removeShow(const QString& name);
    int removeShow(const TvShow& show);
    void sortByGenre();
    void sortByTitle();
    QString toString();
    void sampleVector();

    // Turns vector<TvShow> into QList<TvShowObject *> for qml-communication
    QList<QObject *> getQList() { return data; }

private:
    QList<QObject *> data;
    // returns index of given show, -1 if not present
    int findShowIndex(const QString& name);
    int findShowIndex(const TvShow& show);
};


// Compare classes for matching c++ sorting-syntax
// http://www.cplusplus.com/reference/algorithm/sort/
//
// Maybe put these in a different file?

/*
        DOESNT WORK RIGHT NOW ... maybe just syntax, dont know

class titleCompare
{
public:
    bool operator() (QObject* show1, QObject* show2)
    {
        return ((TvShow*)show1)->getTitle() < ((TvShow*)show2)->getTitle();
    }
};

class genreCompare
{
public:
    bool operator() (TvShow show1, TvShow show2)
    {
        return show1.getGenre() < show2.getGenre();
    }
};

*/

#endif // TVSHOWDATA_H
