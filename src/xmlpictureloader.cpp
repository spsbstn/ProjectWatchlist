#include "xmlpictureloader.h"
#include <QtDebug>
#include <QDate>
#define URL_BASE "http://services.tvrage.com/feeds/full_show_info.php?sid="

XmlPictureLoader::XmlPictureLoader(QObject *parent) :
    QObject(parent)
{
    // create networkAccessManager
    nam = new QNetworkAccessManager(this);

    //connect signal and slot  --> request finished
    QObject::connect(nam, SIGNAL(finished(QNetworkReply*)),this, SLOT(finishedSlot(QNetworkReply*)));
}

XmlPictureLoader::~XmlPictureLoader()
{
    delete nam;
}

// create connection to server
void XmlPictureLoader::createConnection(QString showId)
{
    //open url (base + showNId)
    QUrl url(URL_BASE+ showId);

    // serverReply
    QNetworkReply* reply = nam->get(QNetworkRequest(url));
}

// work with serverReply
void XmlPictureLoader::finishedSlot(QNetworkReply* reply)
{

    if (reply->error() == QNetworkReply::NoError)
    {

         //convert reply to QDomDocument
        QByteArray bytes = reply->readAll();
        QString string = QString::fromUtf8(bytes);;
        QDomDocument doc;
        doc.setContent(string);

        //access elements by tag
        list=doc.elementsByTagName("image");

        // get imageUrl
        imageUrl=list.at(0).toElement().text();

    }

    else
    {
        qDebug() << "ERROR: Http-Error occurred";
    }

    // emit signal that all data is retrieved
    emit updateFinished();

    // delete reply
    reply->deleteLater();
}
