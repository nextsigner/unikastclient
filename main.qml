import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Window 2.0

ApplicationWindow {
    id: app
    visible: true
    width: Screen.width/2
    height: Screen.desktopAvailableHeight
    x:Screen.width/2
    title: qsTr("WsSqlClient Example by nextsigner")

    property int fs: width*0.02



    Rectangle{
        visible: wsSqlClient.loginUserName!==''&&wsSqlClient.loginUserName!==undefined
        width: app.width-app.fs
        height: app.height-app.fs
        anchors.centerIn: parent
        border.width: 1
        anchors.bottom: parent.bottom
        Column{
            spacing: app.fs
            anchors.centerIn: parent
             TextArea{
                id:code
                width: parent.parent.width
                height: parent.parent.height-btnSend.height-app.fs*2
                font.pixelSize: app.fs*2
            }
             Button{
                 id:btnSend
                text: 'Send Code'
                onClicked:wsSqlClient.sendCode(code.text)
             }
        }
    }

    WsSqlClient{id:wsSqlClient}

    Component.onCompleted: {
        var c='import QtQuick 2.0
            Rectangle{
                width: 100
                height: 50
                color: "red"
            }

    '
        code.text=c
    }

}
