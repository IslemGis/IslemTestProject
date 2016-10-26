
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

import QtQuick 2.3
import QtQuick.Controls 1.3
import ArcGIS.Runtime 10.26
import QtQml 2.2
import QtQuick.LocalStorage 2.0
import ArcGIS.Extras 1.0
import QtQuick.Controls.Styles 1.3
import FileDownloader 1.0
//import EnumsMaks 1.0
import ImageStringConverter 1.0
//import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2

ApplicationWindow {
    id: appWindow
    width: 800
    height: 600
    title: "Test "
    property var scaleFactor: System.displayScaleFactor
    property var nameProp: itemS
    //    property string dbName
    Item{
        id:itemS
        property int nameProp: 1
    }

    Map {
        anchors.fill: parent
        focus: true

        ArcGISTiledMapServiceLayer {
            url: "http://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer"
        }

        GraphicsLayer{
            id:graphicsLayer

            onFindGraphicsComplete: {
                console.log("graphicIds "+graphicIDs.length)
                graphicIDs.forEach(function(gr){
                    console.log("grid  "+gr)
                    graphicsLayer.selectGraphic(gr)
                })
                if(graphicIDs.length>1){
                    //var graphic=graphicsLayer.graphic(graphicIDs[0]);
                    //graphic.symbol.xOffset=100;
                    //graphicsLayer.updateGraphic(graphicIDs[0],graphic)
                    //var graphic=graphicsLayer.graphic(graphicIDs[1]);
                    //graphic.symbol.xOffset=-100;
                    //graphicsLayer.updateGraphic(graphicIDs[1],graphic)

                    //var graphic=graphicsLayer.graphic(graphicIDs[2]);
                    //graphic.symbol.yOffset=100;
                    //graphicsLayer.updateGraphic(graphicIDs[2],graphic)

                    var angleDraw=360/(graphicIDs.length);

                    var toleranceDistance=50+15*(graphicIDs.length/5);
                    console.log("toleranceDistance "+toleranceDistance)
                    var angleVar=0;
                    console.log("2 ");
                    graphicIDs.forEach(function (grId){
                        console.log("3 angleVar "+angleVar)
                        var graphic=graphicsLayer.graphic(grId);
                        console.log("3-1 toleranceDistance "+toleranceDistance+" angleVar "+angleVar +" Math.sin(angleVar* Math.PI / 180.0) "+Math.sin(angleVar* Math.PI / 180.0))
                        console.log("4 grId "+grId+" color "+graphic.symbol.color)
                        graphic.symbol.xOffset=toleranceDistance*Math.sin(angleVar* Math.PI / 180.0);
                        console.log("5 xOffset "+graphic.symbol.xOffset)
                        graphic.symbol.yOffset=toleranceDistance*Math.cos(angleVar* Math.PI / 180.0);
                        console.log("6 yOffset "+graphic.symbol.yOffset)
                        graphicsLayer.updateGraphic(grId,graphic)
                        console.log("7 grId "+grId+" \n\n\n")
                        angleVar+=angleDraw;
                    });
                }
            }
        }

        onStatusChanged: {
            if(status==Enums.MapStatusReady){
                var graphic2 = {
                    geometry: {
                        spatialReference: {latestWkid: 3857,wkid:102100},
                        x: -12723815.98664722,
                        y: -1807126.3427607343
                    },
                    symbol: {
                        type: "esriSMS",
                        size: 20,
                        style: "esriSMSCircle",
                        color: "red"
                    }
                };
                var graphic3 = {
                    geometry: {
                        spatialReference: {latestWkid: 3857,wkid:102100},
                        x: -12723816.98764777,
                        y: -1807126.3427607343
                    },
                    symbol: {
                        type: "esriSMS",
                        size: 20,
                        style: "esriSMSCircle",
                        color: "green"
                    }
                };
                var graphic4 = {
                    geometry: {
                        spatialReference: {latestWkid: 3857,wkid:102100},
                        x: -12723817.98764799,
                        y: -1807126.3427607343
                    },
                    symbol: {
                        type: "esriSMS",
                        size: 20,
                        style: "esriSMSCircle",
                        color: "blue"
                    }
                };
                var graphic5 = {
                    geometry: {
                        spatialReference: {latestWkid: 3857,wkid:102100},
                        x: -12723817.98764799,
                        y: -1807126.3427607343
                    },
                    symbol: {
                        type: "esriSMS",
                        size: 20,
                        style: "esriSMSCircle",
                        color: "cyan"
                    }
                };
                var graphic6 = {
                    geometry: {
                        spatialReference: {latestWkid: 3857,wkid:102100},
                        x: -12723817.98764799,
                        y: -1807126.3427607343
                    },
                    symbol: {
                        type: "esriSMS",
                        size: 20,
                        style: "esriSMSCircle",
                        color: "gray"
                    }
                };
                var graphic7 = {
                    geometry: {
                        spatialReference: {latestWkid: 3857,wkid:102100},
                        x: -12723817.98764799,
                        y: -1807126.3427607343
                    },
                    symbol: {
                        type: "esriSMS",
                        size: 20,
                        style: "esriSMSCircle",
                        color: "yellow"
                    }
                };
                graphicsLayer.addGraphic(graphic2);
                graphicsLayer.addGraphic(graphic3);
                graphicsLayer.addGraphic(graphic4);
                graphicsLayer.addGraphic(graphic5);
                graphicsLayer.addGraphic(graphic6);
                graphicsLayer.addGraphic(graphic7);
                graphicsLayer.addGraphic(graphic2);
                graphicsLayer.addGraphic(graphic3);
                graphicsLayer.addGraphic(graphic4);
                graphicsLayer.addGraphic(graphic5);
                graphicsLayer.addGraphic(graphic6);
                graphicsLayer.addGraphic(graphic7);
                graphicsLayer.addGraphic(graphic2);
                graphicsLayer.addGraphic(graphic3);
                graphicsLayer.addGraphic(graphic4);
                graphicsLayer.addGraphic(graphic5);
                graphicsLayer.addGraphic(graphic6);
                graphicsLayer.addGraphic(graphic7);
            }
        }

        onMouseClicked: {
            graphicsLayer.findGraphics(mouse.x, mouse.y, 4,100);

        }
        //        Component.onCompleted: test();
    }
    Button{
        onClicked: test();
    }

    ImageStringConverter{
        id:imageS}
    Button{
        text:"Zip Arch"
        anchors.right: parent.right
        onClicked:fileFolder.removeFile("uavtDb.zip");/*testZipArchieve();*/
    }
    Sections{
        anchors.centerIn: parent
        visible: false
    }
    function test(){
        var encoded =imageS.convertImageToBase64String("C:/Users/cyilmaz/ArcGIS/problem.png");
        console.log("encodedSize qml "+encoded)
        console.log("encodedSize qml "+encoded.length)
        //        dialogOnMessage.open();
        //        console.log("nameProp "+nameProp.nameProp+" ")
        //        yesNoDialogOnline.open();
        //        fileFolder.path=System.userHomePath;
        //        console.log("write file "+fileFolder.writeTextFile(System.userHomePath+"/bgmszKtrl.txt","stringLog"));

        //        var userName="Ceyhun Yılmaz"
        //        var pass=124537

        //        console.log("userName :=> "+userName);
        //        console.log("password :=>"+pass);
        //        var encUsr=Qt.btoa(userName)
        //        var encPass=Qt.btoa(pass)
        //        console.log("\nbtoa :=> "+encUsr);
        //        console.log("password :=>"+encPass);

        //        console.log("\nbtoa :=> "+Qt.atob(encUsr));
        //        console.log("password :=>"+Qt.atob(encPass));

        //        var element=[{"kapino":110,"tur":"asd"},{"kapino":11,"tur":"asd"},{"kapino":1,"tur":"asd"},{"kapino":2,"tur":"asd"}];
        //        var arrayNew=element.filter(function(a){ return a["kapino"] == 1 });
        //        arrayNew=arrayNew;
        //        tabView.toString();
        //        tab1.item.comboBox.currentIndex=1;
        //        var list=[{"prop1":"ESLESMEYEN","index":0},{"prop1":"ESLESME","index":3},{"prop1":"ESLESME","index":7},{"prop1":"ESLESMEYEN","index":11},{"prop1":"ESLESME","index":5},{"prop1":"ESLESMEYEN","index":2},{"prop1":"ESLESMEYEN","index":4},{"prop1":"ESLESME","index":8},{"prop1":"ESLESMEYEN","index":9}]

        //        list=sortByField(list,"prop1")/*sort(function(a,b) {
        //            if ( a.prop1 < b.prop1 )
        //                return -1;
        //            if ( a.prop1 > b.prop1 )
        //                return 1;
        //            return 0;
        //        } );*/
        //        var loEslesme=list.map(function(e) { return e.prop1; }).lastIndexOf('ESLESME');
        //        console.log("loEslesme "+loEslesme)
        //        var slice1=list.slice(0,loEslesme+1);
        //        var slice2=list.slice(loEslesme+1,list.length)
        //        slice1=sortByField(slice1,"index")/*sort(function(a,b) {
        //            if ( a.index < b.index )
        //                return -1;
        //            if ( a.index > b.index )
        //                return 1;
        //            return 0;
        //        } );*/
        //        slice2= sortByField(slice2,"index")/*sort(function(a,b) {
        //            if ( a.index < b.index )
        //                return -1;
        //            if ( a.index > b.index )
        //                return 1;
        //            return 0;
        //        } );*/
        //        list=slice1.concat(slice2)
        //        console.log(JSON.stringify(slice1)+" \n\n"+JSON.stringify(slice2)+" \n\n"+JSON.stringify(list))
        //        var list1=list;
        //        console.log("dbName "+dbName);
        //        var db = LocalStorage.openDatabaseSync("newdb", "1.0", "newdb", 1000000);
        //        db.transaction(
        //                    function(tx) {
        //                        console.log("MU_BAGIMSIZBOLUM")
        //                        try{
        //                            var rs = tx.executeSql('SELECT * FROM MU_BAGIMSIZBOLUM ORDER BY  ICKAPINO ');
        //                            console.log("result length "+rs.rows.length)
        //                        }catch(exception){
        //                            console.log("+exception"+exception);
        //                        }
        //                    }
        //                    )
    }
    function sortByField(arrayProp,sortProperty) {
        arrayProp.sort(function(a,b){
            var value1=a[sortProperty];
            var value2=b[sortProperty]
            if(!isNaN(value1))
                value1=parseInt(value1);
            if(!isNaN(value2))
                value2=parseInt(value2);

            if (value1 < value2)
                return -1;
            else if (value1 > value2)
                return 1;
            else
                return 0;
        });
        return arrayProp;
    }
    ZipArchive{
        id:zipArchiveElement
        //  path: "~/ArcGIS/uavtDB.zip"
        caseSensitive: false

        path:("C:/Users/cyilmaz/ArcGIS/Databases/uavtDb.zip");
        onExtractCompleted: {
            console.log("extract finished ")
            console.log("zip opened "+zipArchiveElement.isOpen)
            if(zipArchiveElement.isOpen)
                close();
            fileDownloader.processDbFile();
        }
        onIsOpenChanged: {
            console.log("is open change "+zipArchiveElement.isOpen)
        }
    }
    FileFolder{
        id:fileFolder
    }

    property real fileSize: 0.0
    FileDownloader{
        id:fileDownloader
        onDownloadProgressUpdated :{
            console.log("onDownloadProgressUpdated "+bytesReceived+" "+totalBytes);
            progressBar.value=bytesReceived/totalBytes;
            textDownloadSpeed.text=parseFloat(downloadSpeed).toFixed(2)+" kb/sn"
            fileSize=totalBytes;
        }

        onFileProcessEnded:{
            console.log("onFileProcessEnded")
            fileFolder.path="C:/Users/cyilmaz/ArcGIS/Databases";
            fileFolder.removeFile("uavtDb.zip");
            fileFolder.removeFile("uavtDb.db");
        }

        onDownloaded: {
            timerDownloadCounter.stop();
            textTotalLength.text=timeCounter>0?"İndirme "+ textTotalLength.text +"saniyede tamamlandı.":"İndirme 1 saniyenin altında tamamlandı.";
            timeCounter=timeCounter>0?timeCounter:1;
            textDownloadSpeed.text="Ortalama Hız : "+parseFloat((fileSize/timeCounter)/1000).toFixed(2)+" kb/sn";
            progressBar.isFinished=true;
            zipArchiveElement.extractAll("C:/Users/cyilmaz/ArcGIS/Databases")    ;
        }

        Component.onCompleted: {
            //fileUrl="http://ovh.net/files/100Mb.dat";
            fileUrl="http://islem-6002/uavt/uavtDb.zip";
            fileDownload();
            timeCounter=0;
            timerDownloadCounter.start();
        }
    }

    Rectangle{
        anchors.centerIn: parent
        width: 250
        height: 100
        border.pixelAligned: Rectangle.BottomRight
        //        Slider{
        //            anchors.top:parent.top
        //            value:0
        //            onValueChanged: progressBar.value=value
        //        }

        TabView {
            id:tabView
            property var comboBoxProp: tab1.comboBoxProp
            Tab {
                id:tab1
                title: "Red"
                property var comboBoxProp: item.comboBoxProp
                Rectangle{
                    id:rect1
                    anchors.fill: parent
                    property var comboBoxProp: comboBox
                    Column{
                        id:rect2
                        anchors.fill:parent
                        property var comboBoxProp: rect3.comboBoxProp
                        Row{
                            id:rect3
                            anchors.fill:parent
                            property var comboBoxProp: comboBox
                            ComboBox {
                                id:comboBox
                                currentIndex: 2
                                model: ListModel {
                                    id: cbItems
                                    ListElement { text: "Banana"; color: "Yellow" }
                                    ListElement { text: "Apple"; color: "Green" }
                                    ListElement { text: "Coconut"; color: "Brown" }
                                }
                                width: 200
                                onCurrentIndexChanged: console.debug(cbItems.get(currentIndex).text + ", " + cbItems.get(currentIndex).color)
                            }
                        }
                    }
                }
            }
            Tab {
                title: "Blue"
                Rectangle { color: "blue" }
            }
            Tab {
                title: "Green"
                Rectangle { color: "green" }
            }
        }

        ProgressBar {
            id:progressBar
            property bool isFinished: false
            anchors.centerIn: parent
            smooth: true
            value: 10
            style: ProgressBarStyle {
                background: Rectangle {
                    radius: 2
                    color: "lightgray"
                    border.color: "gray"
                    border.width: 1
                    implicitWidth: 200
                    implicitHeight: 24

                }
                progress: Rectangle {
                    color: !progressBar.isFinished?"steelblue":"green"
                    border.color: "lightsteelblue"
                    border.width:2
                    opacity: 1
                }
            }

            Rectangle{
                anchors.centerIn: parent
                //anchors.horizontalCenter: parent.horizontalCenter
                //                width: childrenRect.width
                color:"steelblue"
                Text{
                    anchors.centerIn: parent
                    text:"% "+parseInt(progressBar.value*100)
                    color:"white"
                    font.italic: true
                    font.bold:true
                }
            }
        }

        Text {
            id: textDownloadSpeed
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            text: 0 +" kb/sn "
        }
        Text {
            id: textTotalLength
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            text: 0 +" kb/sn "
        }
    }

    property int timeCounter: 0
    Timer{
        id:timerDownloadCounter
        interval:1000
        repeat: true;
        onTriggered:{
            timeCounter++;
            var minutes=0,seconds=0;
            minutes=parseInt(timeCounter/60);
            seconds=timeCounter%60
            var timeString=" ";
            timeString+=minutes>9?minutes:"0"+minutes;

            timeString+=" : "
            timeString+=seconds>9?seconds:"0"+seconds;
            timeString+=" "
            textTotalLength.text=timeString+" sn ";
        }
    }

    SplitView {
        anchors.fill: parent
        orientation: Qt.Horizontal
        visible: false
        Rectangle {
            width: 200
            //Layout.maximumWidth: 400
            color: "lightblue"
            Text {
                text: "View 1"
                anchors.centerIn: parent
            }
        }
        Rectangle {
            id: centerItem
            //            Layout.minimumWidth: 50
            //            Layout.fillWidth: true
            color: "lightgray"
            Text {
                text: "View 2"
                anchors.centerIn: parent
            }
        }
        Rectangle {
            width: 200
            color: "lightgreen"
            Text {
                text: "View 3"
                anchors.centerIn: parent
            }
        }
        Rectangle {
            width: 500
            color: "lightgreen"
            Text {
                text: "View 3"
                anchors.centerIn: parent
            }
        }
    }

    Dialog {
        id: dialogOnMessage
        title: "Foto"
        modality: Qt.ApplicationModal
        visible: false

        contentItem: Rectangle {
            id:rectDialogonExit
            color: "lightgrey"
            implicitWidth: 250 * scaleFactor
            implicitHeight:  100 *scaleFactor

            Label{
                id:labelOnExit
                anchors.top:parent.top
                anchors.topMargin: 30 * scaleFactor
                anchors.horizontalCenter: parent.horizontalCenter
                text:"Fotoğraflar gönderiliyor..."
                color:"black"
                font.pixelSize: 15*scaleFactor
            }

        }
    }

    Label{
        id:sss
        text:"tkokkaaakak"
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Dialog {

        id:yesNoDialogOnline
        visible: false
        title: "Uyarı"
        modality: Qt.ApplicationModal


        contentItem: Rectangle {
            color: "white"
            anchors.centerIn: parent
            implicitWidth: 500*scaleFactor
            implicitHeight: 150*scaleFactor
            border.color:"black"
            anchors.margins: 10*scaleFactor
            Column{
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 10*scaleFactor
                width: parent.width-10*scaleFactor
                height: parent.height-10*scaleFactor
                Text{
                    id:yesNoText
                    width: parent.width-5*scaleFactor

                    anchors.top: parent.top
                    anchors.margins: 20*scaleFactor
                    wrapMode: Text.WordWrap
                    text:"İnternet Bulunmaktadır.Çalışmanızı sunucuya kaydetmek ister misiniz?"
                }
                CheckBox{
                    id:checkBoxTopluFotograf
                    text: "Fotoğraflar Gönderilsin mi ?"
                    anchors.top: yesNoText.bottom
                    anchors.topMargin: 20*scaleFactor
                }

                Button{
                    id:yesyesNoDialogOnline
                    text: "Evet"
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 20*scaleFactor
                    anchors.left:parent.left
                    anchors.leftMargin: 20*scaleFactor
                    onClicked: {
                        yesNoDialogOnline.close()
                        busyIndicatorMap.showBusyMap();
                        loginPage.getServiceAddresses();


                    }
                }
                Button{
                    id:noyesNoDialogOnline
                    text: "Hayır"
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 20*scaleFactor
                    anchors.right: parent.right
                    anchors.rightMargin: 20*scaleFactor
                    onClicked: {
                        yesNoDialogOnline.close()
                    }
                }
            }
        }
    }
    function testZipArchieve(){
        console.log("zipArchiveElement path "+zipArchiveElement.isOpen);
        console.log("zipArchiveElement isExits "+zipArchiveElement.exists("uavtDB.db"));
        zipArchiveElement.extractAll("C:/");

    }
}
