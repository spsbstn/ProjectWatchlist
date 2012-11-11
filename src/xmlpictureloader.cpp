#include "xmlpictureloader.h"
#include <QtDebug>
#include <QDate>
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
        list=doc.elementsByTagName("airdate");

        QDate now = QDate::currentDate();
        QDate airDate;
        QDomNodeList namelist=doc.elementsByTagName("title");
       QDomNodeList episodeNumberlist=doc.elementsByTagName("seasonnum");

        for (int i = 0;list.length();i++){

            airDate = QDate::fromString(list.at(i).toElement().text(),"yyyy-MM-dd");

            if(airDate.operator > (now) || i==list.length()){

                latestEpisode = namelist.at(i-2).toElement().text()+" ("+episodeNumberlist.at(i-2).toElement().text()+")";
                airdateLatestEpisode = list.at(i-2).toElement().text();
                break;
            }


        }

        emit updateFinished();

    }

    else
    {
        qDebug() << "ERROR: Http-Error occurred";
    }

    reply->deleteLater();
}
