#include "settingscontroller.h"

SettingsController::SettingsController(QObject *parent)
{

    Q_UNUSED(parent)

    settings = new QSettings("Watchlist");
    checkForFirstInit();
}

void SettingsController::changeHoster(QString hoster)
{
    settings->setValue("Hoster",hoster);
}

QString SettingsController::loadHoster()
{
    return settings->value("Hoster").toString();
}

void SettingsController::checkForFirstInit() {
    if (settings->contains("Hoster"))
    {
        return;
    }
    else
    {
        settings->setValue("Hoster", "kinox");
    }
}
