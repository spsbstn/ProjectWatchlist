#include "quickinfo.h"
#include <QtDebug>
#define URL_BASE "http://services.tvrage.com/tools/quickinfo.php?show="


QuickInfo::QuickInfo(QObject *parent) : QObject(parent)
{
    nam = new QNetworkAccessManager(this);
    showInfo = new  QMap<QString, QString>;
    xmlPicture_ = new XmlPictureLoader(this);
    QObject::connect(nam, SIGNAL(finished(QNetworkReply*)),this, SLOT(finishedSlot(QNetworkReply*)));

}

void QuickInfo::createConnection(QString showName)
{
    QUrl url(URL_BASE+ showName);
    QNetworkReply* reply = nam->get(QNetworkRequest(url));
}

void QuickInfo::finishedSlot(QNetworkReply* reply)
{

    if (reply->error() == QNetworkReply::NoError)
    {
        //Clear Hashmap
        showInfo->clear();

        QByteArray bytes = reply->readAll();
        QString string = QString::fromUtf8(bytes);
        QTextStream strgStream(&string);

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
        xmlPicture_->createConnection(showInfo->value("Show ID"));
}

    else
    {
        qDebug() << "ERROR: Http-Error occurred";
    }

    reply->deleteLater();
}
