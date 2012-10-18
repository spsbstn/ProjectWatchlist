#ifndef XMLPICTURELOADER_H
#define XMLPICTURELOADER_H
#include <QtNetwork/QNetworkAccessManager>
#include <QUrl>
#include <QtNetwork/QNetworkRequest>
#include <QtNetwork/QNetworkReply>
#include <QtXml/QDomDocument>

#include <QObject>

class XmlPictureLoader : public QObject
{
    Q_OBJECT
public:
    explicit XmlPictureLoader(QObject *parent = 0);
    QNetworkAccessManager* nam;
    void createConnection(QString showId);
    QString imageUrl;
    QDomNodeList list;

    

signals:

    void updateFinished();
    
public slots:
    void finishedSlot(QNetworkReply*);
    
};

#endif // XMLPICTURELOADER_H
