#ifndef TvShow_H
#define TvShow_H

#include <QObject>

class QuickInfo;
class QString;

#define OLD_SEASON -1

/*
 * TvShow Object which holds all relevant information of a TvShow.
 * QuickInfo member connects to TvRage API in order to load Data such as
 * next/latest episodes, airtime, start date, and more.
 */

class TvShow : public QObject
{
    Q_OBJECT

public:
    // constructor with default values (is used when first adding show)
    TvShow(QString name = "", int seas = 1, int ep = 1 );
    // constructor with no default values (is used when loading from database)
    TvShow(QString name, int seas, int ep, QString genre, QString started, QString status, QString airtime,
           QString network, QString latestEp, QString nextEp, QString imageUrl);
    // destructor
    ~TvShow();

    // set all the members individually
    void setTitle  (const QString& name) { title = name; }
    void setSeason (int delta)           { season += delta; }
    void setEpisode(int delta)           { episode += delta; }
    void setGenre(const QString& genre) { this->genre = genre; }
    void setStarted(const QString& started) { this->started = started; }
    void setStatus(const QString& status) { this->status = status; }
    void setAirtime(const QString& airtime) { this->airtime = airtime; }
    void setNetwork(const QString& network) { this->network = network; }
    void setLatestEpisode(const QString& latestEp) { latestEpisode = latestEp; }
    void setNextEpisode(const QString& nextEp) { nextEpisode = nextEp; }
    void setImageUrl(const QString& imageUrl) { this->imageUrl = imageUrl;}
    void setNewEpisodesAvailable(const bool newEp) { newEpisodeAvailable = newEp; }

    // getter-functions
    QString getTitle() const { return title; }
    int    getSeason() const { return season; }
    int   getEpisode() const { return episode; }
    QString getGenre() const { return genre;}
    QString getStarted() const { return started;}
    QString getStatus() const { return status;}
    QString getAirtime() const { return airtime;}
    QString getNetwork() const { return network;}
    QString getLatestEpisode() const { return latestEpisode;}
    QString getNextEpisode() const { return nextEpisode;}
    QString getImageUrl() const { return imageUrl;}
    bool    getNewEpisodesAvailable() const { return newEpisodeAvailable;}

    // Return string for printing TvShow to console
    QString toString() const;

    // Returns the Date of the NextEpisode-String
    QString getNextEpisodeDate() const;

    // Load extra information for show
    void getExtraInformation();

    QuickInfo* info;

public slots:
    // Fills API-information into TvShow - Variables
    void onShowInfoFilled();
    void debugString(TvShow* show);
    void checkForNewEpisodes();


    //void onEveryShowLoaded();

signals:
    // Signals, that Show can now be inserted to QList
    void allDataLoaded(TvShow*);
    void apiError();


private:
    QString title;
    int     season;
    int     episode;
    QString genre;
    QString started;
    QString status;
    QString airtime;
    QString network;
    QString latestEpisode;
    QString nextEpisode;
    QString imageUrl;
    bool    newEpisodeAvailable;

    //prevent copy-constructors:
    TvShow(const TvShow&);
    TvShow& operator = (const TvShow&);

};

#endif // TvShow_H
