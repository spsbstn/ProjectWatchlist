#ifndef CONTROLLER_H
#define CONTROLLER_H
#include <QObject>
#include <QSettings>

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

    void checkForFirstInit();

    QWidget  *mainWidget;
    QDeclarativeView  *qmlView;
    NcFramelessHelper *framelessHelper;
    QVBoxLayout *layout;
    Database    *db;
    QSettings* settings;

};

#endif // CONTROLLER_H
