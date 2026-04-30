#ifndef MATHTABLE_H
#define MATHTABLE_H

#include <QObject>
#include <QQmlEngine>
#include <QString>

class MathTable : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit MathTable(QObject *parent = nullptr);

    Q_INVOKABLE QString generateTable(const QString &input);
    Q_INVOKABLE QString factorial(const QString &input);
};

#endif // MATHTABLE_H
