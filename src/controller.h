#ifndef CONTROLLER_H
#define CONTROLLER_H
#include <QObject>


class Controller : public QObject
{

public:
 explicit Controller(QObject *parent = 0);
Q_INVOKABLE void test();
};

#endif // CONTROLLER_H
