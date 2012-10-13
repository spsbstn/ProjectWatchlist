#include "controller.h"
#include <QDebug>
#include <QDeclarativeView>
#include <QtDeclarative>
#include <QVBoxLayout>
#include <QWidget>
#include "cursorshapearea.h"
#include "libs/NcFramelessHelper.h"
#include "database.h"
#include "xmlhelper.h"

Controller::Controller(QObject *parent) :
    QObject(parent),
    mainWidget(new QWidget()),
    db(new Database()),
    qmlView(new QDeclarativeView()),
    framelessHelper(new NcFramelessHelper()),
    layout(new QVBoxLayout)
{
    //  Load Database
    db->load();

    settings = new QSettings("Watchlist");   
    //check for colorscheme-settings
    checkForFirstInit();



    //  Setting up Declarative View
        // Resize Mode
        qmlView->setResizeMode(QDeclarativeView::SizeRootObjectToView);

        // C++ - QML Connection
        QDeclarativeContext *ctxt = qmlView->rootContext();
        ctxt->setContextProperty("datalist", db->data);
        ctxt->setContextProperty("controller", this);
        ctxt->setContextProperty("mainwindow", mainWidget);
        qmlRegisterType<QsltCursorShapeArea>("Cursors", 1, 0, "CursorShapeArea");

        // Set main qml-file
        qmlView->setSource(QUrl("qrc:///qml/main.qml"));

        // Minimum Size
        qmlView->setMinimumSize(QSize(1000,730));


    //  Set Layout
        layout->addWidget(qmlView);
        mainWidget->setLayout(layout);

    //  Activate framelessHelper
        framelessHelper->activateOn(mainWidget);
        framelessHelper->setWidgetMovable(false);
        framelessHelper->setWidgetResizable(true);

        // testing xmlHelper
        xmlHelper *xml_ = new xmlHelper(this);
        xml_->createConnection("Breaking Bad");

}

void Controller::add(const QString& name, const QString& genre)
{
    db->data->addShow(name, genre);
    db->addShow(name,genre);
}

void Controller::remove(const QString& name){

    db->data->removeShow(name);
    db->removeShow(name);
}


// delta is either +1 or -1
void Controller::setSeason(const QString& name, int delta)
{
    db->data->setSeason(name, delta);
    db->alterSeason(name,delta);
}

void Controller::setEpisode(const QString &name, int delta)
{
    db->data->setEpisode(name, delta);
    db->alterEpisode(name,delta);
}

void Controller::changeColorScheme(const QString &color,const QString &schemeName){


     mainWidget->setStyleSheet("background:'"+color+"'");
     settings->setValue("colorScheme", schemeName);
     settings->setValue("color",color);

}

QString Controller::loadColorScheme(){

    QString schemeName = settings->value("colorScheme").toString();
    QString color = settings->value("color").toString();
    mainWidget->setStyleSheet("background:'"+color+"'");
    return schemeName;

}

void Controller::checkForFirstInit(){

    if(settings->contains("colorScheme")){

        return;

    }

    else { //create default values

        settings->setValue("colorScheme", "grey");
        settings->setValue("color","#EEEEEE");
    }

}

