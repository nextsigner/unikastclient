import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle{
    id:r
    property var flowLin

    property int modo: 1

    property int fs: width*0.04

    property string text:''

    focus: true
    Keys.onEscapePressed: {
        r.modo=0
    }
    Keys.onEnterPressed: {
        if(r.modo!==1){
            r.modo=1
        }
    }
    Keys.onReturnPressed:  {
        if(r.modo!==1){
            r.modo=1
        }
    }
    Keys.onRightPressed:   {
        dDer()
    }
    Keys.onLeftPressed:   {

    }
    Keys.onUpPressed:  {

    }
    Keys.onDownPressed:    {

    }
    onModoChanged: {
        if(modo===1){
            r.uCar='c'+cursorPosition
            txtInf.text=r.uCar
        }
    }

    color: 'black'

    Flickable{
        id:flTE
        width: r.width
        height:r.height
        contentWidth: xTE.width*2
        contentHeight: te.contentHeight*2
        x:((''+te.lineCount).length)*r.fs
        Rectangle{
            id:xTE
            width:te.text===''?1:te.contentWidth
            height: te.contentHeight//r.fs*1.2
            border.width: 1
            border.color: 'black'
            TextEdit{
                id:te
                text:r.text
                font.pixelSize: r.fs
                color: 'black'
                property bool ins: false
                property string ccl: '.'
                cursorDelegate: Rectangle{
                    id:teCursor
                    width: r.fs;
                    height: r.fs
                    radius: width*0.5
                    color:'transparent'
                    Rectangle{
                        id:tec
                        width: r.fs;
                        height: r.fs
                        border.width: 2
                        border.color: 'red'
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.left
                        color:'transparent'
                        Text{
                            id:cc
                            text:te.ccl
                            font.pixelSize: r.fs
                            color: 'red'
                            anchors.centerIn: parent
                        }
                    }
                    SequentialAnimation{
                        id:san1
                        running: te.ins
                        onStopped: te.ins=false
                        NumberAnimation {
                            target: tec
                            property: "width"
                            from:0
                            to:cc.contentWidth
                            duration: 200
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
                width: r.width
                height: r.fs*1.2
                wrapMode: Text.WordWrap
                onTextChanged: {
                    te.ins=true
                    te.setPos()
                }
                onCursorPositionChanged: te.setPos()
                function setPos(){
                    flTE.contentX=(te.cursorRectangle.x-r.width/2)+r.fs
                    flTE.contentY=(te.cursorRectangle.y-r.height/2)+r.fs*0.5
                    te.ccl=te.text.substring(te.cursorPosition-1,te.cursorPosition)
                    console.log('LLLLL:'+te.text.substring(te.cursorPosition-1,te.cursorPosition))
                }
            }
        }

    }
    Rectangle{
        id:xColNL
        color:'gray'
        width: ((''+te.lineCount).length)*r.fs
        height: colNL.height
        y:0-flTE.contentY

        Column{
            id:colNL
            width: parent.width
            Repeater{
                model:te.lineCount
                Item{
                    id:xNl
                    width:(nl.text.length-8)*r.fs
                    height: r.fs*1.3
                    anchors.right: parent.right
                    Text {
                        id:nl
                        text: '<b>'+parseInt(index+1)+'.</b>'
                        font.pixelSize: parent.height*0.8
                        anchors.bottom:parent.bottom
                        anchors.right: parent.right
                        color: 'white'
                    }
                    //Component.onCompleted: colNL.width=nl.contentWidth
                }
            }
        }
    }
    Rectangle{
        id:xCentro
        width: r.fs*5
        height: r.fs*2
        border.width: 2
        border.color: 'red'
        color:'transparent'
        anchors.centerIn: r
        visible: r.modo===1
        Rectangle{
            width: r.fs*0.6
            height: width
            color:'red'
            anchors.centerIn: parent
            radius: width*0.5
            opacity: 0.5
        }
    }
    Rectangle{
        id:xInfo
        width: r.fs*5
        height: r.fs*2
        border.width: 2
        border.color: 'red'
        color:'black'
        anchors.top: xCentro.bottom
        anchors.horizontalCenter: r.horizontalCenter
        visible: xCentro.visible
        Text {
            id: txtInf
            text: '---'
            color: 'red'
            font.pixelSize: r.fs
            anchors.centerIn: parent
        }
    }
    Component.onCompleted: {

        r.text='Rectangle{
        id:xCentro
        width: r.fs*5
        height: r.fs*2
        border.width: 2
        border.color: red
        color:transparent
        anchors.centerIn: r
        Rectangle{
            width: r.fs*0.6
            height: width
            color:red
            anchors.centerIn: parent
            radius: width*0.5
        }
    }
    Rectangle{
        id:xInfo
        width: r.fs*5
        height: r.fs*2
        border.width: 2
        border.color: red
        color:black
        anchors.top: xCentro.bottom
        anchors.horizontalCenter: r.horizontalCenter
        Text {
            id: txtInf
            text: "...."
            color: "red"
            font.pixelSize: r.fs
            anchors.centerIn: parent
        }
    }
    Component.onCompleted: {
        updateChars()
    }

    function setTextPos(paly, carx){
                flTE.contentY=0-(flTE.height/2)+paly+r.fs dsssssssssss sdddddddddddddd dssssssssssssssss
                flTE.x=((flTE.width-carx)/2)-colNL.width
                txtInf.text=+carx
    }
    function updateChars(){
        var p=r.text.split()
        repPal.model=p
    }
}'
        updateChars()
        r.uCar='c0'
    }


}
