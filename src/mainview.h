#ifndef MAINVIEW_H
#define MAINVIEW_H

#include <QWidget>

class NcFramelessHelper;
class QDeclarativeView;
class QVBoxLayout;
class Controller;
class Database;


class MainView : public QWidget
{
public:
    MainView();

    NcFramelessHelper *framelessHelper;
    QDeclarativeView  *qmlView;
    QVBoxLayout *layout;
    Controller  *controller;
    Database    *db;

};

#endif // MAINVIEW_H
