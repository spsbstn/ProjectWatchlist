#include "database.h"

#include <QtSql>
#include <QtDebug>
#include <QErrorMessage>
#include <QDesktopServices>
#include "tvshow.h"


//init or load database
Database::Database(QObject *parent) :
    QObject(parent),
    data(new TvShowData()),
    currTable("data"),
    oldTable("not used")
{

    QSqlDatabase db = QSqlDatabase::addDatabase( "QSQLITE" );

    QString path = QDesktopServices::storageLocation(QDesktopServices::DataLocation);
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
        QString path = QDesktopServices::storageLocation(QDesktopServices::DataLocation);
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
    else
        qDebug() << "Updated: " + show.toString();
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

            TvShow* tv = new TvShow(qry.value(0).toString(), qry.value(1).toInt(0), qry.value(2).toInt(0),
                                    qry.value(3).toString(), qry.value(4).toString(), qry.value(5).toString(),
                                    qry.value(6).toString(), qry.value(7).toString(), qry.value(8).toString(),
                                    qry.value(9).toString(), qry.value(10).toString());

            data->addShow(*tv);
            qDebug() << tv->toString();
        }
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
        while (qry.next())
            tableStructure+=qry.value(1).toString()+" ";

        qry.finish();

        return tableStructure;
    }
}


// Adds missing columns to old databases
bool Database::checkForOldDatabase(QSqlQuery &qry, const QString& tableStructure)
{
    //qDebug() << tableStructure;

    if(!tableStructure.contains("imageurl"))
    {
        qDebug() << "Old Database! Converting to new one";

        //get new names for tables
        getNewTableNames();

        qry.prepare("CREATE TABLE IF NOT EXISTS "+currTable+" (name VARCHAR(30) UNIQUE PRIMARY KEY, season INTEGER, episode INTEGER, "
                    "genre VARCHAR(30), started DATE, status VARCHAR(30), airtime VARCHAR(35), network VARCHAR(30), "
                    "latestepisode DATE, nextepisode DATE, imageurl VARCHAR(70)) ");
        if(!qry.exec())
        {
            qDebug() << "Creating new Table failed";
            qDebug() << qry.lastError();
            return false;
        }

        qry.prepare("INSERT INTO "+currTable+" (name, season, episode, genre) SELECT name, season, episode, genre FROM "+oldTable);
        if(!qry.exec())
        {
            qDebug() << "Inserting failed";
            qDebug() << qry.lastError();
            return false;
        }

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
    else
        return true;
}

// Fill in Show in QList
void Database::onAllDataLoaded(TvShow* show)
{
    updateShow(*show);
}

void Database::getNewTableNames()
{
    oldTable = currTable;
    currTable += "1";
}


