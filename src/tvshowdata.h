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
        EpisodeRole
    };

    TvShowData(QObject* parent = 0);
    ~TvShowData();

    // Adds show to the back of the vector, returns ShowIndex
    // (-1 if successfully added)
    // TODO : Inform User if already added
    int addShow(TvShow &show);
    int addShow(const QString &name);

    // Overloaded functions: removes show either via the show-object or
    // via its name. The function returns the index, the show was deleted at,
    // or -1 if it wasn´t found.
    int removeShow(const QString& name);
    int removeShow(const TvShow& show);

    // Changes Season/Episode of Show with title "name" by delta
    void setSeason(const QString& name, int delta);
    void setEpisode(const QString& name, int delta);

    // Find Position of Show
    int findShowIndex(const QString& name);

    // change name of given show to a new name
    void alterShowName(const QString& oldName, const QString& newName);

    // InfoScreen functions
    QString getStarted(const QString& name);
    QString getStatus(const QString& name);
    QString getAirtime(const QString& name);
    QString getNetwork(const QString& name);
    QString getGenre(const QString& name);
    QString getLatestEp(const QString& name);
    QString getNextEp(const QString& name);
    QString getImageUrl(const QString& name);

    // Debug String
    QString toString() const;

    int rowCount (const QModelIndex &parent = QModelIndex()) const;
    QVariant data (const QModelIndex &index, int role = Qt::DisplayRole) const;

    QList<TvShow*> shows;
private:
    TvShowData(const TvShowData&);
    TvShowData& operator= (const TvShowData&);
    // returns index of given show, -1 if not present
    //int findShowIndex(const TvShow& show);
};

#endif // TVSHOWDATA_H
