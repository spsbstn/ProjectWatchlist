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


int TvShowData::findShowIndex(QString name)
{
    for(int i = 0; i < data.size(); i++)
    {
        if (data.at(i).getTitle() == name)
            return i;
    }

    return -1;
}


// Removes show from vector
// TODO : Check if show was found!!
void TvShowData::removeShow(TvShow show)
{
    int index = findShowIndex(show.getTitle());

    if (index != -1)
        data.erase(data.begin() + index);
}


QString TvShowData::toString()
{
    QString result("");

    for (int i = 0; i < data.size(); i++)
    {
        result.append(data.at(i).toString());
        result.append("\n");
    }

    return result;
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
