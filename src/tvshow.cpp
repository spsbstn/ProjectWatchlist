#include "TvShow.h"


// Constructor
TvShow::TvShow(const QString &name, int seas, int ep)
    : title(name), season(seas), episode(ep)
{}


// Returns Debug-String
QString TvShow::toString() const
{
    return title + " " + QString::number(season) + " " +
            QString::number(episode);
}
