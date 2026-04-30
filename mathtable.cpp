#include "mathtable.h"

MathTable::MathTable(QObject *parent)
    : QObject{parent}
{}
QString MathTable::generateTable(const QString &input){
    bool ok;
    int num = input.toInt(&ok);

    if(!ok)return "Invalid input!";
    QString table;

    for(int i{1};i<=10;++i){
        table += QString::number(num)+" x "+
                 QString::number(i)+" = "+
                 QString::number(num*i)+"\n";
    }
    return table;
}
QString MathTable::factorial(const QString &input){
    bool ok;
    int num=input.toInt(&ok);

    if(!ok||num<0)return "Invalid input!";

    long long fact=1;
    for(int i{1};i<=num;++i)fact*=i;
    return "Factorial of "+QString::number(num)+" = "+QString::number(fact);
}
