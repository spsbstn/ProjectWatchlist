#ifndef LOCALIZER_H
#define LOCALIZER_H
#define STARTED 0
#define STATUS 1
#define GENRE 2
#define AIRTIME 3
#include <QString>
#include <QDebug>
#include <QDate>
#include <QTranslator>
#include <QLocale>
#include <QObject>

class Localizer : public QObject
{
    Q_OBJECT

public:
    explicit Localizer(QObject *parent = 0);
    Q_INVOKABLE QString trans(QString text,int category);

private:

    QString started(QString text);
    QString status(QString text);
    QString genre(QString text);
    QString airtime(QString text);

};

#endif // LOCALIZER_H
