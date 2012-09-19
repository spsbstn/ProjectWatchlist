#include "controller.h"
#include  <QDebug>

Controller::Controller(QObject *parent) :
    QObject(parent)
{

}
void Controller::test(QString msg){

    qDebug() << msg << endl;

}

