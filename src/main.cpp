#include <QtGui/QApplication>
#include <QDeclarativeContext>
#include "qmlapplicationviewer.h"
#include "controller.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QDeclarativeView view;
    Controller c;
    view.setResizeMode(QDeclarativeView::SizeRootObjectToView);
    QDeclarativeContext *ctxt = view.rootContext();
    ctxt->setContextProperty("controller", &c);
    view.setSource(QUrl("qrc:///qml/main.qml"));
    view.showMaximized();
    return app.exec();
}
