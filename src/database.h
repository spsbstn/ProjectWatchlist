#ifndef DATABASE_H
#define DATABASE_H
#include <QObject>
#include "tvshow.h"
#include "tvshowdata.h"
#include <QtSql>

class Database : public QObject
{
    Q_OBJECT

public:
    explicit Database(QObject *parent = 0);
    ~Database();

    void addShow(TvShow &show);
    void removeShow(QString name);
    void alterSeason(QString name,int delta);
    bool alterShowName(QString oldName,QString newName);
    void alterEpisode(QString name,int delta);
    void updateShow(TvShow &show);
    void load();
    QString checkTableStructure(QSqlQuery& qry, const QString &tablename);
    bool checkForOldDatabase(QSqlQuery& qry, const QString &tableStructure);

    TvShowData* data;

public slots:
    void onAllDataLoaded(TvShow *show);

signals:
    void dbLoaded();

private:
    QString currTable;
    QString oldTable;
    void getNewTableNames();
};

#endif // DATABASE_H
