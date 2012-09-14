#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QDebug>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{

    ui->setupUi(this);
    // init MainView
    MainView v;
    init();
}


MainWindow::~MainWindow()
{
    delete ui;
}


//show window and render data
void MainWindow::init() {

    //set layout
    v.layout = new QGridLayout;

    // add data
    v.populateView();

    //append data to centralwidget
    QWidget *centralWidget = new QWidget;
    centralWidget->setLayout(v.layout);

    //apply stylesheet
    centralWidget->setStyleSheet("QWidget {background:url(:/textures/img/main_Tex.png);}QGroupBox { background:rgba(255, 0, 0, 100);}QLabel {background:rgba(255, 0, 0, 0);color:white;}");

    setCentralWidget(centralWidget);

}

void MainWindow::on_actionAdd_triggered()
{
    qDebug() << "AddSeries clicked";

    v.addTile("Test",2,3,"cool",4,2);

    /*
    *TODO:
    *remove lines 26 & 27
    *for cleaner entry
    */
}
