#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include "fvupdater.h"
#include <QStyle>
#include <QTranslator>
#include <QLocale>
#include <QtDebug>
#include <QDesktopWidget>

#include "controller.h"

int main(int argc, char *argv[])
{
    // set applicationName
    QApplication::setApplicationName("Watchlist");
    QApplication::setApplicationVersion(APP_VERSION);
    QApplication::setOrganizationName("cloudsunderneath");
    QApplication::setOrganizationDomain("cloudsunderneath.com");

    // switch to different graphicSystem for better performance
    QApplication::setGraphicsSystem(QLatin1String("raster"));

    //init app
    QApplication app(argc, argv);

    QString locale = QLocale::system().name();

    QTranslator translator;

    /* the ":/" is a special directory Qt uses to
     * distinguish resources;
     * NB this will look for a filename matching locale + ".qm";
     * if that's not found, it will truncate the locale to
     * the first two characters (e.g. "en_GB" to "en") and look
     * for that + ".qm"; if not found, it will look for a
     * qml-translations.qm file; if not found, no translation is done
     */
    qDebug()<<":/translation_" << locale;
    if (translator.load(":/qml/i18n/translation_" + locale))
      app.installTranslator(&translator);

    //init controller
    Controller* ctrl = new Controller;

    FvUpdater::sharedUpdater()->SetFeedURL("https://dl.dropbox.com/u/12650902/Watchlist/Appcast.xml");
    FvUpdater::sharedUpdater()->CheckForUpdatesSilent();

    // connect quit signal
    QObject::connect((QObject*)ctrl->qmlView->engine(), SIGNAL(quit()), &app, SLOT(quit()));

    //maximize Window
    ctrl->windowMaximize();

    //show Window
    ctrl->mainWidget->show();

    ctrl->checkForSeasonIcons(&app);


    return app.exec();
}
