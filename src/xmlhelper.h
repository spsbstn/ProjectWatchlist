#ifndef XMLHELPER_H
#define XMLHELPER_H
#include <QtNetwork/QNetworkAccessManager>
#include <QUrl>
#include <QtNetwork/QNetworkRequest>
#include <QtNetwork/QNetworkReply>
#include <QtXml/QDomDocument>


class xmlHelper: public QObject
{
     Q_OBJECT

public:
     explicit xmlHelper(QObject *parent = 0);
    QNetworkAccessManager* nam;
public slots:
    void finishedSlot(QNetworkReply*);
    void createConnection(QString showName);

private:
    QString name;
    QString started;
    QString totalSeasons;
    QString showid;
    QString status;
    QString airday;
    QString airtime;
    QString network;
    QString genre;
    QString link;
    QString imageUrl;

    QDomNodeList list;

signals:

    void updateFinished();

};

#endif // XMLHELPER_H
