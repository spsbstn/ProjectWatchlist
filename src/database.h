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
    void addShow(QString name, QString genre);
    void removeShow(QString name);
    void alterSeason(QString name,int delta);
    bool alterShowName(QString oldName,QString newName);
    void alterEpisode(QString name,int delta);
    void alterGenre(QString name,QString genre);
    void load();
    TvShowData* data;
};

#endif // DATABASE_H
