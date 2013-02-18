#ifndef QUICKINFO_H
#define QUICKINFO_H
#include <QtNetwork/QNetworkAccessManager>
#include <QUrl>
#include <QtNetwork/QNetworkRequest>
#include <QtNetwork/QNetworkReply>
#include <QMap>
#include "xmlpictureloader.h"

class QuickInfo: public QObject
{
     Q_OBJECT

public:

    explicit QuickInfo(QObject *parent = 0);
    ~QuickInfo();
    QNetworkAccessManager* nam;
    QMap<QString, QString>* showInfo;
    XmlPictureLoader *xmlPicture_;

    QString getImageUrl() {return xmlPicture_->imageUrl;}

public slots:
    void finishedSlot(QNetworkReply*);
    void createConnection(QString showName);

signals:
    void showInfoFilled();
    void htmlErrorOccured();
};


#endif // QUICKINFO_H
