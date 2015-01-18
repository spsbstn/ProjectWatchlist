#include "database.h"

#include <QtSql>
#include <QtDebug>
#include <QErrorMessage>
#include <QDesktopServices>
#include "tvshow.h"



//init or load database
Database::Database(QObject *parent) :
    QObject(parent),
    data(new TvShowData(this)),
    currTable("data"),
    oldTable("not used")
{
    QObject::connect(this, SIGNAL(dbLoaded()), data, SLOT(onDbLoaded()));
    QObject::connect(data, SIGNAL(allDataLoaded(TvShow*)), this, SLOT(onAllDataLoaded(TvShow*)));
    QObject::connect(data, SIGNAL(showEditedDBUpdate(TvShow*,const QString&)), this, SLOT(onShowEditedDBUpdate(TvShow*, const QString&)));

    QSqlDatabase db = QSqlDatabase::addDatabase( "QSQLITE" );

    QString path = QStandardPaths::standardLocations(QStandardPaths::DataLocation).at(0);
    if (!QFile::exists(path)) {
        QDir dir;
        dir.mkpath(path);
    }

    path.append(QDir::separator()).append("data.db");
    path = QDir::toNativeSeparators(path);

    db.setDatabaseName(path);

    if( !db.open() )
    {
      qDebug() << db.lastError();
    }

    qDebug( "Connected!" );

    QSqlQuery qry;

    qry.prepare( "CREATE TABLE IF NOT EXISTS "+currTable+" (name VARCHAR(30) UNIQUE PRIMARY KEY, season INTEGER, episode INTEGER, "
                   "genre VARCHAR(30), started DATE, status VARCHAR(30), airtime VARCHAR(35), network VARCHAR(30), "
                   "latestepisode DATE, nextepisode DATE, imageurl VARCHAR(70))" );
    if( !qry.exec() )
    {
        qDebug() << qry.lastError();
        QErrorMessage errorMessage;
        errorMessage.showMessage("Unable to load database. Please delete data.db and restart Watchlist.");
        errorMessage.exec();
        QString path = QStandardPaths::standardLocations(QStandardPaths::DataLocation).at(0);
        QDesktopServices::openUrl(QUrl("file:///" + path));
    }
    else
        qDebug() << "Main datatable created/loaded!";

    // Check if "data" is an old database-version and update it in case

    if( !checkForOldDatabase(qry, checkTableStructure(qry, currTable)) )
        qDebug() << "ERROR while creating new Database Table";

}

Database::~Database()
{
    QSqlQuery qry;

    // checks if database was renamed at some point and renames it back to data
    // renaming happens when watchlist is started with an old database-version

    if(currTable != "data")
    {
        qry.prepare("ALTER TABLE "+currTable+" RENAME TO data");
        if(!qry.exec())
        {
            qDebug() << qry.lastError();
            qDebug() << "ERROR when renaming Table to data";
        }

        qDebug() << "Resetting Table name to 'Data'";
    }
}

// Adds Show to Database. This method is only called when all Information is already loaded
void Database::addShow(TvShow &show) {

    QSqlQuery qry;

    qry.prepare( "INSERT INTO "+currTable+" (name, season, episode, genre, started, status, airtime, network, latestepisode, "
                 "nextepisode, imageurl) VALUES (:name, 1, 1, :genre, :started, :status, :airtime, :network, "
                 ":latestepisode, :nextepisode, :imageurl)" );
    qry.bindValue(":name", show.getTitle());
    qry.bindValue(":genre", show.getGenre());
    qry.bindValue(":started", show.getStarted());
    qry.bindValue(":status", show.getStatus());
    qry.bindValue(":airtime", show.getAirtime());
    qry.bindValue(":network", show.getNetwork());
    qry.bindValue(":latestepisode", show.getLatestEpisode());
    qry.bindValue(":nextepisode", show.getNextEpisode());
    qry.bindValue(":imageurl", show.getImageUrl());

    if( !qry.exec() )
        qDebug() << qry.lastError();
    else
        qDebug() << show.getTitle() + " inserted!";

}


// Delete show from Database
void Database::removeShow(QString name) {

    QSqlQuery qry;

    qry.prepare( "DELETE FROM "+currTable+" WHERE name=:name");
    qry.bindValue(":name",name);
      if( !qry.exec() )
        qDebug() << qry.lastError();
      else
        qDebug() << name + " deleted!";
}

bool Database::alterShowName(QString oldName,QString newName){

    QSqlQuery qry;

    qry.prepare( "UPDATE "+currTable+" SET name=:newName WHERE name=:oldName" );
    qry.bindValue(":oldName",oldName);
    qry.bindValue(":newName",newName);
      if( !qry.exec() ) {
        qDebug() << qry.lastError();
        return false;
      }
      else
      {
        qDebug() << "Name of "+ oldName + " changed to " + newName;
        return true;
    }
}

void Database::alterSeason(QString name,int delta){

    QSqlQuery qry;

    qry.prepare( "UPDATE "+currTable+" SET season=season+:delta WHERE name=:number" );
    qry.bindValue(":delta",QString::number(delta));
    qry.bindValue(":name",name);
      if( !qry.exec() )
        qDebug() << qry.lastError();
      else
        qDebug() << "Season of "+ name + " changed";

}
void Database::alterEpisode(QString name,int delta){

    QSqlQuery qry;

    qry.prepare( "UPDATE "+currTable+" SET episode=episode+:delta WHERE name=:name");
    qry.bindValue(":delta", QString::number(delta));
    qry.bindValue(":name", name);
      if( !qry.exec() )
        qDebug() << qry.lastError();
      else
          qDebug() << "Episode of "+ name + " changed";
}

void Database::updateShow(TvShow &show)
{
    QSqlQuery qry;
    qry.prepare( "UPDATE "+currTable+" SET genre=:genre, started=:started, status=:status, airtime=:airtime, network=:network, "
                 "latestepisode=:latestep ,nextepisode=:nextep, imageurl=:imageurl WHERE name=:name" );
    qry.bindValue(":name", show.getTitle());
    qry.bindValue(":genre", show.getGenre());
    qry.bindValue(":started", show.getStarted());
    qry.bindValue(":status", show.getStatus());
    qry.bindValue(":airtime", show.getAirtime());
    qry.bindValue(":network", show.getNetwork());
    qry.bindValue(":latestep", show.getLatestEpisode());
    qry.bindValue(":nextep", show.getNextEpisode());
    qry.bindValue(":imageurl", show.getImageUrl());

    if( !qry.exec() )
        qDebug() << qry.lastError();
}

// Loads Database into QList
void Database::load() {

    QSqlQuery qry;

    qry.prepare( "SELECT * FROM "+currTable+" ORDER BY name" );
    if( !qry.exec() )
        qDebug() << qry.lastError();
    else
    {
        for( int r=0; qry.next(); r++ ) {

            // Show gets all information out of Database, no API-Information is retrieved
            TvShow* tv = new TvShow(qry.value(0).toString(), qry.value(1).toInt(0), qry.value(2).toInt(0),
                                    qry.value(3).toString(), qry.value(4).toString(), qry.value(5).toString(),
                                    qry.value(6).toString(), qry.value(7).toString(), qry.value(8).toString(),
                                    qry.value(9).toString(), qry.value(10).toString());
            // Adds show to QList
            tv->checkForNewEpisodes();
            data->addShow(*tv);
        }
      }

      // Database is Loaded, check for API-Information now (only if Database is not empty)
    if (data->size() > 0) {
        emit dbLoaded();
    }
}


// Returns a string that contains the name of every column in the table
QString Database::checkTableStructure(QSqlQuery &qry, const QString &tablename)
{
    QString tableStructure="";
    qry.finish();
    qry.prepare("PRAGMA table_info ("+tablename+")");
    if(!qry.exec())
    {
        qDebug() << qry.lastError();
        qry.finish();
        return " ";
    }
    else
    {
        // Read result into String
        while (qry.next())
        {
            tableStructure+=qry.value(1).toString()+" ";
        }

        qry.finish();

        return tableStructure;
    }
}


// Adds missing columns to old databases
bool Database::checkForOldDatabase(QSqlQuery &qry, const QString& tableStructure)
{
    if(!tableStructure.contains("imageurl"))
    {
        qDebug() << "Old Database! Converting to new one";

        // Get new names for tables
        getNewTableNames();

        // Adds a new Table to Database

        qry.prepare("CREATE TABLE IF NOT EXISTS "+currTable+" (name VARCHAR(30) UNIQUE PRIMARY KEY, season INTEGER, episode INTEGER, "
                    "genre VARCHAR(30), started DATE, status VARCHAR(30), airtime VARCHAR(35), network VARCHAR(30), "
                    "latestepisode DATE, nextepisode DATE, imageurl VARCHAR(70)) ");
        if(!qry.exec())
        {
            qDebug() << "Creating new Table failed";
            qDebug() << qry.lastError();
            return false;
        }


        // Insert all columns from old table into new one

        qry.prepare("INSERT INTO "+currTable+" (name, season, episode, genre) SELECT name, season, episode, genre FROM "+oldTable);
        if(!qry.exec())
        {
            qDebug() << "Inserting failed";
            qDebug() << qry.lastError();
            return false;
        }


        // Delete old table

        qry.prepare("DROP TABLE "+oldTable);
        if(!qry.exec())
        {
            qDebug() << "Deleting failed";
            qDebug() << qry.lastError();
            return false;
        }
        else
            return true;
    }

    // database has right form
    else
        return true;
}


// Fill in Show in QList
void Database::onAllDataLoaded(TvShow* show)
{
    //update Database
    updateShow(*show);
    //Fill in QList
    this->data->addShow(*show);
}

void Database::onShowEditedDBUpdate(TvShow *show, const QString& oldName)
{
    alterShowName(oldName, show->getTitle());
    updateShow(*show);
}


// Renames Tables in order to copy and then delete old table
void Database::getNewTableNames()
{
    oldTable = currTable;
    currTable += "1";
}


