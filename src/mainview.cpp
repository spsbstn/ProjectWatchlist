#include "mainview.h"
#include"tile.h"

MainView::MainView()
{}

// add one tile
void MainView::addTile(QString name, int seas, int ep, QString gen,int rows, int columns){

   /*

    **temporarily removed**

    // define labels
    QLabel *series = new QLabel("Serie: " + name);
    QLabel *season = new QLabel("Staffel: " + QString::number(seas));
    QLabel *episode = new QLabel("Episode: " + QString::number(ep));
    QLabel *genre = new QLabel("Genre: " + gen);

    //define QGroupBox and groupBoxLayout
    QGroupBox *box = new QGroupBox();
    QVBoxLayout *lbox = new QVBoxLayout;

    // set max tiledimension to 200x100 px
    box->setMaximumWidth(200);
    box->setMaximumHeight(100);

    //add items
    lbox->addWidget(series);
    lbox->addWidget(season);
    lbox->addWidget(episode);
    lbox->addWidget(genre);

    //remove title
    box->setTitle("");

    //add layout to box
    box->setLayout(lbox);

    */

    //add box to window
    layout->addItem(new tile(),rows,columns);

}

void MainView::populateView(){

    //TODO: read dataVector & calculate positions (y = rows , x = columns)

    //hardcoded data
    addTile("Breaking Bad",1,12,"Drama",0,0);

}
