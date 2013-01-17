#ifndef TVSHOWDATA_H
#define TVSHOWDATA_H

#include <QList>
#include <QAbstractListModel>
#include "tvshow.h"


class TvShowData : public QAbstractListModel
{
    Q_OBJECT

public:

    enum TvShowRoles
    {
        TitleRole = Qt::UserRole +1,
        SeasonRole,
        EpisodeRole,
    };

    TvShowData(QObject* parent = 0);

    // Adds show to the back of the vector, returns ShowIndex
    // (-1 if successfully added)
    // TODO : Inform User if already added
    int addShow(const TvShow &show);
    int addShow(const QString &name);

    // Overloaded functions: removes show either via the show-object or
    // via its name. The function returns the index, the show was deleted at,
    // or -1 if it wasn´t found.
    int removeShow(const QString& name);
    int removeShow(const TvShow& show);

    // Changes Season/Episode of Show with title "name" by delta
    void setSeason(const QString& name, int delta);
    void setEpisode(const QString& name, int delta);


    QString toString() const;
    int rowCount (const QModelIndex &parent = QModelIndex()) const;
    QVariant data (const QModelIndex &index, int role = Qt::DisplayRole) const;


private:
    QList<TvShow> shows;
    // returns index of given show, -1 if not present
    int findShowIndex(const QString& name);
    int findShowIndex(const TvShow& show);
};

#endif // TVSHOWDATA_H
