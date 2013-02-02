#include "tvshowdata.h"
#include "database.h"
#include <QtDebug>



TvShowData::TvShowData(QObject *parent)
    : QAbstractListModel(parent)
{
    QHash<int, QByteArray> roles;
    roles[TitleRole]   = "title";
    roles[SeasonRole]  = "season";
    roles[EpisodeRole] = "episode";
    roles[GenreRole]   = "genre";
    setRoleNames(roles);
}


// Tries to find given Show in the vector, and adds it if not found.
// Returns the Index of the Show if it is already present (useful for later highlighting?)
int TvShowData::addShow(const TvShow& show)
{
    int index = findShowIndex(show.getTitle());
    // -1 means the Show wasn´t found
    if (index == -1)
    {
        beginInsertRows(QModelIndex(), rowCount(), rowCount());
        shows.append(show);
        endInsertRows();
    }

    return index;
}


// First creates new TvShow out of name, then inserts it
int TvShowData::addShow(const QString &name, const QString& genre)
{
    TvShow* insert = new TvShow(name, 1, 1,genre);
    return addShow(*insert);
}


// Finds Shows position in Vector through its name
int TvShowData::findShowIndex(const QString& name)
{
    for(int i = 0; i < shows.size(); i++)
    {
        if (shows.at(i).getTitle() == name)
            return i;
    }
    return -1;
}


// Finds Shows position in QList through whole Show-Object
int TvShowData::findShowIndex(const TvShow &show)
{
    return findShowIndex(show.getTitle());
}



// Removes show from vector via its name. Returns -1 if show wasn´t found.
int TvShowData::removeShow(const QString &name)
{
    int index = findShowIndex(name);

    if (index != -1)
    {

        beginRemoveRows(QModelIndex(), index, index);
        shows.erase(shows.begin() + index);
        endRemoveRows();
    }
    return index;
}


// Removes show via object
int TvShowData::removeShow(const TvShow &show)
{

    return removeShow(show.getTitle());
}


// Updates Season
void TvShowData::setSeason(const QString &name, int delta)
{
    int index = findShowIndex(name);

    if (index != -1)
    {

        // Changes in Model
        shows[index].setSeason(delta);

        // Visualize changes
        QModelIndex modindex = createIndex(index, 1);
        emit dataChanged(modindex, modindex);

    }
}


// Updates Episode
void TvShowData::setEpisode(const QString &name, int delta)
{
    int index = findShowIndex(name);

    if (index != -1)
    {

        // Changes in Model
        shows[index].setEpisode(delta);

        // Visualize changes
        QModelIndex modindex = createIndex(index, 1);
        emit dataChanged(modindex, modindex);

    }
}

// Updates showName
void TvShowData::alterShowName(const QString &oldName, const QString &newName)
{
    int index = findShowIndex(oldName);

    if (index != -1)
    {

        // Changes in Model
        shows[index].setTitle(newName);

        // Visualize changes
        QModelIndex modindex = createIndex(index, 1);
        emit dataChanged(modindex, modindex);

    }
}

// Returns Debug-String
QString TvShowData::toString() const
{
    QString result("");

    for (int i = 0; i < shows.size(); i++)
    {
        result.append(shows.at(i).toString());
        result.append("\n");
    }

    return result;
}


// Required by QAbstractListModel - Interface
int TvShowData::rowCount(const QModelIndex &parent) const
{
    return shows.size();
}



// Required by QAbstractListModel - Interface
QVariant TvShowData::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() > shows.size())
        return QVariant();

   const TvShow &show = shows.at(index.row());

   switch (role)
   {
   case TitleRole:
       return show.getTitle();

   case SeasonRole:
       return show.getSeason();

   case EpisodeRole:
       return show.getEpisode();

   case GenreRole:
       return show.getGenre();

   default:
       return QVariant();
   }
}
