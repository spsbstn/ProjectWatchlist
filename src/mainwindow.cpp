#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "mainview.h"

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
