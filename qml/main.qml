import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Window 2.0
import FileIO 1.0

ApplicationWindow{
    id:      mainWnd
    title:   "Incentives"
    visible: true

    width:        250
    maximumWidth: 250
    minimumWidth: 250

    height:        250
    maximumHeight: 250
    minimumHeight: 250

    Label{
        id: label_visibility1
        y: 141
        width: 100
        height: 20
        text: qsTr("1. Visible every")
        anchors.left: parent.left
        anchors.leftMargin: 6
        font.bold: false
        verticalAlignment: Text.AlignVCenter
    }

    SpinBox {
        id: spinBox_visibility1
        y: 167
        width: 100
        height: 20
        suffix: qsTr("frames")
        minimumValue: 1
        maximumValue: 5000
        value: 1
        decimals: 1
        anchors.left: parent.left
        anchors.leftMargin: 6
        antialiasing: true
    }

    Label {
        id: label_visibility2
        x: 141
        y: 141
        width: 100
        height: 20
        text: qsTr("2. Visibly every")
        anchors.right: parent.right
        anchors.rightMargin: 9
        verticalAlignment: Text.AlignVCenter
    }

    SpinBox {
        id: spinBox_visibility2
        x: 236
        y: 167
        width: 100
        height: 20
        anchors.right: parent.right
        anchors.rightMargin: 9
        suffix: qsTr("frames")
        minimumValue: 1
        maximumValue: 5000
        value: 1
        decimals: 1
        antialiasing: true
    }

    //параметры стимула №1, для стимула №2 аналогично
    property bool incentive1IsEnabled:  false //флаг видимости стимула
    property int incentive1FramesCount: 0     //счетчик кадров

    Rectangle
    {
        id: incentive1
        y: 35
        width: 100
        height: width
        color: "green"
        radius: 50
        anchors.left: parent.left
        anchors.leftMargin: 6
        visible: false
    }


    //параметры стимула №2
    property bool incentive2IsEnabled:  false
    property int incentive2FramesCount: 0

    Rectangle
    {
        id: incentive2
        x: 141
        width: 100
        height: 100
        color: "red"
        radius: 50
        anchors.top: parent.top
        anchors.topMargin: 35
        anchors.right: parent.right
        anchors.rightMargin: 9
        visible: false
    }

    property bool workInProcess: false
    Button {
        id: button_stop
        x: 14
        y: 204
        width: 100
        height: 38
        text: qsTr("Stop")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.left: parent.left
        anchors.leftMargin: 6
        antialiasing: true
        enabled: false

        onClicked:
        {
            workInProcess = false
            button_stop.enabled = false
            button_start.enabled = true
        }
    }

    Button
    {
        id: button_start
        x: 141
        y: 204
        width: 100
        height: 38
        text: qsTr("Start")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.right: parent.right
        anchors.rightMargin: 9
        isDefault: true
        antialiasing: true
        enabled: true

        onClicked:
        {
            workInProcess = true
            button_stop.enabled = true
            button_start.enabled = false
            mainWnd.update()
        }
    }

/////////////////////////////////////////////////////////////////////////////////////////
    FileIO {
        id: myFile
        source: "incentives.log"
        onError: console.log(msg)
    }
    Connections {
        target: mainWnd
        onFrameSwapped:
        {
            if(workInProcess){
                if(incentive1FramesCount < spinBox_visibility1.value){
                    if(!incentive1IsEnabled){
                        myFile.write(Qt.formatTime(new Date(), "[hh:mm:ss:zzz]") + " incentive 1 enabled")
                        incentive1.visible  = true
                        incentive1IsEnabled = true
                        mainWnd.update()
//                        console.log(Qt.formatTime(new Date(), "[hh:mm:ss:zzz]") + " incentive 1 enabled")

                    }
                }else{
                    incentive1FramesCount = 0
                    if(incentive1IsEnabled){
                        myFile.write(Qt.formatTime(new Date(), "[hh:mm:ss:zzz]") + " incentive 1 disabled")
                        incentive1.visible  = false
                        incentive1IsEnabled = false
                        mainWnd.update()
//                        console.log(Qt.formatTime(new Date(), "[hh:mm:ss:zzz]") + " incentive 1 disabled")
                    }
                }
                incentive1FramesCount++

                if(incentive2FramesCount < spinBox_visibility2.value){
                    if(!incentive2IsEnabled){
                        myFile.write(Qt.formatTime(new Date(), "[hh:mm:ss:zzz]") + " incentive 2 enabled")
                        incentive2.visible  = true
                        incentive2IsEnabled = true
                        mainWnd.update()
//                        console.log(Qt.formatTime(new Date(), "[hh:mm:ss:zzz]") + " incentive 2 enabled")
                    }
                }else{
                    incentive2FramesCount = 0
                    if(incentive2IsEnabled){
                        myFile.write(Qt.formatTime(new Date(), "[hh:mm:ss:zzz]") + " incentive 2 disabled")
                        incentive2.visible  = false
                        incentive2IsEnabled = false
                        mainWnd.update()
//                        console.log(Qt.formatTime(new Date(), "[hh:mm:ss:zzz]") + " incentive 2 disabled")
                    }
                }
                incentive2FramesCount++
            }
        }
    }

    Label {
        id: label_incentive1
        x: 6
        y: 9
        width: 100
        height: 20
        text: qsTr("Iincentive #1")
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize: 12
    }

    Label {
        id: label_incentive2
        x: 141
        y: 9
        width: 100
        height: 20
        text: qsTr("Incentive #2")
        font.pointSize: 12
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
/////////////////////////////////////////////////////////////////////////////////////////
}
