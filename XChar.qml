import QtQuick 2.0

Rectangle {
    id:r
    width: dc.contentWidth
    property alias c: dc.text
    property alias h: r.height
    property alias fs: dc.font.pixelSize
    property alias fc: dc.color
    property int lin:-1
    property int col:-1
    property var ed
    property int t:-1//0=firts 1=last
    objectName: 'c'+lin+'-'+col
    Text{
        id:dc
    }
    Rectangle{
        width: r.width-2
        height: r.height-2
        anchors.centerIn: r
        border.width: 3
        border.color: '#ff8833'
        color: 'transparent'
        visible:r.t===1
    }
    MouseArea{
        anchors.fill: r
        onClicked: {
                r.ed.currentLine=r.lin
            r.ed.currentCol=r.col
            r.ed.sl()
        }

        }
}

