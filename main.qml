import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.2
import QtQuick.Window 2.0

ApplicationWindow {
    id: app
    visible: true
    width: Screen.width/2
    height: Screen.desktopAvailableHeight
    x:Screen.width/2
    title: qsTr("WsSqlClient Example by nextsigner")
    color: 'black'
    property int fs: width*0.02

    UnikTextEditor{
        id:unikTextEditor
        anchors.fill: parent
    }



    WsSqlClient{
        id:wsSqlClient
        opacity: 0.0
    }

    Component.onCompleted: {
        var c='import QtQuick 2.0
            Rectangle{
                width: 100
                height: 50
                color: "red"
            }

    '
        //code.text=c
    }

}
