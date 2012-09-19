#include "tvshowdata.h"

TvShowData::TvShowData()
{
}


// Tries to find given Show in the vector, and adds it if not found.
// Returns the Index of the Show if it is already present (useful for later highlighting?)
int TvShowData::addShow(const TvShow &show)
{
    int index = findShowIndex(show.getTitle());
    // -1 means the Show wasn´t found
    if (index == -1)
        data.push_back(show);
    return index;
}


int TvShowData::findShowIndex(const QString& name)
{
    for(int i = 0; i < data.size(); i++)
    {
        if (data.at(i).getTitle() == name)
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
        result.append(data.at(i).toString());
        result.append("\n");
    }

    return result;
}


// Turn Vector into QList
QList<TvShowObject *> TvShowData::toQList()
{
    QList<TvShowObject *> showlist;

    for(unsigned int i = 0; i < data.size(); i++)
    {
        showlist.append(new TvShowObject(data.at(i)));
    }

    // TODO:
    // DELETE Elements of List after usage !! Memory Leak!
    // use: qDeleteAll(list.begin(), list.end();
    //      list.clear();
    //


    return showlist;
}


// Creates samplevector with 6 shows
void TvShowData::sampleVector()
{
    TvShow* breakbad = new TvShow("Breaking Bad");
    TvShow* docwho   = new TvShow("Doctor Who", 3, 4);
    TvShow* lost     = new TvShow("Lost", 5, 5);
    TvShow* himym    = new TvShow("HIMYM", 1, 4);
    TvShow* fotc     = new TvShow("FOTC");
    TvShow* iasip    = new TvShow("IASIP", 4, 2);

    addShow(*breakbad);
    addShow(*docwho);
    addShow(*lost);
    addShow(*himym);
    addShow(*fotc);
    addShow(*iasip);
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
