#include "tvshowobject.h"

TvShowObject::TvShowObject(QObject *parent) :
    QObject(parent)
{}

TvShowObject::TvShowObject(const TvShow &show)
    : title(show.getTitle()), season(show.getSeason()),
      episode(show.getEpisode()), genre(show.getGenre())
{}
