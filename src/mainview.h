#ifndef MAINVIEW_H
#define MAINVIEW_H

#include <QDeclarativeView>
#include <QSizeGrip>
#include <QMouseEvent>
#include <QVBoxLayout>


class MainView : public QDeclarativeView
{
public:
    MainView();
    QSizeGrip* grip1;
    QSizeGrip* grip2;
    QSizeGrip* grip3;
    QSizeGrip* grip4;
    QBoxLayout* mainLayout;
    QVBoxLayout* vLayout1;
    QVBoxLayout* vLayout2;
};

#endif // MAINVIEW_H
