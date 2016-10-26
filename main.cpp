
// Copyright 2015 ESRI
//
// All rights reserved under the copyright laws of the United States
// and applicable international laws, treaties, and conventions.
//
// You may freely redistribute and use this sample code, with or
// without modification, provided you include the original copyright
// notice and use restrictions.
//
// See the Sample code usage restrictions document for further information.
//

#include <QDebug>
#include <QSettings>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>
#include <QCommandLineParser>
#include <QDir>
#include <QQmlEngine>
#include <QQmlContext>

#ifdef Q_OS_WIN
#include <Windows.h>
#endif

#include "filedownloader.h"
#include "imagestringconverter.h"
#include "AppInfo.h"
#include "QCryptographicHash"
#include <QSslConfiguration>
#include <QSslSocket>
//------------------------------------------------------------------------------

#define kSettingsFormat                 QSettings::IniFormat

//------------------------------------------------------------------------------

#define kArgShowName                    "show"
#define kArgShowValueName               "showOption"
#define kArgShowDescription             "Show option maximized | minimized | fullscreen | normal | default"
#define kArgShowDefault                 "show"

#define kShowMaximized                  "maximized"
#define kShowMinimized                  "minimized"
#define kShowFullScreen                 "fullscreen"
#define kShowNormal                     "normal"

//------------------------------------------------------------------------------

int main(int argc, char *argv[])
{
    qDebug() << "Initializing application";

    QGuiApplication app(argc, argv);

    QCoreApplication::setApplicationName(kApplicationName);
    QCoreApplication::setApplicationVersion(kApplicationVersion);
    QCoreApplication::setOrganizationName(kOrganizationName);
#ifdef Q_OS_MAC
    QCoreApplication::setOrganizationDomain(kOrganizationName);
#else
    QCoreApplication::setOrganizationDomain(kOrganizationDomain);
#endif
    QSettings::setDefaultFormat(kSettingsFormat);

#ifdef Q_OS_WIN
    // Force usage of OpenGL ES through ANGLE on Windows
    QCoreApplication::setAttribute(Qt::AA_UseOpenGLES);
#endif


#ifdef kClientId
    QCoreApplication::instance()->setProperty("ArcGIS.Runtime.clientId", kClientId);
#ifdef kLicense
    QCoreApplication::instance()->setProperty("ArcGIS.Runtime.license", kLicense);
#endif
#endif
    QSslConfiguration config = QSslConfiguration::defaultConfiguration();
    config.setPeerVerifyMode(QSslSocket::VerifyNone);
    QSslConfiguration::setDefaultConfiguration(config);

    // Intialize application window
    qmlRegisterType<FileDownloader>("FileDownloader",1,0,"FileDownloader");
    qmlRegisterType<ImageStringConverter>("ImageStringConverter",1,0,"ImageStringConverter");

    QQmlApplicationEngine appEngine;
    appEngine.addImportPath(QDir(QCoreApplication::applicationDirPath()).filePath("qml"));
    appEngine.load(QUrl(kApplicationSourceUrl));

    auto topLevelObject = appEngine.rootObjects().value(0);
    QString stringDB=QString(QCryptographicHash::hash(("newdb"),QCryptographicHash::Md5).toHex());
    qDebug()<<"dbname main "<<stringDB;
    appEngine.rootContext()->setContextProperty("dbName",stringDB);
    qDebug()<<"Offline Storage Path "<<appEngine.offlineStoragePath();

    appEngine.setOfflineStoragePath("C:\\Users\\cyilmaz\\ArcGIS");
    qDebug()<<"Offline Storage Path "<<appEngine.offlineStoragePath();
    qDebug() << Q_FUNC_INFO << topLevelObject;

    //    QUrl* url=new QUrl("https://yay-app-srv.islem.com.tr:448/espSrv/DownloadSqlitedbFile/izmir_KONAKBELED%C4%B0YES%C4%B0_IlKod35__YetkiliIdareKod2342.db");
    //    QFileInfo fileInfo(url->path());
    //    quint64 fileSize = fileInfo.size();

    //    qDebug()<<"file size "<<fileSize;
    //    FileDownloader* fd=new FileDownloader();
    //    fd->setFileUrl(QUrl("http://ovh.net/files/100Mb.dat"));
    //    fd->fileDownload();

    auto window = qobject_cast<QQuickWindow *>(topLevelObject);
    if (!window)
    {
        qCritical("Error: Your root item has to be a Window.");

        return -1;
    }

#if !defined(Q_OS_IOS) && !defined(Q_OS_ANDROID)
    // Process command line

    QCommandLineOption showOption(kArgShowName, kArgShowDescription, kArgShowValueName, kArgShowDefault);

    QCommandLineParser commandLineParser;

    commandLineParser.setApplicationDescription(kApplicationDescription);
    commandLineParser.addOption(showOption);
    commandLineParser.addHelpOption();
    commandLineParser.addVersionOption();
    commandLineParser.process(app);

    // Show app window

    auto showValue = commandLineParser.value(kArgShowName).toLower();

    if (showValue.compare(kShowMaximized) == 0)
    {
        window->showMaximized();
    }
    else if (showValue.compare(kShowMinimized) == 0)
    {
        window->showMinimized();
    }
    else if (showValue.compare(kShowFullScreen) == 0)
    {
        window->showFullScreen();
    }
    else if (showValue.compare(kShowNormal) == 0)
    {
        window->showNormal();
    }
    else
    {
        window->show();
    }

#else
    window->show();
#endif

    return app.exec();
}

//------------------------------------------------------------------------------
