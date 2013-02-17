#include "tvshow.h"
#include "quickinfo.h"

#include <QDebug>

// Constructor
TvShow::TvShow(QString name, int seas, int ep)
    : title(name), season(seas), episode(ep), info(new QuickInfo(this))
{
    // Create Connection to API
    info->createConnection(title);
}


// when Hashmap is loaded, values are extracted
void TvShow::onShowInfoFilled()
{
    setStarted(info->showInfo->value("Started"));
    setStatus(info->showInfo->value("Status"));
    setAirtime(info->showInfo->value("Airtime"));
    setNetwork(info->showInfo->value("Network"));
    setGenre(info->showInfo->value("Genres"));
    setLatestEpisode(info->showInfo->value("Latest Episode"));
    setLatestEpisode(info->showInfo->value("Next Episode"));

    qDebug() << toString();
}


// Returns Debug-String
QString TvShow::toString() const
{
    return title + " " + QString::number(season) + " " +
                QString::number(episode)+ " " + started + " " + status + " " + airtime + " " + network;
}
