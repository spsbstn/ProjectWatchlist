#include "database.h"

#include <QtSql>
#include <QtDebug>
#include <QErrorMessage>
#include <QDesktopServices>
#include "tvshow.h"


//init or load database
Database::Database(QObject *parent) :
    QObject(parent),
    data(new TvShowData())
{

    QSqlDatabase db = QSqlDatabase::addDatabase( "QSQLITE" );

    QString path = QDesktopServices::storageLocation(QDesktopServices::DataLocation);
    if (!QFile::exists(path)) {
        QDir dir;
        dir.mkpath(path);
    }

    path.append(QDir::separator()).append("datav2.db");
    path = QDir::toNativeSeparators(path);

    db.setDatabaseName(path);

    if( !db.open() )
    {
      qDebug() << db.lastError();
    }

    qDebug( "Connected!" );

    QSqlQuery qry;

    qry.prepare( "CREATE TABLE IF NOT EXISTS data (name VARCHAR(30) UNIQUE PRIMARY KEY, season INTEGER, episode INTEGER, "
                   "started DATE, status VARCHAR(30), airtime VARCHAR(35), network VARCHAR(30), genre VARCHAR(30), "
                   "latestepisode DATE, nextepisode DATE, imageurl VARCHAR(50))" );
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
        qDebug() << "datatable created/loaded!";

    // Check if "data" is an old database-version and update it in case
    if( !alterTable(qry, checkTableStructure(qry)) )
        qDebug() << "ERROR while altering Database Table";

}

void Database::addShow(TvShow &show) {

    QSqlQuery qry;

    qry.prepare( "INSERT INTO data (name, season, episode, started, status, airtime, network, genre, latestepisode, "
                 "nextepisode, imageurl) VALUES (:name, 1, 1, :started, :status, :airtime, :network, :genre, :latestepisode, "
                 ":nextepisode, :imageurl)" );
    qry.bindValue(":name", show.getTitle());
    qry.bindValue(":started", show.getStarted());
    qry.bindValue(":status", show.getStatus());
    qry.bindValue(":airtime", show.getAirtime());
    qry.bindValue(":network", show.getNetwork());
    qry.bindValue(":genre", show.getGenre());
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

    qry.prepare( "DELETE FROM data WHERE name=:name");
    qry.bindValue(":name",name);
      if( !qry.exec() )
        qDebug() << qry.lastError();
      else
        qDebug() << name + " deleted!";
}

bool Database::alterShowName(QString oldName,QString newName){

    QSqlQuery qry;

    qry.prepare( "UPDATE data SET name=:newName WHERE name=:oldName" );
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

    qry.prepare( "UPDATE data SET season=season+:delta WHERE name=:number" );
    qry.bindValue(":delta",QString::number(delta));
    qry.bindValue(":name",name);
      if( !qry.exec() )
        qDebug() << qry.lastError();
      else
        qDebug() << "Season of "+ name + " changed";

}
void Database::alterEpisode(QString name,int delta){

    QSqlQuery qry;

    qry.prepare( "UPDATE data SET episode=episode+:delta WHERE name=:name");
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
    qry.prepare( "UPDATE data SET started=:started, status=:status, airtime=:airtime, network=:network, genre=:genre, "
                 "latestepisode=:latestep ,nextepisode=:nextep, imageurl=:imageurl WHERE name=:name" );
    qry.bindValue(":name", show.getTitle());
    qry.bindValue(":started", show.getStarted());
    qry.bindValue(":status", show.getStatus());
    qry.bindValue(":airtime", show.getAirtime());
    qry.bindValue(":network", show.getNetwork());
    qry.bindValue(":genre", show.getGenre());
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

    qry.prepare( "SELECT * FROM data ORDER BY name" );
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

QString Database::checkTableStructure(QSqlQuery &qry)
{
    QString tableStructure="";
    qry.finish();
    qry.prepare("PRAGMA table_info (data)");
    if(!qry.exec())
    {
        qDebug() << qry.lastError();
        return " ";
    }
    else
    {
        while (qry.next())
            tableStructure+=qry.value(1).toString()+" ";

        return tableStructure;
    }
}

bool Database::alterTable(QSqlQuery &qry, const QString& tableStructure)
{
    if(!tableStructure.contains("started")) // Old database version
    {
        //add started, status, ... , nextepisode to the table
        qry.prepare("ALTER TABLE data ADD COLUMN started DATE, status VARCHAR(30), airtime VARCHAR(35), "
                    "network VARCHAR(30), genre VARCHAR(30), latestepisode DATE, nextepisode DATE");
        if(!qry.exec())
            qDebug() << qry.lastError();
    }

    if(!tableStructure.contains("imageurl")) // v2_database
    {
        qry.prepare("ALTER TABLE data ADD COLUMN imageurl VARCHAR(50)");
        if(!qry.exec())
            qDebug() << qry.lastError();
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


