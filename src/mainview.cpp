#include "mainview.h"
#include <QtGui>

MainView::MainView()
{}

//show window and render data
void MainView::init(MainWindow *w) {

    //set layout
    layout = new QGridLayout;

    // add data
    populateView();

    //append data to centralwidget
    QWidget *centralWidget = new QWidget;
    centralWidget->setLayout(layout);

    //apply stylesheet
    centralWidget->setStyleSheet("QWidget {background:url(:/textures/img/main_Tex.png);}QGroupBox { background:rgba(255, 0, 0, 100);}QLabel {background:rgba(255, 0, 0, 0);color:white;}");

    w->setCentralWidget(centralWidget);

}

// add one tile
void MainView::addTile(QString name, int seas, int ep, QString gen,int rows, int columns){

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

    //add box to window
    layout->addWidget(box,rows,columns);

}

void MainView::populateView(){

    //TODO: read dataVector & calculate positions (y = rows , x = columns)

    //hardcoded data
    addTile("Breaking Bad",1,12,"Drama",0,0);
    addTile("Breaking Bad",1,12,"Drama",0,1);
    addTile("Breaking Bad",1,12,"Drama",0,2);
    addTile("Breaking Bad",1,12,"Drama",0,3);
    addTile("Breaking Bad",1,12,"Drama",0,4);
    addTile("Breaking Bad",1,12,"Drama",1,0);
    addTile("Breaking Bad",1,12,"Drama",1,1);
    addTile("Breaking Bad",1,12,"Drama",1,2);
    addTile("Breaking Bad",1,12,"Drama",1,3);
    addTile("Breaking Bad",1,12,"Drama",1,4);
    addTile("Breaking Bad",1,12,"Drama",2,0);
    addTile("Breaking Bad",1,12,"Drama",3,0);
    addTile("Breaking Bad",1,12,"Drama",4,0);
    addTile("Breaking Bad",1,12,"Drama",4,1);
    addTile("Breaking Bad",1,12,"Drama",2,4);
}
