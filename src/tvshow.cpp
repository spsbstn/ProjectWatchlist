#include "TvShow.h"
#include "quickinfo.h"
#include <QDebug>

// Constructor
TvShow::TvShow(QString name, int seas, int ep)
    : title(name), season(seas), episode(ep), info(new QuickInfo())
{
    // Create Connection to API
    info->createConnection(title);

    // Fill in gathered information
    setStarted(info->showInfo->value("Started"));
    setStatus(info->showInfo->value("Status"));
    setAirtime(info->showInfo->value("Airtime"));
    setNetwork(info->showInfo->value("Network"));
    setGenre(info->showInfo->value("Genres"));
    setLatestEpisode(info->showInfo->value("Latest Episode"));
    setLatestEpisode(info->showInfo->value("Next Episode"));


    qDebug() << title+started+status+airtime+network;
}


// Returns Debug-String
QString TvShow::toString() const
{
    return title + " " + QString::number(season) + " " +
            QString::number(episode);
}
