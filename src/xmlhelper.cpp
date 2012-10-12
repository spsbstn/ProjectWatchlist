#include "xmlhelper.h"
#include <QtDebug>


xmlHelper::xmlHelper(QObject *parent) : QObject(parent)
{
    nam = new QNetworkAccessManager(this);
    QObject::connect(nam, SIGNAL(finished(QNetworkReply*)),this, SLOT(finishedSlot(QNetworkReply*)));
}

void xmlHelper::createConnection(QString uri)
{
    QUrl url(uri);
    QNetworkReply* reply = nam->get(QNetworkRequest(url));
}

void xmlHelper::finishedSlot(QNetworkReply* reply)
{

    if (reply->error() == QNetworkReply::NoError)
    {

        QByteArray bytes = reply->readAll();
        QString string = QString::fromUtf8(bytes);;
        QDomDocument doc;
        doc.setContent(string);
        QDomNodeList list=doc.elementsByTagName("name");
        QString name=list.at(0).toElement().text();
        qDebug() << name;
    }

    else
    {
        qDebug() << "ERROR: Http-Error occurred";
    }

    reply->deleteLater();
}
