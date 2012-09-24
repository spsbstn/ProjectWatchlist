#include <QtGui/QApplication>
#include <QDeclarativeContext>
#include "qmlapplicationviewer.h"
#include "controller.h"
#include "tvshowdata.h"
#include "database.h"
#include <QtDeclarative>
#include "cursorshapearea.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QDeclarativeView view;
    view.setWindowFlags(Qt::FramelessWindowHint);

    // Set up controller
    Controller c;
    view.setResizeMode(QDeclarativeView::SizeRootObjectToView);
    QDeclarativeContext *ctxt = view.rootContext();

    //init DB
    Database db;
    db.load();

    // hand database to controller
    c.data = db.data;

    // Set up Datalist and Controller for qml
    ctxt->setContextProperty("datalist", c.data);
    ctxt->setContextProperty("controller", &c);

    qmlRegisterType<QsltCursorShapeArea>("Cursors", 1, 0, "CursorShapeArea");
    view.setSource(QUrl("qrc:///qml/main.qml"));
    view.setMinimumSize(QSize(800,750));
    view.showMaximized();
    return app.exec();
}
