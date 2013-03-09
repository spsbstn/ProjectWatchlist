#ifndef CONTROLLER_H
#define CONTROLLER_H
#include <QObject>
#include <QSettings>
#include "quickinfo.h"
#include "database.h"
#include "logger.h"


class MainView;
//class Database;
class QDeclarativeView;
class QVBoxLayout;
class NcFramelessHelper;
class QApplication;


class Controller : public QObject
{
    Q_OBJECT

public:
    explicit Controller(QObject *parent = 0);
    ~Controller();

    //database functions
    Q_INVOKABLE void add(const QString& name);
    Q_INVOKABLE void remove(const QString& name);
    Q_INVOKABLE bool alterShowName(const QString& oldName,const QString& newName);
    Q_INVOKABLE void setSeason(const QString& name, int delta);
    Q_INVOKABLE void setEpisode(const QString& name, int delta);
    Q_INVOKABLE void loadDB();

    //colorScheme functions
    Q_INVOKABLE void changeColorScheme(const QString& color,const QString &schemeName);
    Q_INVOKABLE QString loadColorScheme();
    Q_INVOKABLE void alphaBlendFrame(QString color, double alpha);

    //quickInfo functions
   // Q_INVOKABLE QString getName(const QString& name) {return db->data->getName();}
    Q_INVOKABLE QString getStarted(const QString& name) {return db->data->getStarted(name);}
    Q_INVOKABLE QString getStatus(const QString& name) {return db->data->getStatus(name);}
    Q_INVOKABLE QString getAirtime(const QString& name) {return db->data->getAirtime(name);}
    Q_INVOKABLE QString getNetwork(const QString& name) {return db->data->getNetwork(name);}
    Q_INVOKABLE QString getGenre(const QString& name) {return  db->data->getGenre(name);}
    Q_INVOKABLE QString getLatestEpisode(const QString& name) {return db->data->getLatestEp(name);}
    Q_INVOKABLE QString getNextEpisode(const QString& name) {return db->data->getNextEp(name);}
    Q_INVOKABLE QString getImageUrl(const QString& name) {return db->data->getImageUrl(name);}

    //window functions
    Q_INVOKABLE void windowMaximize();
    Q_INVOKABLE void windowMinimize();
    Q_INVOKABLE void windowHide();

    // --> controller.cpp
    void checkForFirstInit();

    //
    void checkForSeasonIcons(QApplication *app);
    void initMsgHandler();

    QWidget  *mainWidget;
    Database    *db;
    QDeclarativeView  *qmlView;
    NcFramelessHelper *framelessHelper;
    QVBoxLayout *layout;
    //QuickInfo *qi;
    QSettings* settings;

};

#endif // CONTROLLER_H
