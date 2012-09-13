#include "TvShow.h"

TvShow::TvShow(QString name, int seas, int ep, QString gen)
    : title(name), season(seas), episode(ep), genre(gen)
{}

void TvShow::updateLastWatched(int ep, int seas)
{
    if (seas != OLD_SEASON) season = seas;
    episode = ep;
}


QString TvShow::toString()
{
    return title + " " + QString::number(season) + " " +
            QString::number(episode) + " " + genre;
}


