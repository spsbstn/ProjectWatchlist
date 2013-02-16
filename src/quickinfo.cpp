#include "quickinfo.h"
#include <QtDebug>
#include <QElapsedTimer>
#include <QEventLoop>

#define URL_BASE "http://services.tvrage.com/tools/quickinfo.php?show="

QuickInfo::QuickInfo(QObject *parent) : QObject(parent)
{
    // create networkAccessManager
    nam = new QNetworkAccessManager(this);

    //hashmap to save showInfo
    showInfo = new  QMap<QString, QString>;

    // instance of xmlPictureLoader
    xmlPicture_ = new XmlPictureLoader(this);
    qDebug() << "Quick Info initialised";

    //connect signal and slot  --> request finished
    QObject::connect(nam, SIGNAL(finished(QNetworkReply*)),this, SLOT(finishedSlot(QNetworkReply*)));

}

// create connection to server
void QuickInfo::createConnection(QString showName)
{
    //open url (base + showName)
    QUrl url(URL_BASE + showName);

    //clear hashmap
    showInfo->clear();

    //add showname to hasmap

    showInfo->insert("Show Name",showName);

    // serverReply
    QNetworkReply* reply = nam->get(QNetworkRequest(url));

    // wait until reply is finished (measuring time out of curiosity)
    QElapsedTimer timer;
    timer.start();

    qDebug() << "Reply is being processed";
    QEventLoop loop;
    QObject::connect(reply, SIGNAL(readyRead()), &loop, SLOT(quit()));

    // Execute the event loop here, now we will wait here until readyRead() signal is emitted
    // which in turn will trigger event loop quit.
    loop.exec();

    qDebug() << "Loading of Infos took "+timer.elapsed();
    //finishedSlot(reply);
}

// work with serverReply
void QuickInfo::finishedSlot(QNetworkReply* reply)
{

    if (reply->error() == QNetworkReply::NoError)
    {

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

                // if  key != Show Name

                if(key!="Show Name") {

                    // add to Hashmap
                    showInfo->insert(key,value);
                }

                if(showInfo->value("Airtime")=="Monday, Tuesday, Wednesday, Thursday, Friday") {
                    showInfo->insert("Airtime","workday");
                }



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
