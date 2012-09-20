#ifndef CONTROLLER_H
#define CONTROLLER_H
#include <QObject>

#include "tvshowdata.h"

class Controller : public QObject
{
    Q_OBJECT

public:
 explicit Controller(QObject *parent = 0);
Q_INVOKABLE void add(QString name);
Q_INVOKABLE void remove(QString name);
    TvShowData* data;
};

#endif // CONTROLLER_H
