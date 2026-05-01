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
    if (num > 20)return "Limit exceeded (max 20)";

    long long fact=1;
    for(int i{1};i<=num;++i)fact*=i;
    return "Factorial of "+QString::number(num)+" = "+QString::number(fact);
}
QString MathTable::isPrime(const QString &input){
    bool ok;
    int num=input.toInt(&ok);
    if(!ok)return "Invalid input!";
    if(num<2)return QString::number(num)+" is not a prime number";

    for(int i=2;i<=num/i;++i){
        if(num%i==0)return QString::number(num)+" is not a prime number";
    }
    return QString::number(num)+" is a prime number";
}
