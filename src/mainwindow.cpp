#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "mainview.h"
#include <QDebug>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{

    ui->setupUi(this);
    // init MainView
    MainView v;
    v.init(this);
}


MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_actionAdd_triggered()
{
    qDebug() << "AddSeries clicked";
    MainView v;
    v.init(this);
    v.addTile("Test",2,3,"cool",4,2);

    /*
    *TODO:
    *remove lines 26 & 27
    *for cleaner entry
    */
}
