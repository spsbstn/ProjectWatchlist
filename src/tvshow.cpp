#include "tvshow.h"
#include "quickinfo.h"

#include <QDebug>
#include <QRegExp>

// Constructor
TvShow::TvShow(QString name, int seas, int ep)
    : title(name), season(seas), episode(ep), info(new QuickInfo(this)), newEpisodeAvailable(false)
{
    // Create Connection to API
    info->createConnection(title);
}

// Constructor for loading from database
TvShow::TvShow(QString name, int seas, int ep, QString genre, QString started, QString status, QString airtime,
               QString network, QString latestEp, QString nextEp, QString imageUrl)
    : title(name), season(seas), episode(ep), genre(genre), started(started), status(status), airtime(airtime), network(network),
      latestEpisode(latestEp), nextEpisode(nextEp), imageUrl(imageUrl) ,info(new QuickInfo(this)), newEpisodeAvailable(false)
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
    setNextEpisode(info->showInfo->value("Next Episode"));
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
            QString::number(episode)+ " " + started + " " + status + " " + airtime + " " + network
            + " " + latestEpisode + " " + nextEpisode;
}

// Extracts Date Information String from NextEpisode-Member
QString TvShow::getNextEpisodeDate() const
{
    // NextEpisode-Format: 3Letters/2digits/4digits$  [$ marks end of string]
    QRegExp rex("([A-Z|a-z]{3,3}/[0-9]{1,2}/[0-9]{4,4})$");
    rex.indexIn(nextEpisode);
    return rex.cap(1);
}

void TvShow::getExtraInformation()
{
    info->createConnection(title);
}


// check if there are new episodes availabe
void TvShow::checkForNewEpisodes()
{
    // check if latestEpisode is empty
    if(latestEpisode.isEmpty())
    {
        qDebug() << "Error when checking for new Episodes: String is empty\n"
                    "Show was: "+title;
        return;
    }

    // extract Ints from latestEpisode-String
    int _season  = latestEpisode.left(2).toInt();
    int _episode = latestEpisode.mid(3,2).toInt();

    if(_season == 0 || _episode == 0) // toInt returns 0 if conversion failed
    {
        qDebug() << "Error when checking for new Episodes: String could not be converted to Int";
        return;
    }

    // Check if there are new Episodes:
    if(_season > season)
    {
        newEpisodeAvailable = true;
        return;
    }

    else {

        if(_season == season)
        {
            newEpisodeAvailable = (_episode > episode);
            return;
        }
        else
        {
            newEpisodeAvailable = false;
            return;
        }
    }
}
