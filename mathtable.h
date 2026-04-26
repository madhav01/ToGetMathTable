#ifndef MATHTABLE_H
#define MATHTABLE_H

#include <QObject>
#include <QQmlEngine>
#include <QString>

class MathTable : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    Q_PROPERTY(QString result READ result NOTIFY resultChanged)
public:
    explicit MathTable(QObject *parent = nullptr);
    Q_INVOKABLE void generateTable(const QString &input);
    QString result()const;

signals:
    void resultChanged();
private:
    QString m_result;
};

#endif // MATHTABLE_H
