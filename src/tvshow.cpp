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

// Constructor for loading from database
TvShow::TvShow(QString name, int seas, int ep, QString genre, QString started, QString status, QString airtime,
               QString network, QString latestEp, QString nextEp, QString imageUrl)
    : title(name), season(seas), episode(ep), genre(genre), started(started), status(status), airtime(airtime), network(network),
      latestEpisode(latestEp), nextEpisode(nextEp), imageUrl(imageUrl) ,info(new QuickInfo(this))
{
}

TvShow::~TvShow()
{
    delete info;
}


// when API-information is loaded, values are extracted
void TvShow::onShowInfoFilled()
{
    setStarted(info->showInfo->value("Started"));
    setStatus(info->showInfo->value("Status"));
    setAirtime(info->showInfo->value("Airtime"));
    setNetwork(info->showInfo->value("Network"));
    setGenre(info->showInfo->value("Genres"));
    setLatestEpisode(info->showInfo->value("Latest Episode"));
    setLatestEpisode(info->showInfo->value("Next Episode"));
    setImageUrl(info->showInfo->value("Image Url"));

    // All data is loaded, now show can be added to QList
    emit allDataLoaded(this);
}

void TvShow::debugString(TvShow *show)
{
    qDebug() << show->toString();
}


// Returns Debug-String
QString TvShow::toString() const
{
    return title + " " + QString::number(season) + " " +
            QString::number(episode)+ " " + started + " " + status + " " + airtime + " " + network;
}

void TvShow::getExtraInformation()
{
    info->createConnection(title);
}
