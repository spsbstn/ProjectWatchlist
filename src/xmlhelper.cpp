#include "xmlHelper.h"
#include <QtDebug>
#define URL_BASE "http://services.tvrage.com/feeds/full_search.php?show="


xmlHelper::xmlHelper(QObject *parent) : QObject(parent)
{
    nam = new QNetworkAccessManager(this);
    QObject::connect(nam, SIGNAL(finished(QNetworkReply*)),this, SLOT(finishedSlot(QNetworkReply*)));
}

void xmlHelper::createConnection(QString showName)
{
    qDebug() << showName;
    QUrl url(URL_BASE+ showName);
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
        //access elements
        list=doc.elementsByTagName("name");
        name=list.at(0).toElement().text();
        list=doc.elementsByTagName("status");
        status=list.at(0).toElement().text();
        list=doc.elementsByTagName("showid");
        showid=list.at(0).toElement().text();
        list=doc.elementsByTagName("started");
        started=list.at(0).toElement().text();
        list=doc.elementsByTagName("seasons");
        totalSeasons=list.at(0).toElement().text();
        list=doc.elementsByTagName("airday");
        airday=list.at(0).toElement().text();
        list=doc.elementsByTagName("airtime");
        airtime=list.at(0).toElement().text();
        list=doc.elementsByTagName("network");
        network=list.at(0).toElement().text();
        list=doc.elementsByTagName("genre");
        genre=list.at(0).toElement().text();

        emit updateFinished();
    }

    else
    {
        qDebug() << "ERROR: Http-Error occurred";
    }

    reply->deleteLater();
}
