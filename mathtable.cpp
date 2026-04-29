#include "mathtable.h"

MathTable::MathTable(QObject *parent)
    : QObject{parent}
{}
QString MathTable::result()const
{
    return m_result;
}
void MathTable::generateTable(const QString &input){
    bool ok;
    int num = input.toInt(&ok);

    if(!ok){
        m_result = "Invalid input!";
        emit resultChanged();
        return;
    }
    QString table;

    for(int i{1};i<=10;++i){
        table += QString::number(num)+" x "+
                 QString::number(i)+" = "+
                 QString::number(num*i)+"\n";
    }
    m_result = table;
    emit resultChanged();
}
QString MathTable::factorial(const QString &input){

}
