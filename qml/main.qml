import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Window 2.2
//import FileIO 1.0
import FlickerItem 1.0

Window{
    id:      mainWnd
    title:   "Incentives"
    visible: true
    visibility: "FullScreen"

    width:        250
    maximumWidth: 250
    minimumWidth: 250

    height:        300
    maximumHeight: 280
    minimumHeight: 280

    Label{
        id: label_incentive1
        x: 14
        y: 9
        width: 100
        height: 20
        text: qsTr("Iincentive #1")
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 12
    }

    Label{
        id: label_incentive2
        x: 135
        y: 9
        width: 100
        height: 20
        text: qsTr("Incentive #2")
        font.pointSize: 12
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Label{
        id: label_visibility1
        x: 14
        y: 141
        width: 100
        height: 20
        text: qsTr("1. Visible every")
        font.bold: false
        verticalAlignment: Text.AlignVCenter
    }

    SpinBox{
        id: spinBox_visibility1
        x: 14
        y: 167
        width: 100
        height: 20
        suffix: qsTr("frames")
        minimumValue: 1
        maximumValue: 5000
        value: 1
        decimals: 1
        antialiasing: true
    }

    Label{
        id: label_visibility2
        x: 135
        y: 141
        width: 100
        height: 20
        text: qsTr("2. Visibly every")
        verticalAlignment: Text.AlignVCenter
    }

    SpinBox{
        id: spinBox_visibility2
        x: 135
        y: 167
        width: 100
        height: 20
        suffix: qsTr("frames")
        minimumValue: 1
        maximumValue: 5000
        value: 1
        decimals: 1
        antialiasing: true
    }

    //параметры стимула №1, для стимула №2 аналогично
//    property bool incentive1IsEnabled:  false //флаг видимости стимула
//    property int incentive1FramesCount: 0     //счетчик кадров

    FlickerItem{
        id: incentive1
        name: "incentive1"
        x: 14
        y: 35
        width: 100
        height: width
        framesPackageSize: spinBox_visibility1.value
        running: false

        Rectangle{
            color: "green"
            anchors.fill: parent
        }
    }

    //параметры стимула №2
//    property bool incentive2IsEnabled:  false
//    property int incentive2FramesCount: 0

    FlickerItem{
        id: incentive2
        name: "incentive2"
        x: 135
        y: 35
        width: 100
        height: width
        framesPackageSize: spinBox_visibility2.value
        running: false

        Rectangle{
            color: "red"
            anchors.fill: parent
        }
    }

    Button{
        id: button_stop
        x: 14
        y: 199
        width: 100
        height: 38
        text: qsTr("Stop")
        antialiasing: true
        enabled: false

        onClicked:
        {
            incentive1.running = false
            incentive2.running = false
            button_stop.enabled   = false
            button_start.enabled  = true
        }
    }

    Button{
        id: button_start
        x: 135
        y: 199
        width: 100
        height: 38
        text: qsTr("Start")
        isDefault: true
        antialiasing: true
        enabled: true

        onClicked:
        {
            incentive1.running = true
            incentive2.running = true
            button_stop.enabled   = true
            button_start.enabled  = false
        }
    }

    Button{
        id: button_exit
        x: 15
        y: 249
        width: 221
        height: 38
        text: qsTr("Exit")

        onClicked:
        {
            Qt.quit()
        }
    }

/////////////////////////////////////////////////////////////////////////////////////////
// !!! НИЖЕРАСПОЛОЖЕННЫЙ КОД В КОНСЕРВАЦИИ :-)
/////////////////////////////////////////////////////////////////////////////////////////
//    FileIO{
//        id: logFile
//        source: "incentives.log"
//        onError: console.log(msg)
//    }

//    Connections{
//        target: mainWnd
//        onFrameSwapped:
//        {
//            if(workInProcess){
//                if(incentive1FramesCount < spinBox_visibility1.value){
//                    if(!incentive1IsEnabled){
//                        logFile.write(Qt.formatTime(new Date(), "[hh:mm:ss:zzz]") + " incentive 1 enabled")
//                        incentive1.visible  = true
//                        incentive1IsEnabled = true
//                        mainWnd.update()
////                        console.log(Qt.formatTime(new Date(), "[hh:mm:ss:zzz]") + " incentive 1 enabled")

//                    }
//                }else{
//                    incentive1FramesCount = 0
//                    if(incentive1IsEnabled){
//                        logFile.write(Qt.formatTime(new Date(), "[hh:mm:ss:zzz]") + " incentive 1 disabled")
//                        incentive1.visible  = false
//                        incentive1IsEnabled = false
//                        mainWnd.update()
////                        console.log(Qt.formatTime(new Date(), "[hh:mm:ss:zzz]") + " incentive 1 disabled")
//                    }
//                }
//                incentive1FramesCount++

//                if(incentive2FramesCount < spinBox_visibility2.value){
//                    if(!incentive2IsEnabled){
//                        logFile.write(Qt.formatTime(new Date(), "[hh:mm:ss:zzz]") + " incentive 2 enabled")
//                        incentive2.visible  = true
//                        incentive2IsEnabled = true
//                        mainWnd.update()
////                        console.log(Qt.formatTime(new Date(), "[hh:mm:ss:zzz]") + " incentive 2 enabled")
//                    }
//                }else{
//                    incentive2FramesCount = 0
//                    if(incentive2IsEnabled){
//                        logFile.write(Qt.formatTime(new Date(), "[hh:mm:ss:zzz]") + " incentive 2 disabled")
//                        incentive2.visible  = false
//                        incentive2IsEnabled = false
//                        mainWnd.update()
////                        console.log(Qt.formatTime(new Date(), "[hh:mm:ss:zzz]") + " incentive 2 disabled")
//                    }
//                }
//                incentive2FramesCount++
//            }
//        }
//    }
/////////////////////////////////////////////////////////////////////////////////////////
}
