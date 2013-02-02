#ifndef CONTROLLER_H
#define CONTROLLER_H
#include <QObject>
#include <QSettings>
#include "quickinfo.h"

class MainView;
class Database;
class QDeclarativeView;
class QVBoxLayout;
class NcFramelessHelper;
class QApplication;


class Controller : public QObject
{
    Q_OBJECT

public:
    explicit Controller(QObject *parent = 0);

    //database functions
    Q_INVOKABLE void add(const QString& name, const QString &genre);
    Q_INVOKABLE void remove(const QString& name);
    Q_INVOKABLE bool alterShowName(const QString& oldName,const QString& newName);
    Q_INVOKABLE void setSeason(const QString& name, int delta);
    Q_INVOKABLE void setEpisode(const QString& name, int delta);

    //colorScheme functions
    Q_INVOKABLE void changeColorScheme(const QString& color,const QString &schemeName);
    Q_INVOKABLE QString loadColorScheme();
    Q_INVOKABLE void alphaBlendFrame(QString color, double alpha);

    //quickInfo functions
    Q_INVOKABLE QString getName() {return qi->showInfo->value("Show Name");}
    Q_INVOKABLE QString getStarted() {return qi->showInfo->value("Started");}
    Q_INVOKABLE QString getStatus() {return qi->showInfo->value("Status");}
    Q_INVOKABLE QString getAirtime() {return qi->showInfo->value("Airtime");}
    Q_INVOKABLE QString getNetwork() {return qi->showInfo->value("Network");}
    Q_INVOKABLE QString getGenre() {return  qi->showInfo->value("Genres");}
    Q_INVOKABLE QString getLatestEpisode() {return qi->showInfo->value("Latest Episode");}
    Q_INVOKABLE QString getNextEpisode() {return qi->showInfo->value("Next Episode");}
    Q_INVOKABLE QString getImageUrl() {return qi->getImageUrl();}

    //window functions
    Q_INVOKABLE void windowMaximize();
    Q_INVOKABLE void windowMinimize();
    Q_INVOKABLE void windowHide();

    // --> controller.cpp
    void checkForFirstInit();

    //
    void checkForSeasonIcons(QApplication *app);

    QWidget  *mainWidget;
    Database    *db;
    QDeclarativeView  *qmlView;
    NcFramelessHelper *framelessHelper;
    QVBoxLayout *layout;
    QuickInfo *qi;
    QSettings* settings;

};

#endif // CONTROLLER_H
