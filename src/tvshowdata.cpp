#include "tvshowdata.h"

TvShowData::TvShowData()
{
}


// Has Show already been added?
bool TvShowData::added(TvShow show)
{
    for (int i = 0; i < data.size(); i++)
    {
        if (data.at(i).getTitle() == show.getTitle())
            return true;
    }
    return false;
}

// Adds Show to Vector
void TvShowData::addShow(TvShow show)
{
    if (!added(show))
        data.push_back(show);

    // TODO: Throw Exception if Show has already been added
}


// Removes show from vector
// TODO : Check if argument is in vector-boundaries!
void TvShowData::removeShow(int index)
{
    data.erase(data.begin() + index);
}

// Sorts Vector by Genre / Title
// TODO : Test if it works :D
void TvShowData::sortByGenre()
{
    std::sort(data.begin(), data.end(), genreCompare());
}

void TvShowData::sortByTitle()
{
    std::sort(data.begin(), data.end(), titleCompare());
}
