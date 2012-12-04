#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include "fvupdater.h"
#include <QStyle>
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

    FvUpdater::sharedUpdater()->SetFeedURL("https://dl.dropbox.com/u/12650902/Watchlist/Appcast.xml");
    FvUpdater::sharedUpdater()->CheckForUpdatesSilent();

    //init controller
    Controller* ctrl = new Controller;

    // connect quit signal
    QObject::connect((QObject*)ctrl->qmlView->engine(), SIGNAL(quit()), &app, SLOT(quit()));

    //maximize Window
    ctrl->windowMaximize();

    //show Window
    ctrl->mainWidget->show();

    //center Window (obsolete ? )
    ctrl->mainWidget->setGeometry(QStyle::alignedRect(Qt::LeftToRight, Qt::AlignCenter,
                          ctrl->mainWidget->size(), app.desktop()->availableGeometry()) );

    return app.exec();
}
