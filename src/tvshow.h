#ifndef TvShow_H
#define TvShow_H

#include <QObject>
#include <QString>

class QuickInfo;

#define OLD_SEASON -1


class TvShow : public QObject
{
    Q_OBJECT

public:
    // constructor with default values
    TvShow(QString name = "", int seas = 1, int ep = 1 );

    // set all the members individually
    void setTitle  (const QString& name) { title = name; }
    void setSeason (int delta)           { season += delta; }
    void setEpisode(int delta)           { episode += delta; }
    void setStarted(const QString& started) { this->started = started; }
    void setStatus(const QString& status) { this->status = status; }
    void setAirtime(const QString& airtime) { this->airtime = airtime; }
    void setNetwork(const QString& network) { this->network = network; }
    void setGenre(const QString& genre) { this->genre = genre; }
    void setLatestEpisode(const QString& latestEp) { latestEpisode = latestEp; }
    void setNextEpisode(const QString& nextEp) { nextEpisode = nextEp; }

    // getter-functions
    QString getTitle() const { return title; }
    int    getSeason() const { return season; }
    int   getEpisode() const { return episode; }
    QString getStarted() const { return started;}
    QString getStatus() const { return status;}
    QString getAirtime() const { return airtime;}
    QString getNetwork() const { return network;}
    QString getGenre() const { return genre;}
    QString getLatestEpisode() const { return latestEpisode;}
    QString getNextEpisode() const { return nextEpisode;}


    // Return string for printing TvShow to console
    QString toString() const;


private:
    QString title;
    int     season;
    int     episode;
    QString started;
    QString status;
    QString airtime;
    QString network;
    QString genre;
    QString latestEpisode;
    QString nextEpisode;

    QuickInfo* info;

    //prevent copy-constructors:
    TvShow(const TvShow&);
    TvShow& operator = (const TvShow&);

};

#endif // TvShow_H
