import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Window 2.0

Window{
    id:      mainWnd
    flags:   Qt.Tool
    title:   "Incentives"
    visible: true

    width:        450
    maximumWidth: 450
    minimumWidth: 450

    height:        640
    maximumHeight: 640
    minimumHeight: 640


    Label{
        id: label_visibility1
        y: 262
        width: 200
        height: 20
        text: qsTr("1. Visible every")
        anchors.left: parent.left
        anchors.leftMargin: 14
        font.bold: false
        verticalAlignment: Text.AlignVCenter
    }

    SpinBox {
        id: spinBox_visibility1
        y: 288
        width: 200
        height: 20
        suffix: qsTr("frames")
        minimumValue: 1
        maximumValue: 5000
        value: 1
        decimals: 1
        anchors.left: parent.left
        anchors.leftMargin: 14
        antialiasing: true
    }

    Label {
        id: label_visibility2
        x: 236
        y: 262
        width: 200
        height: 20
        text: qsTr("2. Visibly every")
        anchors.left: label_visibility1.right
        anchors.leftMargin: 22
        verticalAlignment: Text.AlignVCenter
    }

    SpinBox {
        id: spinBox_visibility2
        x: 236
        y: 288
        width: 200
        height: 20
        suffix: qsTr("frames")
        minimumValue: 1
        maximumValue: 5000
        value: 1
        decimals: 1
        anchors.left: spinBox_visibility1.right
        anchors.leftMargin: 22
        antialiasing: true
    }

    //параметры стимула №1, для стимула №2 аналогично
    property bool incentive1IsEnabled:  false //флаг видимости стимула
    property int incentive1FramesCount: 0     //счетчик кадров

    Rectangle
    {
        id: incentive1
        y: 12
        width: 200
        height: width
        radius: width/2
        color: "green"
        anchors.left: parent.left
        anchors.leftMargin: 14
        visible: false
    }


    //параметры стимула №2
    property bool incentive2IsEnabled:  false
    property int incentive2FramesCount: 0

    Rectangle
    {
        id: incentive2
        x: 236
        y: 12
        width: 200
        height: width
        radius: width/2
        color: "red"
        anchors.right: parent.right
        anchors.rightMargin: 14
        visible: false
    }

    TextArea {
        id: textArea_log
        y: 453
        height: 249
        antialiasing: true
        font.pointSize: 8
        font.family: "Courier"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 9
        anchors.left: parent.left
        anchors.leftMargin: 14
        anchors.right: parent.right
        anchors.rightMargin: 14
        anchors.top: spinBox_visibility1.bottom
        anchors.topMargin: 14

    }

    property bool workInProcess: false
    Button {
        id: button_stop
        x: 14
        y: 218
        width: 200
        height: 38
        text: qsTr("Stop")
        anchors.left: parent.left
        anchors.leftMargin: 14
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
        x: 472
        y: 218
        width: 200
        height: 38
        text: qsTr("Start")
        anchors.left: button_stop.right
        anchors.leftMargin: 22
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
    Connections {
        target: mainWnd
        onFrameSwapped:
        {
            if(workInProcess){
                if(incentive1FramesCount < spinBox_visibility1.value){
                    if(!incentive1IsEnabled){
                        console.log(Qt.formatTime(new Date(), "[hh:mm:ss:zzz]") + " incentive 1 enabled")
                        textArea_log.append(Qt.formatTime(new Date(), "[hh:mm:ss:zzz]") + qsTr(" incentive 1 enabled"))
                        incentive1.visible  = true
                        incentive1IsEnabled = true
                    }
                }else{
                    incentive1FramesCount = 0
                    if(incentive1IsEnabled){
                        console.log(Qt.formatTime(new Date(), "[hh:mm:ss:zzz]") + " incentive 1 disabled")
                        textArea_log.append(Qt.formatTime(new Date(), "[hh:mm:ss:zzz]") + qsTr(" incentive 1 disabled"))
                        incentive1.visible  = false
                        incentive1IsEnabled = false
                    }
                }
                incentive1FramesCount++

                if(incentive2FramesCount < spinBox_visibility2.value){
                    if(!incentive2IsEnabled){
                        console.log(Qt.formatTime(new Date(), "[hh:mm:ss:zzz]") + " incentive 2 enabled")
                        textArea_log.append(Qt.formatTime(new Date(), "[hh:mm:ss:zzz]") + qsTr(" incentive 2 enabled"))
                        incentive2.visible  = true
                        incentive2IsEnabled = true
                    }
                }else{
                    incentive2FramesCount = 0
                    if(incentive2IsEnabled){
                        console.log(Qt.formatTime(new Date(), "[hh:mm:ss:zzz]") + " incentive 2 disabled")
                        textArea_log.append(Qt.formatTime(new Date(), "[hh:mm:ss:zzz]") + qsTr(" incentive 2 disabled"))
                        incentive2.visible  = false
                        incentive2IsEnabled = false
                    }
                }
                incentive2FramesCount++
            }
        }
    }
/////////////////////////////////////////////////////////////////////////////////////////
}
