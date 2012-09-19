#ifndef CONTROLLER_H
#define CONTROLLER_H
#include <QObject>


class Controller : public QObject
{
    Q_OBJECT

public:
 explicit Controller(QObject *parent = 0);
Q_INVOKABLE void test(QString msg);
};

#endif // CONTROLLER_H
