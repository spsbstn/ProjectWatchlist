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
    QFrame* popup = new QFrame(this, Qt::Tool | Qt::Window | Qt::FramelessWindowHint);
    popup->resize(300,200);
    QGridLayout *layout = new QGridLayout;
    QLineEdit *inputName = new QLineEdit();
    QLineEdit *inputSeason = new QLineEdit();
    QLineEdit *inputEpisode = new QLineEdit();
    QLineEdit *inputGenre = new QLineEdit();
    QLabel *infoName = new QLabel("Serie: ");
    QLabel *infoSeason = new QLabel("Staffel");
    QLabel *infoEpisode = new QLabel("Episode: ");
    QLabel *infoGenre = new QLabel("Genre: ");
    QPushButton *addButton = new QPushButton("Hinzufuegen");
    connect(addButton, SIGNAL(clicked()), popup, SLOT(close()));

    layout->addWidget(infoName,0,0);
    layout->addWidget(inputName,0,1);
    layout->addWidget(infoSeason,1,0);
    layout->addWidget(inputSeason,1,1);
    layout->addWidget(infoEpisode,2,0);
    layout->addWidget(inputEpisode,2,1);
    layout->addWidget(infoGenre,3,0);
    layout->addWidget(inputGenre,3,1);
    layout->addWidget(addButton,4,0,1,0,Qt::AlignCenter);
    popup->setLayout(layout);
    popup->setParent(this);
    popup->setGeometry(this->geometry().x()-280,this->height()-200,300,200);


       popup->show();

}
