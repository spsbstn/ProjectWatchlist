#include "controller.h"
#include <QDebug>
#include <QDeclarativeView>
#include <QtDeclarative>
#include <QVBoxLayout>
#include <QWidget>
#include "cursorshapearea.h"
#include "libs/NcFramelessHelper.h"
#include "database.h"
#include "wheelarea.h"

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
        qmlRegisterType<WheelArea>("WheelArea", 1, 0, "WheelArea");

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


        qi = new QuickInfo(this);
        QObject *rootObject = dynamic_cast<QObject*>(qmlView->rootObject());
        QObject::connect(rootObject, SIGNAL(xmlDataRequired(QString)), qi, SLOT(createConnection(QString)));
        QObject::connect(qi->xmlPicture_, SIGNAL(updateFinished()), rootObject, SLOT(updateInfo()));


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

void Controller::windowMaximize()
{
    mainWidget->setGeometry(QApplication::desktop()->availableGeometry());
}


void Controller::windowMinimize()
{
    mainWidget->setGeometry(QStyle::alignedRect(Qt::LeftToRight, Qt::AlignCenter,
                                                mainWidget->minimumSize(), QApplication::desktop()->availableGeometry()));
}

void Controller::windowHide()
{
    mainWidget->showMinimized();
}

void Controller::alphaBlendFrame(QString color, double alpha)
{


    QString hexRed=color.mid(1,2);
    QString hexGreen=color.mid(3,2);
    QString hexBlue=color.mid(5,2);

    //qDebug() << hexRed << hexGreen << hexBlue;

    bool ok;

    int red=hexRed.toInt(&ok, 16);
    int green=hexGreen.toInt(&ok, 16);
    int blue=hexBlue.toInt(&ok, 16);

    //qDebug() << red << green << blue;

    //blend black (0,0,0) over color

    red = (1-alpha)*red+1;
    green = (1-alpha)*green+1;
    blue = (1-alpha)*blue+1;

    QString blendedColor = QColor(red,green,blue,1 ).name();

    //qDebug() << blendedColor;

    mainWidget->setStyleSheet("background:'"+blendedColor+"'");

}

