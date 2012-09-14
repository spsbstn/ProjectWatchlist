#include "tvshowdata.h"

TvShowData::TvShowData()
{
}


// Tries to find given Show in the vector, and adds it if not found.
// Returns the Index of the Show if it is already present (useful for later highlighting?)
int TvShowData::addShow(TvShow &show)
{
    int index = findShowIndex(show.getTitle());
    // -1 means the Show wasn´t found
    if (index == -1)
        data.push_back(show);
    return index;
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
// Gives back the ShowIndex, in order to check if a show was found and deleted
int TvShowData::removeShow(TvShow &show)
{
    int index = findShowIndex(show.getTitle());

    if (index != -1)
        data.erase(data.begin() + index);

    return index;
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
