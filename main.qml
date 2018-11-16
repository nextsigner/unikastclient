import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.2
import QtQuick.Window 2.0
import Qt.labs.settings 1.0
ApplicationWindow {
    id: app
    visible: true
    width: Screen.width/2
    height: Screen.desktopAvailableHeight-altoBarra
    x:Screen.width/2
    title: qsTr("WsSqlClient Example by nextsigner")
    visibility: 'Windowed'
    color: 'black'
    property int altoBarra: 0

    property int fs: appSettings.fs

    property color c1: "#62DA06"
    property color c2: "#8DF73B"
    property color c3: "black"
    property color c4: "white"

    Settings{
        id: appSettings
        category: 'conf-unikasclient'
        property int cantRun
        property bool fullScreen
        property bool logViewVisible

        property int fs

        property int lvh

        property real visibility
    }
    FontLoader {name: "FontAwesome";source: "qrc:/fontawesome-webfont.ttf";}


    UnikTextEditor{
        id:unikTextEditor
        anchors.fill: parent
        fs:app.fs
        color: app.c1
        visible:!wsSqlClient.visible
        onSendCode: wsSqlClient.sendCode(code)
    }
    WsSqlClient{
        id:wsSqlClient
        onLoguinSucess: {
            focus=false
            visible=false
            unikTextEditor.visible=true
            unikTextEditor.textEditor.focus=true
            unikTextEditor.textEditor.setPos()
        }        
        onErrorSucess: {
            console.log('WebSockets Error success...')
            focus=true
            visible=true
            unikTextEditor.visible=false
            unikTextEditor.textEditor.focus=false
        }
        onVisibleChanged: {
            if(!visible){
                focus=false
                }else{
                unikTextEditor.visible=true
            }
        }
    }
    LogView{
        width: parent.width
        height: appSettings.lvh
        fontSize: app.fs
        topHandlerHeight: Qt.platform.os!=='android'?app.fs*0.25:app.fs*0.75
        anchors.bottom: parent.bottom
        //visible: appSettings.logViewVisible
    }
    UnikBusy{id:ub;running: false}
    Shortcut {
        sequence: "Shift+Left"
        onActivated: {

        }
    }
    Shortcut {
        sequence: "Shift+Return"
        onActivated: {
           if(app.visibility!==Window.Maximized){
                app.visibility='Maximized'
           }else{
            app.visibility='Windowed'
           }
        }
    }
    Shortcut {
        sequence: "Ctrl+Shift+q"
        onActivated: {
           Qt.quit()
        }
    }
//    Shortcut {
//        sequence: "Ctrl+r"
//        onActivated: {
//           wsSqlClient.sendCode(unikTextEditor.text)
//        }
//    }
    onVisibilityChanged: {
        appSettings.visibility=app.visibility
    }
    Component.onCompleted: {
        if(appSettings.lvh<=0){
            appSettings.lvh=100
        }
        if(appSettings.fs<=0){
            appSettings.fs=20
        }
        appSettings.logViewVisible=true

//        if(Qt.platform.os==='windows'){
//            var anchoBorde=(app.width-unik.frameWidth(app))/2
//            var altoBarraTitulo=unik.frameHeight(app)-height
//            app.altoBarra=height-(Screen.desktopAvailableHeight-altoBarraTitulo)
//        }
    }
}

