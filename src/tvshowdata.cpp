#include "tvshowdata.h"

TvShowData::TvShowData()
{
}


// Tries to find given Show in the vector, and adds it if not found.
// Returns the Index of the Show if it is already present (useful for later highlighting?)
int TvShowData::addShow(const QString& name)
{
    int index = findShowIndex(name);
    // -1 means the Show wasn´t found
    if (index == -1)
    {
        TvShow* show = new TvShow(name);
        data.append(show);
    }

    return index;
}


int TvShowData::findShowIndex(const QString& name)
{
    for(int i = 0; i < data.size(); i++)
    {
        if (((TvShow*)data.at(i))->getTitle() == name)
            return i;
    }
    return -1;
}


int TvShowData::findShowIndex(const TvShow &show)
{
    return findShowIndex(show.getTitle());
}



// Removes show from vector via its name. Returns -1 if show wasn´t found.
int TvShowData::removeShow(const QString &name)
{
    int index = findShowIndex(name);

    if (index != -1)
        data.erase(data.begin() + index);

    return index;
}

// Removes show via object
int TvShowData::removeShow(const TvShow &show)
{
    return removeShow(show.getTitle());
}


QString TvShowData::toString()
{
    QString result("");

    for (int i = 0; i < data.size(); i++)
    {
        result.append(((TvShow *)data.at(i))->toString());
        result.append("\n");
    }

    return result;
}


// Creates samplevector with 7 shows
void TvShowData::sampleVector()
{
    addShow("Breaking Bad");
    addShow("Doctor Who");
    addShow("Lost");
    addShow("HIMYM");
    addShow("Flight of the Conchords");
    addShow("IASIP");
    addShow("Adventure Time");
}

// Sorts Vector by Genre / Title
// TODO : Test if it works :D

/*
    SORTING DOESNT WORK ANYMORE. FIX LATER

void TvShowData::sortByGenre()
{
    std::sort(data.begin(), data.end(), genreCompare());
}

void TvShowData::sortByTitle()
{
    std::sort(data.begin(), data.end(), titleCompare());
}

*/
