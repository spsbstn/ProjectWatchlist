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
    v.layout = new QGraphicsGridLayout();

    // add data


    QGraphicsScene *scene = new QGraphicsScene(this);
            QGraphicsWidget *widget = new QGraphicsWidget();
            v.layout = new QGraphicsGridLayout(widget);
            v.populateView();// create Tiles
            scene->addItem(widget);
            QGraphicsView *view = new QGraphicsView(scene);
            QVBoxLayout *vbox = new QVBoxLayout(this);
            vbox->addWidget(view);
            // add vbox to cw
            QWidget *centralWidget = new QWidget;
            centralWidget->setLayout(vbox);

            //apply stylesheet
            //centralWidget->setStyleSheet("QWidget {background:url(:/textures/img/main_Tex.png);}QGroupBox { background:rgba(255, 0, 0, 100);}QLabel {background:rgba(255, 0, 0, 0);color:white;}");

            setCentralWidget(centralWidget);


}

   // add popup (soon deprecated)
void MainWindow::on_actionAdd_triggered()
{
    //TODO: rewrite!!

    qDebug() << "AddSeries clicked";
    v.addTile("Test",2,3,"cool",4,2);
    QWidget* popup = new QWidget(this);
    popup->setStyleSheet("QWidget {background:#574236;} QLineEdit {background:white;border:none} QLabel {background:none;border:none;color:white}QPushButton{color:white;border:1px solid white; border-radius:8px;padding-left:5px;padding-right:5px;}");
    popup->move(QPoint(-250,this->x()+196));//why 296??
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

   popup->show();

   // animation
   QPropertyAnimation *animation = new QPropertyAnimation(popup, "pos");
   animation->setDuration(1000);
   animation->setStartValue(popup->pos());
   animation->setEndValue(QPoint(0,this->x()+196));

   // slide in
   animation->start();

}
