#ifndef TVSHOWDATA_H
#define TVSHOWDATA_H

// Stores multible TvShows in a Vector

#include <vector>
#include "tvshow.h"

class TvShowData
{
public:
    TvShowData();
    // Adds show to the back of the vector
    // TODO : Throw exception if already added
    void addShow(TvShow show);
    // Removes show at given index
    void removeShow(TvShow show);
    void sortByGenre();
    void sortByTitle();
    QString toString();
    // Has the Show already been added to the vector?
    bool added(TvShow show);

private:
    std::vector<TvShow> data;
    // returns index of given show, -1 if not present
    int  findShowIndex(QString name);
};


// Compare classes for matching c++ sorting-syntax
// http://www.cplusplus.com/reference/algorithm/sort/
//
// Maybe put these in a different file?
class titleCompare
{
public:
    bool operator() (TvShow show1, TvShow show2)
    {
        return show1.getTitle() < show2.getTitle();
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

#endif // TVSHOWDATA_H
