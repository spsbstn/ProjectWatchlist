#include "database.h"

#include <QtSql>
#include <QtDebug>
#include "tvshow.h"

//init or load database
Database::Database(QObject *parent) :
    QObject(parent),
    data(new TvShowData())
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
            closeDatabase();

}

void Database::removeShow(QString name) {

    QSqlQuery qry;

    qry.prepare( "DELETE FROM data WHERE name='"+name+"'" );
      if( !qry.exec() )
        qDebug() << qry.lastError();
      else
        qDebug() << name + " deleted!";
            closeDatabase();
}

void Database::alterSeason(QString name,int delta){

    QSqlQuery qry;

    qry.prepare( "UPDATE data SET season=season+"+QString::number(delta)+" WHERE name='"+name+"'" );
      if( !qry.exec() )
        qDebug() << qry.lastError();
      else
        qDebug() << "Season of "+ name + " changed to don�t know hot wo properly get paraneter =).";
            closeDatabase();

}
void Database::alterEpisode(QString name,int delta){

    QSqlQuery qry;

    qry.prepare( "UPDATE data SET episode=episode+"+QString::number(delta)+" WHERE name='"+name+"'" );
      if( !qry.exec() )
        qDebug() << qry.lastError();
      else
        qDebug() << "Episode of "+ name + " changed to something else =).";
            closeDatabase();
}
void Database::alterGenre(QString name,QString genre){

    QSqlQuery qry;

    qry.prepare( "UPDATE data SET genre='"+genre+"' WHERE name='"+name+"'" );
      if( !qry.exec() )
        qDebug() << qry.lastError();
      else
        qDebug() << "Genre of "+ name + " changed to something else =) ";
        closeDatabase();
}

void Database::load() {

    QSqlQuery qry;

    qry.prepare( "SELECT * FROM data ORDER BY name" );
      if( !qry.exec() )
        qDebug() << qry.lastError();
      else
      {
        for( int r=0; qry.next(); r++ ) {

            TvShow* tv = new TvShow(qry.value(0).toString(),qry.value(1).toInt(0),qry.value(2).toInt(0),qry.value(3).toString());
            data->addShow(*tv);
        }
      }
      closeDatabase();
}

void Database::closeDatabase() {

    QString connName;
    {
      QSqlDatabase db = QSqlDatabase::database();
      connName = db.connectionName();
    }

    QSqlDatabase::removeDatabase(connName);

}
