#include "controller.h"

#include <QApplication>
#include <QDebug>
#include <QDeclarativeView>
#include <QtDeclarative>
#include <QVBoxLayout>
#include <QWidget>

#include "libs/NcFramelessHelper.h"
#include "cursorshapearea.h"
#include "database.h"
#include "tvshowproxymodel.h"
#include "uicontroller.h"
#include "wheelarea.h"



Controller::Controller(QApplication *app,QObject *parent) :
    QObject(parent),
    mainWidget(new QWidget()),
    qmlView(new QDeclarativeView()),
    framelessHelper(new NcFramelessHelper()),
    layout(new QVBoxLayout),
    uicontroller(new UIController(mainWidget,app)),
    proxyModel(new TvShowProxyModel(this)),
    settingsController(new SettingsController(this))
{

#ifdef QT_NO_DEBUG
    //init MsgHandler if debugMode is off
      initMsgHandler();
#endif
      db = new Database();

     // set Resize Mode
        qmlView->setResizeMode(QDeclarativeView::SizeRootObjectToView);


     // initialize proxyModel
        initializeProxyModel();


     // C++ - QML Connection
        QDeclarativeContext *ctxt = qmlView->rootContext();
        ctxt->setContextProperty("datalist", db->data);
        ctxt->setContextProperty("controller", this);
        ctxt->setContextProperty("mainwindow", mainWidget);
        ctxt->setContextProperty("uicontroller", uicontroller);
        ctxt->setContextProperty("settingscontroller", settingsController);
        ctxt->setContextProperty("sortedFilteredData", proxyModel);
        qmlRegisterType<QsltCursorShapeArea>("Cursors", 1, 0, "CursorShapeArea");
        qmlRegisterType<WheelArea>("WheelArea", 1, 0, "WheelArea");

    // Set main qml-file
        qmlView->setSource(QUrl("qrc:///qml/main.qml"));

    // Minimum Size
        qmlView->setMinimumSize(QSize(1100,700));


    //  Set Layout
        layout->addWidget(qmlView);
        mainWidget->setLayout(layout);

    //  Activate framelessHelper
        framelessHelper->activateOn(mainWidget);
        framelessHelper->setWidgetMovable(false);
        framelessHelper->setWidgetResizable(true);

    //  When every show is loaded, busyIndicator is turned off
    //  When a new Show is Added, AddScreen is removed
        QObject *rootObject = dynamic_cast<QObject*>(qmlView->rootObject());
        QObject::connect(db->data, SIGNAL(everyShowLoaded()), rootObject, SLOT(networkUpdateFinished()));
        QObject::connect(db->data, SIGNAL(newShowAdded()), rootObject, SLOT(newShowAdded()));


        QObject::connect(db->data, SIGNAL(showEditSuccess()), rootObject, SLOT(onShowEditSuccess()));
        QObject::connect(db->data, SIGNAL(showEditFailure()), rootObject, SLOT(onShowEditFailure()));

        QObject::connect(db->data,SIGNAL(htmlErrorOccured()), rootObject, SLOT(htmlError()));

        QObject::connect(db, SIGNAL(dbLoaded()), rootObject, SLOT(synching()));

   //  Set WindowMinimizeButtonHint in order to be able to minimize from taskbar
        mainWidget->setWindowFlags(Qt::WindowMinimizeButtonHint | Qt::FramelessWindowHint);
}

Controller::~Controller()
{
    // hides the widget
    mainWidget->hide();

    // delete everything in correct order
    delete db;

    //  delete qi;
    delete layout;
    delete framelessHelper;
    delete qmlView;
    delete mainWidget;
}

void Controller::initializeProxyModel()
{
    proxyModel->setSourceModel(db->data);
    proxyModel->setDynamicSortFilter(true);
    proxyModel->setSortRole(db->data->SortRole);
    proxyModel->sort(0, Qt::AscendingOrder);
    // Only show TvShows whose nextEpisodeString is not empty
    proxyModel->setFilterRole(db->data->NextEpisodeRole);
    proxyModel->setFilterRegExp(QRegExp("^(?!\s*$).+"));
}

// add new show
void Controller::add(const QString& name)
{
    QMetaObject::invokeMethod(dynamic_cast<QObject*>(qmlView->rootObject()), "synching", Qt::DirectConnection);
    TvShow* insert = new TvShow(name);

    // Add to Database immediatly. The Show is then updated in background, and then updated in Database
    // and added to TvShowData Object
    db->addShow(*insert);

    // Connect Signals in order to Update fully Loaded Show in Database
    QObject::connect(insert, SIGNAL(allDataLoaded(TvShow*)), db, SLOT(onAllDataLoaded(TvShow*)));
    QObject::connect(insert, SIGNAL(apiError()), qmlView->rootObject(), SLOT(apiError()));
    QObject::connect(insert, SIGNAL(htmlErrorOccured()), qmlView->rootObject(), SLOT(htmlError()));
}

// remove show
void Controller::remove(const QString& name){

    db->data->removeShow(name);
    db->removeShow(name);
}


// change season, delta is either +1 or -1
void Controller::setSeason(const QString& name, int delta)
{
    db->data->setSeason(name, delta);
    db->alterSeason(name,delta);
}

// change Episode
void Controller::setEpisode(const QString &name, int delta)
{
    db->data->setEpisode(name, delta);
    db->alterEpisode(name,delta);
}

// alter showName
bool Controller::alterShowName(const QString& oldName,const QString& newName)
{
    if(db->alterShowName(oldName,newName)){

    db->data->alterShowName(oldName,newName);
    return true;
    }

    else {

    return false;

    }

}


//maximize window
void Controller::windowMaximize()
{
    mainWidget->setGeometry(QApplication::desktop()->availableGeometry());
}


// minimize window
void Controller::windowMinimize()
{
    mainWidget->setGeometry(QStyle::alignedRect(Qt::LeftToRight, Qt::AlignCenter,
                                                mainWidget->minimumSize(), QApplication::desktop()->availableGeometry()));
}

//hide Window
void Controller::windowHide()
{
    mainWidget->showMinimized();
}


void Controller::initMsgHandler() {

    qInstallMsgHandler(Logger::Handler);

    //log timestamp
    qDebug() << "::" << QDateTime::currentDateTime().toString("dd.MM.yyyy-hh:mm:ss").toAscii().data()  << "::";

}


/*
 * Load Shows from SQLite-Database.
 * Momentarily disconnect newShowAdded Signal, in order to prevent Grid from jumping to the right,
 * when Watchlist is first started
 */
void Controller::loadDB() {
    db->data->disconnect(SIGNAL(newShowAdded()));
    db->load();
    QObject::connect(db->data, SIGNAL(newShowAdded()), qmlView->rootObject(), SLOT(newShowAdded()));
}

void Controller::checkForNewEpisodes(const QString &title)
{
    db->data->checkForNewEpisodes(title);
}



void Controller::manualNetworkUpdate()
{
    db->data->getExtraInformation();
}

void Controller::editShowName(const QString &oldName, const QString &newName)
{
    db->data->editShow(oldName, newName);
}

void Controller::editComplete(const QString &oldName, const QString& newName)
{
    db->data->editComplete(oldName, newName);
}




