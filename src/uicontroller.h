#ifndef UICONTROLLER_H
#define UICONTROLLER_H

#include <QObject>

class QWidget;
class QApplication;
class QSettings;


/*
 * UIController handles UI changes such as
 * - seasonal Icons
 * - color Schemes
 */

class UIController : public QObject
{
    Q_OBJECT

public:
    explicit UIController(QWidget *mainWidget,QApplication *app, QObject *parent = 0);
    ~UIController();

    Q_INVOKABLE void alphaBlendFrame(const QString& color,const double &alpha);
    Q_INVOKABLE void changeColorScheme(const QString& color,const QString &schemeName);
    Q_INVOKABLE QString loadColorScheme();

    QSettings *settings;
    QWidget *mainWidget;

private:

    void checkForFirstInit();
    void checkForSeasonIcons(QApplication *app);

signals:
    
public slots:
    
};

#endif // UICONTROLLER_H
