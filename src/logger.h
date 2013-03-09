#pragma once

#include <QtGui>
#include <QMutex>

class Logger: public QObject
{
    Q_OBJECT

public:
    static Logger *instance();
    static void Handler(QtMsgType type, const char *msg);

private:
    static Logger* _instance;
};
