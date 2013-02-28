#include "localizer.h"

Localizer::Localizer(QObject *parent) :
    QObject(parent) {}

QString Localizer::trans(QString text, int category) {

    switch(category){
    case STARTED:
        return started(text);
        break;
    case STATUS:
        return status(text);
        break;
    case GENRE:
        return genre(text);
        break;
    case AIRTIME:
        return airtime(text);
        break;
    default:
        break;
    }
}

QString Localizer::started(QString text) {

   QLocale locale  = QLocale(QLocale::English, QLocale::UnitedStates);
   QDate date = locale.toDate(text,"MMM/dd/yyyy");
   return date.toString("dd.MM.yyyy");

}

QString Localizer::status(QString text){

    text.replace("Returning Series",QObject::tr("Returning Series"));
    text.replace("New Series",QObject::tr("New Series"));
    text.replace("On The Bubble",QObject::tr("On The Bubble"));
    text.replace("TBD",QObject::tr("TBD"));
    text.replace("Final Season",QObject::tr("Final Season"));
    text.replace("Canceled",QObject::tr("Canceled"));
    text.replace("Ended",QObject::tr("Ended"));

    return text;

}

QString Localizer::genre(QString text){

    text.replace("Action",QObject::tr("Action"));
    text.replace("Adult/Porn",QObject::tr("Adult/Porn"));
    text.replace("Adventure",QObject::tr("Adventure"));
    text.replace("Anthology",QObject::tr("Anthology"));
    text.replace("Arts & Crafts",QObject::tr("Arts & Crafts"));
    text.replace("Automobiles",QObject::tr("Automobiles"));
    text.replace("Buy, Sell & Trade",QObject::tr("Buy, Sell & Trade"));
    text.replace("Celebrities",QObject::tr("Celebrities"));
    text.replace("Children",QObject::tr("Children"));
    text.replace("Cinema/Theatre",QObject::tr("Cinema/Theatre"));
    text.replace("Comedy",QObject::tr("Comedy"));
    text.replace("Cooking/Food",QObject::tr("Cooking/Food"));
    text.replace("Crime",QObject::tr("Crime"));
    text.replace("Current Events",QObject::tr("Current Events"));
    text.replace("Dance",QObject::tr("Dance"));
    text.replace("Debate",QObject::tr("Debate"));
    text.replace("Design/Decorating",QObject::tr("Design/Decorating"));
    text.replace("Discovery/Science",QObject::tr("Discovery/Science"));
    text.replace("Drama",QObject::tr("Drama"));
    text.replace("Educational",QObject::tr("Educational"));
    text.replace("Adult Cartoon",QObject::tr("Adult Cartoon"));
    text.replace("Cartoon",QObject::tr("Cartoon"));
    text.replace("Family",QObject::tr("Family"));
    text.replace("Fantasy",QObject::tr("Fantasy"));
    text.replace("Fashion/Make-up",QObject::tr("Fashion/Make-up"));
    text.replace("Financial/Business",QObject::tr("Financial/Business"));
    text.replace("Fitness",QObject::tr("Fitness"));
    text.replace("Garden/Landscape",QObject::tr("Garden/Landscape"));
    text.replace("History",QObject::tr("History"));
    text.replace("Horror/Supernatural",QObject::tr("Horror/Supernatural"));
    text.replace("Housing/Building",QObject::tr("Housing/Building"));
    text.replace("How To/Do It Yourself",QObject::tr("How To/Do It Yourself"));
    text.replace("Interview",QObject::tr("Interview"));
    text.replace("Lifestyle",QObject::tr("Lifestyle"));
    text.replace("Literature",QObject::tr("Literature"));
    text.replace("Medical",QObject::tr("Medical"));
    text.replace("Military/War",QObject::tr("Military/War"));
    text.replace("Music",QObject::tr("Music"));
    text.replace("Mystery",QObject::tr("Mystery"));
    text.replace("Pets/Animals",QObject::tr("Pets/Animals"));
    text.replace("Politics",QObject::tr("Politics"));
    text.replace("Puppets",QObject::tr("Puppets"));
    text.replace("Religion",QObject::tr("Religion"));
    text.replace("Romance/Dating",QObject::tr("Romance/Dating"));
    text.replace("Sci-Fi",QObject::tr("Sci-Fi"));
    text.replace("Sketch/Improv",QObject::tr("Sketch/Improv"));
    text.replace("Soaps",QObject::tr("Soaps"));
    text.replace("Sports",QObject::tr("Sports"));
    text.replace("Super Heroes",QObject::tr("Super Heroes"));
    text.replace("Talent",QObject::tr("Talent"));
    text.replace("Tech/Gaming",QObject::tr("Tech/Gaming"));
    text.replace("Teens",QObject::tr("Teens"));
    text.replace("Thriller",QObject::tr("Thriller"));
    text.replace("Travel",QObject::tr("Travel"));
    text.replace("Western",QObject::tr("Western"));

    return text;

}

QString Localizer::airtime(QString text){

    return "";
}

