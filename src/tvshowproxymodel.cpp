#include "tvshowproxymodel.h"

#include <QDebug>
#include <QDate>

TvShowProxyModel::TvShowProxyModel(QObject *parent) :
    QSortFilterProxyModel(parent)
{
}

bool TvShowProxyModel::lessThan(const QModelIndex &left, const QModelIndex &right) const
{
    QVariant leftData = sourceModel()->data(left,this->sortRole());
    QVariant rightData = sourceModel()->data(right,this->sortRole());

    if(leftData.type() == QVariant::Date)
    {
        QDate ldate(leftData.toDate());
        QDate rdate(rightData.toDate());

        if (!ldate.isValid())
        {
            return false;
        }
        else if (!rdate.isValid())
        {
            return true;
        }
        else
        {
            return ldate < rdate;
        }
    }
    else
    {
        qDebug() << "ProxyModel::lessThan: incoming data was not a QDate";
        return false;
    }
}
