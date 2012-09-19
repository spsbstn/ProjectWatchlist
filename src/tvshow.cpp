#include "TvShow.h"


TvShowObject::TvShowObject(QObject *parent) :
    QObject(parent)
{}


TvShow::TvShow(const QString &name, int seas, int ep, const QString &gen)
    : title(name), season(seas), episode(ep), genre(gen)
{}

void TvShow::updateLastWatched(int ep, int seas)
{
    if (seas != OLD_SEASON) season = seas;
    episode = ep;
}


void TvShow::watchedOneEp()
{
    updateLastWatched(this->episode += 1);
}


QString TvShow::toString()
{
    return title + " " + QString::number(season) + " " +
            QString::number(episode) + " " + genre;
}


