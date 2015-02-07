#include "logger.h"

Logger* Logger::_instance = NULL;

Logger * Logger::instance()
{
    static QMutex mutex;

    if (_instance == NULL)
    {
        mutex.lock();
        if (_instance == NULL)
            _instance = new Logger;
        mutex.unlock();
    }

    return _instance;
}

void Logger::Handler(QtMsgType type, const QMessageLogContext &context, const QString& msg)
{
    Q_UNUSED(type);
    //get path to logfile
    QString path = QStandardPaths::standardLocations(QStandardPaths::DataLocation).at(0);
    path.append(QDir::separator()).append("log.txt");
    path = QDir::toNativeSeparators(path);

    //open file
    QFile debuglog(path);

    //if logfilesize is > 500kb, clear logfile, else append new log
   if(debuglog.size() > 512000){

       debuglog.open(QIODevice::WriteOnly | QIODevice::Text);

    }

    else {


       debuglog.open(QIODevice::WriteOnly | QIODevice::Text |QIODevice::Append );

    }

    QTextStream out(&debuglog);
    //msg.toCFString() is not really the right way to do this, but it works
    //maybe take a look at this later
    fprintf(stderr, "%s\n", msg.toCFString());
    out << msg << "\n";

    debuglog.flush();
    debuglog.close();

}
