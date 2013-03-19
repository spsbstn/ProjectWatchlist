#include "uicontroller.h"

UIController::UIController(QWidget *widget,QApplication *app, QObject *parent) :
    QObject(parent)
{
    mainWidget = widget;
    settings = new QSettings("Watchlist");
    checkForSeasonIcons(app);

}

UIController::~UIController()
{
    delete settings;
    delete mainWidget;
}


void UIController::changeColorScheme(const QString &color,const QString &schemeName){

     // change frame color
     mainWidget->setStyleSheet("background:'"+ color +"'");

     // save current scheme name and hexColor to settings
     settings->setValue("colorScheme", schemeName);
     settings->setValue("color", color);

}


QString UIController::loadColorScheme(){

    // load name und hexColor from settingsfile
    QString schemeName = settings->value("colorScheme").toString();
    QString color = settings->value("color").toString();

    // change frame color
    mainWidget->setStyleSheet("background:'"+color+"'");

    // return name of scheme
    return schemeName;

}


// check if app starts for the first time --> use default color scheme
void UIController::checkForFirstInit(){

    // check ich colorScheme information exists
    if(settings->contains("colorScheme")){

        return;

    }

    else { //create default values

        settings->setValue("colorScheme", "blackCyan");
        settings->setValue("color","#111111");
    }

}

// calculate frameColor according to backgroundColor and alpha
void UIController::alphaBlendFrame(const QString &color, const double &alpha)
{

    // sepearte hexString
    QString hexRed=color.mid(1,2);
    QString hexGreen=color.mid(3,2);
    QString hexBlue=color.mid(5,2);

    bool ok; // useless

    // convert hexStrings to decimalNumbers
    int red=hexRed.toInt(&ok, 16);
    int green=hexGreen.toInt(&ok, 16);
    int blue=hexBlue.toInt(&ok, 16);

    //blend black (rgba(0,0,0)) over color (A*alpha + (1-alpha)*B)

    red = (1-alpha)*red+1;
    green = (1-alpha)*green+1;
    blue = (1-alpha)*blue+1;

    //create hexString
    QString blendedColor = QColor(red,green,blue,1 ).name();

    //change frame color
    mainWidget->setStyleSheet("background:'"+blendedColor+"'");

}

void UIController::checkForSeasonIcons(QApplication *app)

{
    QDateTime now = QDateTime::currentDateTime();

    //check if today is newYear +-1 day
  if(abs(now.daysTo(QDateTime(QDate(now.date().year(),01,01))))-2<0)

    {

    app->setWindowIcon(QIcon(":/icons/seasons/newYear.png"));

    }

    //check if today is christmas +- 4 days
   if(abs(now.daysTo(QDateTime(QDate(now.date().year(),12,24))))-5<0)

    {

    app->setWindowIcon(QIcon(":/icons/seasons/christmas.png"));

    }

   //check if today is easterSunday
    if(now.daysTo(QDateTime(QDate(2013,3,31)))==0)

    {

    app->setWindowIcon(QIcon(":/icons/seasons/easter.png"));

    }

    // check if today is Watchlist's birthday
    if(now.daysTo(QDateTime(QDate(now.date().year(),9,13)))==0)

    {

    app->setWindowIcon(QIcon(":/icons/seasons/birthday.png"));

    }


}
