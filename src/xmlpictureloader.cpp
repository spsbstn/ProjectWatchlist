#include "xmlpictureloader.h"
#include <QtDebug>
#define URL_BASE "http://services.tvrage.com/feeds/full_show_info.php?sid="

XmlPictureLoader::XmlPictureLoader(QObject *parent) :
    QObject(parent)
{
    nam = new QNetworkAccessManager(this);
    QObject::connect(nam, SIGNAL(finished(QNetworkReply*)),this, SLOT(finishedSlot(QNetworkReply*)));
}

void XmlPictureLoader::createConnection(QString showId)
{
    QUrl url(URL_BASE+ showId);
    QNetworkReply* reply = nam->get(QNetworkRequest(url));
}

void XmlPictureLoader::finishedSlot(QNetworkReply* reply)
{

    if (reply->error() == QNetworkReply::NoError)
    {

        QByteArray bytes = reply->readAll();
        QString string = QString::fromUtf8(bytes);;
        QDomDocument doc;
        doc.setContent(string);
        //access elements
        list=doc.elementsByTagName("image");
        imageUrl=list.at(0).toElement().text();

        emit updateFinished();

    }

    else
    {
        qDebug() << "ERROR: Http-Error occurred";
    }

    reply->deleteLater();
}
