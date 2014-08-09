#include "utils.h"

#include <QString>

Utils::Utils()
{
}

int Utils::monthToInt(const QString &month)
{
    int result;

    if      (month == "Jan")
        result = 1;
    else if (month == "Feb")
        result = 2;
    else if (month == "Mar")
        result = 3;
    else if (month == "Apr")
        result = 4;
    else if (month == "May")
        result = 5;
    else if (month == "Jun")
        result = 6;
    else if (month == "Jul")
        result = 7;
    else if (month == "Aug")
        result = 8;
    else if (month == "Sep")
        result = 9;
    else if (month == "Oct")
        result = 10;
    else if (month == "Nov")
        result = 11;
    else if (month == "Dec")
        result = 12;
    else
        return -1;

    return result;
}
