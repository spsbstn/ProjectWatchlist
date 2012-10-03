#include "mainview.h"

#include <QVBoxLayout>
#include <QDeclarativeContext>
#include <QtDeclarative>
#include "cursorshapearea.h"
#include "libs/NcFramelessHelper.h"
#include "controller.h"
#include "database.h"

MainView::MainView()
    : framelessHelper(new NcFramelessHelper(this)),
      qmlView(new QDeclarativeView),
      layout(new QVBoxLayout),
      controller(new Controller),
      db(new Database)
{
//  Load Database and hand it to Controller
    db->load();
    controller->data = db->data;

//  Setting up Declarative View
    // Resize Mode
    qmlView->setResizeMode(QDeclarativeView::SizeRootObjectToView);

    // C++ - QML Connection
    QDeclarativeContext *ctxt = qmlView->rootContext();
    ctxt->setContextProperty("datalist", controller->data);
    ctxt->setContextProperty("controller", controller);
    ctxt->setContextProperty("mainwindow", this);
    qmlRegisterType<QsltCursorShapeArea>("Cursors", 1, 0, "CursorShapeArea");

    // Set main qml-file
    qmlView->setSource(QUrl("qrc:///qml/main.qml"));

    // Minimum Size
    qmlView->setMinimumSize(QSize(1000,730));


//  Set Layout
    layout->addWidget(qmlView);
    setLayout(layout);
    this->setStyleSheet("background:'#eeeeee'");

//  Activate framelessHelper
    framelessHelper->activateOn(this);
    framelessHelper->setWidgetMovable(false);
    framelessHelper->setWidgetResizable(true);
}
