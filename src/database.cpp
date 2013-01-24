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

// Set Database Location depending on Operating System
#ifdef Q_OS_WIN32

  db.setDatabaseName( "./data.db" );

#else // OS is not Windows
  QString path = QDesktopServices::storageLocation(QDesktopServices::DataLocation);
  if (!QFile::exists(path)) {
          QDir dir;
          dir.mkpath(path);
      }
      path.append(QDir::separator()).append("data.db");
      path = QDir::toNativeSeparators(path);

      db.setDatabaseName(path);
#endif

      if( !db.open() )
      {
        qDebug() << db.lastError();

      }

      qDebug( "Connected!" );

      QSqlQuery qry;

      qry.prepare( "CREATE TABLE IF NOT EXISTS data (name VARCHAR(30) UNIQUE PRIMARY KEY, season INTEGER, episode INTEGER, genre VARCHAR(30))" );
        if( !qry.exec() )
          {
                qDebug() << qry.lastError();

                QErrorMessage errorMessage;
                errorMessage.showMessage("Unable to load database. Please delete data.db manually.");
                errorMessage.exec();
        }
        else
          qDebug() << "datatable created!";
}

void Database::addShow(QString name, QString genre) {

    QSqlQuery qry;

    qry.prepare( "INSERT INTO data (name, season, episode, genre) VALUES (:name, 1, 1,:genre)");
    qry.bindValue(":name",name);
    qry.bindValue(":genre",genre);
      if( !qry.exec() )
        qDebug() << qry.lastError();
      else
          qDebug() << name + " with genre " + genre + " inserted!";

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
void Database::alterGenre(QString name,QString genre){

    QSqlQuery qry;

    qry.prepare( "UPDATE data SET genre=:genre WHERE name=:name");
    qry.bindValue(":name",name);
    qry.bindValue(":genre",genre);
      if( !qry.exec() )
        qDebug() << qry.lastError();
      else
        qDebug() << "Genre of "+ name + " changed";
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
}


