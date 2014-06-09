#ifndef SETTINGSCONTROLLER_H
#define SETTINGSCONTROLLER_H

#include <QSettings>

class SettingsController : public QObject
{
    Q_OBJECT
public:
    explicit SettingsController(QObject *parent);
    QSettings *settings;
    Q_INVOKABLE void changeHoster(QString hoster);
    Q_INVOKABLE QString loadHoster();

private:
    void checkForFirstInit();
};

#endif // SETTINGSCONTROLLER_H
