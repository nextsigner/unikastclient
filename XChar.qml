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
    objectName: 'c'+lin+'-'+col
    Text{
        id:dc
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

