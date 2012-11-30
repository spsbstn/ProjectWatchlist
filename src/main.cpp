#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include <QStyle>
#include <QDesktopWidget>

#include "controller.h"

int main(int argc, char *argv[])
{
    // set applicationName
    QApplication::setApplicationName("Watchlist");

    // switch to different graphicSystem for better performance
    QApplication::setGraphicsSystem(QLatin1String("raster"));

    //init app
    QApplication app(argc, argv);

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
