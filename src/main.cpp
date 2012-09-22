#include <QtGui/QApplication>
#include <QDeclarativeContext>
#include "qmlapplicationviewer.h"
#include "controller.h"
#include "tvshowdata.h"
#include "database.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QDeclarativeView view;

    // Set up controller
    Controller c;
    view.setResizeMode(QDeclarativeView::SizeRootObjectToView);
    QDeclarativeContext *ctxt = view.rootContext();

    // Create Sample vector
    TvShowData shows;
    shows.sampleVector();

    //test DB
    Database db;
    db.addShow("Breaking Bad");
    db.getData();

    // hand sample vector to controller
    c.data = &shows;

    // Set up Datalist and Controller for qml
    ctxt->setContextProperty("datalist", c.data);
    ctxt->setContextProperty("controller", &c);


    view.setSource(QUrl("qrc:///qml/main.qml"));
    view.showMaximized();
    return app.exec();
}
