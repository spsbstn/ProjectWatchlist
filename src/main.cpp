#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include <QStyle>
#include <QDesktopWidget>

#include "mainview.h"

int main(int argc, char *argv[])
{
    QApplication::setGraphicsSystem(QLatin1String("raster"));
    QApplication app(argc, argv);
    MainView* view = new MainView;
    QObject::connect((QObject*)view->qmlView->engine(), SIGNAL(quit()), &app, SLOT(quit()));

    view->show();
    view->setGeometry(QStyle::alignedRect(Qt::LeftToRight, Qt::AlignCenter,
                          view->size(), app.desktop()->availableGeometry()) );
    return app.exec();
}
