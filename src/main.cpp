#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include "fvupdater.h"
#include <QStyle>
#include <QtDebug>
#include <QDesktopWidget>
#include "controller.h"

int main(int argc, char *argv[])
{


    qDebug() << "---------------------------";
    qDebug() << "Short Month Names";
    for (int i = 1; i < 13; i++)
    {
        qDebug() << QDate::shortMonthName(i) << "\n";
    }
    qDebug() << "----------------------------";

    // set applicationName
    QApplication::setApplicationName("Watchlist");
    QApplication::setApplicationVersion(APP_VERSION);
    QApplication::setOrganizationName("cloudsunderneath");
    QApplication::setOrganizationDomain("cloudsunderneath.com");

    // switch to different graphicsSystem for better performance
    QApplication::setGraphicsSystem(QLatin1String("raster"));

    //init app
    QApplication app(argc, argv);

    //init controller
    Controller ctrl(&app);

    FvUpdater::sharedUpdater()->SetFeedURL("https://dl.dropbox.com/u/12650902/Watchlist/Appcast.xml");
    FvUpdater::sharedUpdater()->CheckForUpdatesSilent();

    // connect quit signal
    QObject::connect((QObject*)ctrl.qmlView->engine(), SIGNAL(quit()), &app, SLOT(quit()));

    //maximize Window
    ctrl.windowMaximize();

    //show Window
    ctrl.mainWidget->show();

    return app.exec();
}
