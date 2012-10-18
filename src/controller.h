#ifndef CONTROLLER_H
#define CONTROLLER_H
#include <QObject>
#include <QSettings>
#include "xmlhelper.h"


class MainView;
class Database;
class QDeclarativeView;
class QVBoxLayout;
class NcFramelessHelper;


class Controller : public QObject
{
    Q_OBJECT

public:
    explicit Controller(QObject *parent = 0);
    Q_INVOKABLE void add(const QString& name, const QString &genre);
    Q_INVOKABLE void remove(const QString& name);
    Q_INVOKABLE void setSeason(const QString& name, int delta);
    Q_INVOKABLE void setEpisode(const QString& name, int delta);
    Q_INVOKABLE void changeColorScheme(const QString& color,const QString &schemeName);
    Q_INVOKABLE QString loadColorScheme();
    Q_INVOKABLE QString getName() {return xml_->name;}
    Q_INVOKABLE QString getStarted() {return xml_->started;}
    Q_INVOKABLE QString getTotalSeasons() {return xml_->totalSeasons;}
    Q_INVOKABLE QString getStatus() {return xml_->status;}
    Q_INVOKABLE QString getAirday() {return xml_->airday;}
    Q_INVOKABLE QString getAirtime() {return xml_->airtime;}
    Q_INVOKABLE QString getNetwork() {return xml_->network;}
    Q_INVOKABLE QString getGenre() {return xml_->genre;}
    Q_INVOKABLE QString getImageUrl() {return xml_->getImageUrl();}


    void checkForFirstInit();



    QWidget  *mainWidget;
    QDeclarativeView  *qmlView;
    NcFramelessHelper *framelessHelper;
    QVBoxLayout *layout;
    Database    *db;
    xmlHelper *xml_;
    QSettings* settings;

};

#endif // CONTROLLER_H
