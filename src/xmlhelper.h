#ifndef XMLHELPER_H
#define XMLHELPER_H
#include <QtNetwork/QNetworkAccessManager>
#include <QUrl>
#include <QtNetwork/QNetworkRequest>
#include <QtNetwork/QNetworkReply>
#include <QtXml/QDomDocument>
#include "xmlpictureloader.h"



class xmlHelper: public QObject
{
     Q_OBJECT

public:
     explicit xmlHelper(QObject *parent = 0);
    QNetworkAccessManager* nam;
    QString getImageUrl() {return xmlPicture_->imageUrl;}
    XmlPictureLoader *xmlPicture_;
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
public slots:
    void finishedSlot(QNetworkReply*);
    void createConnection(QString showName);

private:

    QDomNodeList list;

};

#endif // XMLHELPER_H
