#ifndef QUICKINFO_H
#define QUICKINFO_H
#include <QtNetwork/QNetworkAccessManager>
#include <QUrl>
#include <QtNetwork/QNetworkRequest>
#include <QtNetwork/QNetworkReply>
#include <QMap>
#include "xmlpictureloader.h"

/*
 * QuickInfo class connects to Tv Rage API at http://services.tvrage.com/tools/quickinfo.php?show=SHOW_TITLE
 * and loads information into showInfo - HashMap
 */


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
    void onImageUrlLoaded(const QString& imageUrl);

signals:
    void showInfoFilled();
    void htmlErrorOccured();
    void apiErrorOccured();
    void showEdited(bool, const QString&);
};


#endif // QUICKINFO_H
