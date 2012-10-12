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
    void createConnection(QString uri);
public slots:
    void finishedSlot(QNetworkReply*);
};

#endif // XMLHELPER_H
