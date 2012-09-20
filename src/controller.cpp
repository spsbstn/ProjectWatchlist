#include "controller.h"
#include  <QDebug>

Controller::Controller(QObject *parent) :
    QObject(parent),
    data()
{}

void Controller::add(QString name)
{
    data->addShow(name);
}

void Controller::remove(QString name){

    data->removeShow(name);


}
