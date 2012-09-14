#ifndef MAINVIEW_H
#define MAINVIEW_H

#include <QString>
#include <QtGui>


class MainView
{

public:
    MainView();
    // add one tile
    void addTile(QString name, int seas, int ep, QString gen,int x, int y);
    // add all tiles according to vector
    void populateView();
    QGridLayout *layout;
};

#endif // MAINVIEW_H
