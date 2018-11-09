import QtQuick 2.5
import QtQuick.Controls 2.0
import Qt.labs.settings 1.0
Item{
    id:r
    property int modo: 1

    property int fs: 16
    property color color:'white'
    property color backgroundColor:'black'
    property string text:''
    property bool modificado: false

    property int col: 0
    property int lin: 0

    Settings{
        id: eSettings
        category: 'conf-unikeditor'

        property int fs
        property string currentFilePath
    }

    focus: true
    /*Keys.onPressed:  {
        if (event.key == Qt.Key_I){
                r.modo=1
        }
    }*/
    onModoChanged: {
        if(modo===1){

        }
        if(modo===0){
            //te.focus=false
            //r.focus=true
        }
    }
    Flickable{
        id:flTE
        width: r.width
        height:r.height-xTF.height-r.fs
        contentWidth: te.contentWidth*1.5
        contentHeight: te.contentHeight*1.5
        x:((''+te.lineCount).length)*r.fs
        anchors.top: xTF.bottom
        anchors.topMargin: r.fs
        enabled: r.modo===1
        Item{
            id:xTE
            width:te.text===''?1:te.contentWidth
            height: te.contentHeight
            x:r.width*0.5
            TextEdit{
                id:te
                text:r.text
                font.pixelSize: r.fs
                color: r.color

                property bool ins: false
                property string ccl: '.'
                cursorDelegate: Rectangle{
                    id:teCursor
                    width: tec.width;
                    height: r.fs
                    radius: width*0.5
                    color:'transparent'
//                    onXChanged: {
//                        var nc=0
//                        var n=te.cursorPosition
//                        if(n>0){
////                            while(te.text.substring(n-1,n)!=='\n'||n>0){
////                                nc++
////                                n--
////                            }
//                        }
//                        r.col=nc
//                    }
                    Rectangle{
                        id:tec
                        width: cc.contentWidth;
                        height: r.fs
                        border.width: 2
                        border.color: 'red'
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.left
                        color:'transparent'
                        visible:te.ccl!=='\n'
                        Text{
                            id:cc
                            text:te.ccl!==''&&te.ccl!=='\n'?te.ccl:' '
                            font.pixelSize: te.font.pixelSize
                            color: 'red'
                            anchors.centerIn: parent
                        }
                    }
                    Item{
                        id:tecinit
                        width: ccinit.contentWidth;
                        height: r.fs
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: tec.right
                        visible:te.ccl==='\n'
                        Text{
                            id:ccinit
                            text:'\uf061'
                            font.family: 'FontAwesome'
                            font.pixelSize: te.font.pixelSize
                            color: 'red'
                            anchors.centerIn: parent
                        }
                    }
                    SequentialAnimation{
                        id:san1
                        running: te.ins
                        onStopped: te.ins=false
                        NumberAnimation {
                            target: cc
                            property: "opacity"
                            from:1.0
                            to:0.0
                            duration: 1000
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
                width: r.width
                height: r.fs*1.2
                wrapMode: Text.WordWrap
                property int vpe: 0
                Timer{
                    id:tvpe
                    running: false
                    repeat: false
                    interval: 250
                    onTriggered: {
                        if(te.vpe===2){
                            te.insert(te.cursorPosition, '\n')
                        }else{
                            r.modo=0
                            app.focus=true
                        }
                        te.vpe=0
                    }
                }
                Keys.onReturnPressed: {
                    vpe++
                    tvpe.start()
                }
                onTextChanged: {
                    te.ins=true
                    te.setPos()
                    r.modificado=true
                }
                onCursorPositionChanged: te.setPos()
                function setPos(){
                    //console.log('LLLLL:-'+te.text.substring(te.cursorPosition-1,te.cursorPosition)+'-')
                    te.ccl=te.text.substring(te.cursorPosition-1,te.cursorPosition)
                    flTE.contentX=(te.cursorRectangle.x)+r.fs+r.fs*0.5+te.cursorRectangle.width
                    flTE.contentY=(te.cursorRectangle.y-r.height/2)+r.fs*0.5+flTE.y
                    r.lin=parseInt(te.cursorRectangle.y/te.cursorRectangle.height)

                }
            }
        }
        Rectangle{
            id:xColNLI
            color:r.backgroundColor
            width: ((''+te.lineCount).length)*r.fs
            height: colNLI.height
            y:xTE.y
            anchors.right: xTE.left
            Rectangle{
                width: 1
                height: r.height
                anchors.right: parent.right
                color: r.color
            }

            Column{
                id:colNLI
                width: parent.width-2
                Repeater{
                    model:te.lineCount
                    Item{
                        id:xNlI
                        width:(nli.text.length-8)*r.fs
                        height: r.fs*1.3
                        anchors.right: parent.right
                        Text {
                            id:nli
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

    }
    Rectangle{
        id:xColNL
        color:r.backgroundColor
        width: ((''+te.lineCount).length)*r.fs
        height: colNL.height
        y:0-flTE.contentY
        visible:flTE.contentX>r.width/2
        Rectangle{
            width: 1
            height: r.height
            anchors.right: parent.right
            color: r.color
        }

        Column{
            id:colNL
            width: parent.width-2
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
        id:xTF
        color: r.backgroundColor
        width: tf.contentWidth+r.fs
        height: r.fs*1.2
        border.width: 1
        border.color: r.color
        visible:r.modo===2
        onVisibleChanged: {
            if(visible){
                tf.focus=true
                tf.cursorPosition=tf.text.length-1
            }
        }
        TextEdit{
            id:tf
            text:eSettings.currentFilePath
            font.pixelSize: r.fs
            color: r.color
            anchors.verticalCenter: parent.verticalCenter
            x:r.fs*0.5
            cursorDelegate: Rectangle{
                id:tfCursor
                width: r.fs*0.5
                height: r.fs
                radius: width*0.5
                color:cv?r.color:'transparent'
                property bool cv: true
                Timer{
                    running: xTF.visible
                    repeat: true
                    interval: 650
                    onTriggered: tfCursor.cv=!tfCursor.cv
                }
            }
            width: r.width
            height: r.fs*1.2
            wrapMode: Text.WordWrap
            onTextChanged: {
                tf.color=unik.fileExist(tf.text)?r.color:'red'
            }
            Keys.onReturnPressed: {
                eSettings.currentFilePath=tf.text
                r.text=unik.getFile(eSettings.currentFilePath)
                console.log('UnikEditor Loading: '+r.text)
            }
            Keys.onEscapePressed: r.modo=1
        }


    }
    Rectangle{
        id:xCentro
        width: r.fs*5
        height: r.fs*2
        border.width: bw
        border.color: 'red'
        color:'transparent'
        anchors.centerIn: r
        visible: r.modo===1
        radius: r.modificado?r.fs:0
        property int bw: 5
        SequentialAnimation{
            running: !te.ins
            loops: Animation.Infinite
            onRunningChanged: xCentro.bw=1
            NumberAnimation {
                target: xCentro
                property: "bw"
                from:1
                to:4
                duration: 1000
                easing.type: Easing.InOutQuad
            }
        }
        Rectangle{
            width: r.fs*0.6
            height: width
            color:'red'
            anchors.centerIn: parent
            radius: width*0.5
            opacity: 0.0
        }
    }

    Text{
        text:'line: '+r.lin+' column: '+r.col
        font.pixelSize: r.fs*0.5
        color: r.color
        anchors.bottom: r.bottom
        anchors.bottomMargin: r.fs*2
        anchors.right: r.right
    }
    Shortcut {
        sequence: "Ctrl+Shift+a"
        onActivated: {
            r.modo=2
        }
    }
    Shortcut {
        sequence: "Ctrl+s"
        onActivated: {
            unik.setFile(eSettings.currentFilePath, te.text)
            r.modificado=false
        }
    }
    Shortcut {
        sequence: "Shift+Up"
        context: Qt.ApplicationShortcut
        onActivated: {
            console.log('---------------------')
            if(appSettings.fs<100){
                appSettings.fs++
            }
        }
    }
    Shortcut {
        sequence: "Shift+Down"
        context: Qt.ApplicationShortcut
        onActivated: {
            if(appSettings.fs>8){
                appSettings.fs--
            }

        }
    }
    Shortcut {
        sequence: "i"
        context: Qt.ApplicationShortcut
        onActivated: {
            r.modo=1
        }
    }
    Shortcut {
        sequence: "j"
        context: Qt.ApplicationShortcut
        onActivated: {
            te.cursorPosition--
        }
    }
    Shortcut {
        sequence: "l"
        context: Qt.ApplicationShortcut
        onActivated: {
            te.cursorPosition++
        }
    }
    Shortcut {
        sequence: "m"
        context: Qt.ApplicationShortcut
        onActivated: {
            /*var ca=0;
            var ca2=0;
            var n=te.cursorPosition
            while(te.text.substring(n-1,n)!=='\n'){
                ca++
                n--
            }
            n=te.cursorPosition
            while(te.text.substring(n,n+1)!=='\n'){
                ca2++
                n++
            }
            te.cursorPosition+=ca+ca2+1*/
        }
    }
    Shortcut {
        sequence: "k"
        context: Qt.ApplicationShortcut
        onActivated: {
            console.log('-->>'+parseInt(te.cursorRectangle.y/te.cursorRectangle.height))
            /*var ca=0;
            var ca2=0;
            var n=te.cursorPosition
            while(te.text.substring(n-1,n)!=='\n'){
                ca++
                n++
            }
            n=te.cursorPosition
            while(te.text.substring(n,n+1)!=='\n'){
                ca2++
                n--
            }
            te.cursorPosition-=ca+ca2+1*/
        }
    }

    Component.onCompleted: {
        r.text=unik.getFile(eSettings.currentFilePath)
        te.focus=true
        te.cursorPosition=1
        te.setPos()
    }


}
/*
    Modos
    1=Insertar
    2=Abrir
*/
