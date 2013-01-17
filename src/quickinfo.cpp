#include "quickinfo.h"
#include <QtDebug>
#define URL_BASE "http://services.tvrage.com/tools/quickinfo.php?show="

QuickInfo::QuickInfo(QObject *parent) : QObject(parent)
{
    // create networkAccessManager
    nam = new QNetworkAccessManager(this);

    //hashmap to save showInfo
    showInfo = new  QMap<QString, QString>;

    // instance of xmlPictureLoader
    xmlPicture_ = new XmlPictureLoader(this);

    //connect signal and slot  --> request finished
    QObject::connect(nam, SIGNAL(finished(QNetworkReply*)),this, SLOT(finishedSlot(QNetworkReply*)));

}

// create connection to server
void QuickInfo::createConnection(QString showName)
{
    //open url (base + showName)
    QUrl url(URL_BASE + showName);

    // serverReply
    QNetworkReply* reply = nam->get(QNetworkRequest(url));
}

// work with serverReply
void QuickInfo::finishedSlot(QNetworkReply* reply)
{

    if (reply->error() == QNetworkReply::NoError)
    {
        //clear hashmap
        showInfo->clear();

        //convert reply to string
        QByteArray bytes = reply->readAll();
        QString string = QString::fromUtf8(bytes);
        QTextStream strgStream(&string);

        // read string line by line
        while(!strgStream.atEnd())

        {
                QString line = strgStream.readLine();
                QString key;
                QString value;

                // find position of @
                int positionOfEquals = line.indexOf("@",0);

                //isolate key
                key = line;
                key = key.remove(positionOfEquals,line.length());

                //replace the <pre> in Show ID
                key.replace("<pre>","");

                //isolate value
                value = line;
                value = value.remove(0,positionOfEquals+1);

                //replace ^ in Next and Latest Episode
                value.replace("^"," ");

                // add to Hashmap
                showInfo->insert(key,value);

        }

        //load picture (showId of hashmap)
        xmlPicture_->createConnection(showInfo->value("Show ID"));
}

    else

    {
        qDebug() << "ERROR: Http-Error occurred";
        emit htmlErrorOccured();
    }

    //delete reply
    reply->deleteLater();
}
