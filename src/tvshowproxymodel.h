#ifndef TVSHOWPROXYMODEL_H
#define TVSHOWPROXYMODEL_H

#include <QSortFilterProxyModel>

class TvShowProxyModel : public QSortFilterProxyModel
{
    Q_OBJECT
public:
    explicit TvShowProxyModel(QObject *parent = 0);

signals:

public slots:

private:
    bool lessThan(const QModelIndex &left, const QModelIndex &right) const;

};

#endif // TVSHOWPROXYMODEL_H
