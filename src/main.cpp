#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include <QStyle>
#include <QDesktopWidget>

#include "controller.h"

int main(int argc, char *argv[])
{
    QApplication::setApplicationName("Watchlist");
    QApplication::setGraphicsSystem(QLatin1String("raster"));
    QApplication app(argc, argv);
    Controller* ctrl = new Controller;
    QObject::connect((QObject*)ctrl->qmlView->engine(), SIGNAL(quit()), &app, SLOT(quit()));

    ctrl->windowMaximize();
    ctrl->mainWidget->show();
    ctrl->mainWidget->setGeometry(QStyle::alignedRect(Qt::LeftToRight, Qt::AlignCenter,
                          ctrl->mainWidget->size(), app.desktop()->availableGeometry()) );

    return app.exec();
}
