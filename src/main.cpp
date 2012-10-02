#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"


#include "mainview.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    MainView* view = new MainView;
    QObject::connect((QObject*)view->qmlView->engine(), SIGNAL(quit()), &app, SLOT(quit()));
    view->show();

    return app.exec();
}
