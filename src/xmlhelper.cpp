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
        QString string = QString::fromUtf8(bytes);
        qDebug() << "String" + string;
    }

    else
    {
        qDebug() << "ERROR: Http-Error occurred";
    }

    reply->deleteLater();
}
