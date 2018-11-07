import QtQuick 2.0

Rectangle{
    id:r
    property int fs: width*0.04
    //property type name: value
    property int lineCount: 2
    property int cursorPosition: 0
    property string text:''


    color: 'black'




    Flickable{
        id:flTE
        width: r.width
        height:r.height
        contentWidth: flowLin.width
        contentHeight: flowLin.height
        //contentX: xColNL.width
        x:xColNL.width
        Column{
            id:flowLin
            width: r.width
            Repeater{
                id:repLin
                Rectangle{
                    id:xNLin
                    //objectName:'lin'+index
                    width:nlin.contentWidth
                    height: r.fs*1.3
                    border.width: 1
                    color: 'transparent'
                    property int currentLine:index
                    property int instanceIndex: 0
                    Text {
                        id:nlin
                        text: modelData
                        font.pixelSize: parent.height*0.8
                        anchors.bottom:parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        color: 'red'
                        visible:false
                    }
                    Row{
                        id:flowPal
                        width: r.width
                        Repeater{
                            id:repPal
                            Rectangle{
                                id:xNPal
                                //objectName:'pal'+index
                                width:npal.contentWidth
                                height: r.fs*1.3
                                border.width: 1
                                color: 'transparent'
                                property int currentLine:-1
                                 property int instanceIndex: 0
                                Text {
                                    id:npal
                                    font.pixelSize: parent.height*0.8
                                    anchors.bottom:parent.bottom
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    color: 'red'
                                    visible: false
                                }
                                Row{
                                    //width: r.width
                                    Repeater{
                                        id:repCar
                                        Rectangle{
                                            id:xNCar
                                            width:ncar.contentWidth
                                            height: r.fs*1.3
                                            //border.width: 1
                                            //border.color: 'yellow'
                                            color: 'transparent'
                                            Text {
                                                id:ncar
                                                font.pixelSize: r.fs
                                                anchors.bottom:parent.bottom
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                color: 'white'
                                                //text: ''+(''+npal.text).split('')[xNPal.instanceIndex]

                                                Component.onCompleted: {
                                                    var nDataNcar=(''+npal.text).split('')
                                                    ncar.text =''+nDataNcar[xNPal.instanceIndex]
                                                    //xNCar.width=ncar.contentWidth
                                                    xNPal.instanceIndex++
                                                }
                                            }
                                            MouseArea{
                                                anchors.fill: parent
                                                onClicked: {
                                                    //ncar.text+=xNPal.currentLine
                                                    r.setTextPos(xNLin.y, xNPal.x)
                                                }
                                            }
                                            Component.onCompleted: {
                                                //xNPal.instanceIndex++
                                            }
                                        }
                                    }
                                }

                                Component.onCompleted: {
                                    if(xNLin.width>flowLin.width){
                                        flowLin.width=xNLin.width
                                        flTE.contentWidth= flowLin.width
                                    }
                                    var nDataNpal=(''+nlin.text).split(' ')
                                    npal.text =''+nDataNpal[xNLin.instanceIndex]+' '
                                    xNLin.instanceIndex++
                                    var c=npal.text.split('')
                                    repCar.model=c
                                }                               
                            }
                        }
                    }

                    Component.onCompleted:  {
                        r.lineCount++
                        var p=nlin.text.split(' ')
                        repPal.model=p
                    }
                }
            }
        }

    }
    Rectangle{
        id:xColNL
        color:'gray'
        width: ((''+r.lineCount).length)*r.fs
        height: colNL.height
        y:0-flTE.contentY

        Column{
            id:colNL
            width: parent.width
            Repeater{
                model:r.lineCount
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
        Rectangle{
            width: r.fs*0.6
            height: width
            color:'red'
            anchors.centerIn: parent
            radius: width*0.5
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
                flTE.contentY=0-(flTE.height/2)+paly+r.fs
                flTE.x=((flTE.width-carx)/2)-colNL.width
                txtInf.text=+carx
    }
    function updateChars(){
        var p=r.text.split()
        repPal.model=p
    }
}'
        updateChars()
    }

    function setTextPos(paly, carx){
        flTE.contentY=0-(flTE.height/2)+paly+r.fs
        //flTE.x=((flTE.width-carx)/2)-r.fs*3
        flTE.x=carx
        txtInf.text='->'+carx
    }
    function updateChars(){
        var l=r.text.split('\n')
        repLin.model=l
    }
}


