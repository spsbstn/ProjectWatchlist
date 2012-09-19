#include <QtGui/QApplication>
#include "qmlapplicationviewer.h"
#include "controller.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QDeclarativeView view;
    view.setResizeMode(QDeclarativeView::SizeRootObjectToView);
    view.setSource(QUrl("qrc:///qml/main.qml"));
    view.showMaximized();
    return app.exec();
}
