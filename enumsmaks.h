#ifndef ENUMSMAKS_H
#define ENUMSMAKS_H
#pragma once

#include <QObject>
#include <QQmlEngine>
#include <QQmlContext>
#include "qqml.h"
#include <QMetaEnum>

class EnumsMaks : public QObject
{
    Q_OBJECT

public:
    enum OperationType {
        YAPIENUMS,
        DIGERYAPIENUMS,
        NUMARATAJ
    };
    Q_ENUMS( OperationType)
    static void init(){
//        qRegisterMetaType<EnumsMaks::OperationType>("EnumsMaks::OperationType");
        qmlRegisterType<EnumsMaks>("EnumsMaks", 1, 0, "EnumsMaks");
    }
signals:
    void operationTypeChanged();

};

#endif // ENUMSMAKS_H
