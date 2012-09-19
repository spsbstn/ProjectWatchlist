#include <QtGui/QApplication>
#include <QDeclarativeContext>
#include "qmlapplicationviewer.h"
#include "controller.h"
#include "tvshowdata.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    QDeclarativeView view;
    Controller c;
    view.setResizeMode(QDeclarativeView::SizeRootObjectToView);
    QDeclarativeContext *ctxt = view.rootContext();
    ctxt->setContextProperty("controller", &c);


    ////////
    // Testing if handing QList to GridView in qml works
    TvShowData data;
    data.sampleVector();
    QList<QObject *> datalist = data.toQList();
    ctxt->setContextProperty("datalist", QVariant::fromValue(datalist));

    // It does =)
    ///////

    view.setSource(QUrl("qrc:///qml/main.qml"));
    view.showMaximized();
    return app.exec();
}
