#pragma once

#include <QtGui>
#include <QMutex>

/*
 * Class for redirecting Debug-Messages to LogFile in local AppData-Directory
 */

class Logger: public QObject
{
    Q_OBJECT

public:
    static Logger *instance();
    static void Handler(QtMsgType type, const QMessageLogContext& context, const QString& msg);

private:
    static Logger* _instance;
};
