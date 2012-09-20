#include "controller.h"
#include  <QDebug>

Controller::Controller(QObject *parent) :
    QObject(parent),
    data()
{}

void Controller::test(QString name)
{
    data->addShow(name);
}

