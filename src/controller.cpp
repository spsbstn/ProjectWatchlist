#include "controller.h"
#include  <QDebug>

Controller::Controller(QObject *parent) :
    QObject(parent),
    data(new TvShowData())
{}

void Controller::add(const QString& name, const QString& genre)
{
    data->addShow(name, genre);
}

void Controller::remove(const QString& name){

    data->removeShow(name);
}


// delta is either +1 or -1
void Controller::setSeason(const QString& name, int delta)
{
    data->setSeason(name, delta);
}

void Controller::setEpisode(const QString &name, int delta)
{
    data->setEpisode(name, delta);
}

