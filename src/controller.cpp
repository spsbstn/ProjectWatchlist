#include "controller.h"
#include  <QDebug>

Controller::Controller(QObject *parent) :
    QObject(parent)
{

}
void Controller::test(){

    qDebug() << "Hello World";

}

