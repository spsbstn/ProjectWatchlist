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
                   "latestepisode DATE, nextepisode DATE)" );
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
}

void Database::addShow(TvShow &show) {

    QSqlQuery qry;

    qry.prepare( "INSERT INTO data (name, season, episode, started, status, airtime, network, genre, latestepisode, "
                 "nextepisode) VALUES (:name, 1, 1, :started, :status, :airtime, :network, :genre, :latestepisode, "
                 ":nextepisode)" );
    qry.bindValue(":name", show.getTitle());
    qry.bindValue(":started", show.getStarted());
    qry.bindValue(":status", show.getStatus());
    qry.bindValue(":airtime", show.getAirtime());
    qry.bindValue(":network", show.getNetwork());
    qry.bindValue(":genre", show.getGenre());
    qry.bindValue(":latestepisode", show.getLatestEpisode());
    qry.bindValue(":nextepisode", show.getNextEpisode());

    qDebug() << qry.boundValues();
	
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
                                    qry.value(9).toString());

            data->addShow(*tv);
            qDebug() << tv->toString();
            //Wait for all Data to be loaded before inserting it
            //QObject::connect(tv,SIGNAL(allDataLoaded(TvShow*)),this,SLOT(onAllDataLoaded(TvShow*)));

        }
      }
}

// Fill in Show in QList
void Database::onAllDataLoaded(TvShow* show)
{
    addShow(*show);
    data->addShow(*show);
}


