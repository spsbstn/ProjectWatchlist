#include "database.h"

#include <QtSql>
#include <QtDebug>
#include "tvshow.h"

//init or load database
Database::Database(QObject *parent) :
    QObject(parent),
    data()
{

  QSqlDatabase db = QSqlDatabase::addDatabase( "QSQLITE" );

      db.setDatabaseName( "./data.db" );

      if( !db.open() )
      {
        qDebug() << db.lastError();
        qFatal( "Failed to connect." );
      }

      qDebug( "Connected!" );

      QSqlQuery qry;

      qry.prepare( "CREATE TABLE IF NOT EXISTS data (name VARCHAR(30) UNIQUE PRIMARY KEY, season INTEGER, episode INTEGER, genre VARCHAR(30))" );
        if( !qry.exec() )
          qDebug() << qry.lastError();
        else
          qDebug() << "Main-Table created!";

}

void Database::addShow(QString name) {

    QSqlQuery qry;

    qry.prepare( "INSERT INTO data (name, season, episode, genre) VALUES ('"+name+"', 1, 1,'No Genre')" );
      if( !qry.exec() )
        qDebug() << qry.lastError();
      else
        qDebug() << name + " inserted!";

}

void Database::removeShow(QString name) {

    QSqlQuery qry;

    qry.prepare( "DELETE FROM data WHERE name='"+name+"'" );
      if( !qry.exec() )
        qDebug() << qry.lastError();
      else
        qDebug() << name + " deleted!";
}

void Database::alterSeason(QString name,int season){

    QSqlQuery qry;

    qry.prepare( "UPDATE data SET season="+QString::number(season)+" WHERE name='"+name+"'" );
      if( !qry.exec() )
        qDebug() << qry.lastError();
      else
        qDebug() << "Season of "+ name + " changed to " +QString::number(season);

}
void Database::alterEpisode(QString name,int episode){

    QSqlQuery qry;

    qry.prepare( "UPDATE data SET episode="+QString::number(episode)+" WHERE name='"+name+"'" );
      if( !qry.exec() )
        qDebug() << qry.lastError();
      else
        qDebug() << "Episode of "+ name + " changed to " + QString::number(episode);
}
void Database::alterGenre(QString name,QString genre){

    QSqlQuery qry;

    qry.prepare( "UPDATE data SET genre='"+genre+"' WHERE name='"+name+"'" );
      if( !qry.exec() )
        qDebug() << qry.lastError();
      else
        qDebug() << "Genre of "+ name + " changed to " + genre;
}

void Database::getData() {

    QSqlQuery qry;

    qry.prepare( "SELECT * FROM data" );
      if( !qry.exec() )
        qDebug() << qry.lastError();
      else
      {
        for( int r=0; qry.next(); r++ ) {

            TvShow* tv = new TvShow(qry.value(1).toString(),qry.value(2).toInt(0),qry.value(3).toInt(0),qry.value(4).toString());
            //save TvShowObejects to data :)
        }
      }
}

