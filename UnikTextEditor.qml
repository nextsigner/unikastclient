import QtQuick 2.0

Rectangle{
    id:r
    property var flowLin

    property int modo: -1

    property int fs: width*0.04

    property int lineCount: 2
    property int charCount: 0
    property int cursorPosition: 1
    property int currentLine: 0
    property int currentCol: 0
    property string text:''
    property string uCar:''
    property int maxCols: 0

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
        r.cursorPosition++
        if(r.currentCol<r.maxCols){
            r.currentCol++
        }

    }
    Keys.onLeftPressed:   {
        r.cursorPosition--
        if(r.currentCol>0){
            r.currentCol--
        }

    }
    Keys.onUpPressed:  {
        r.currentLine--
    }
    Keys.onDownPressed:    {
        r.currentLine++
    }
    onCursorPositionChanged: r.centrar()
    onCurrentLineChanged: r.sl()
    onCurrentColChanged:  r.sl()
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
        contentWidth: r.fs*100
        contentHeight: r.lineCount
        x:((''+r.lineCount).length)*r.fs
        Row{
            id:xData
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

    function updateChars(){
       r.lineCount=0
        var d=r.text.replace(/\\n/g,'\\\\n')
        var l=d.split('\n')
        var ccolLin='import QtQuick 2.0\nColumn{\nid:colLinea;\n'
        var maxCol=0
        for(var i=0;i<l.length;i++){
            r.lineCount++
            var nl = ''+l[i]
            var nl2=nl.replace(/\'/g, '\\\'')
            if(nl2.length>maxCol){
                maxCol=nl2.length
            }
            var cl0='\nItem{\n'
            cl0+='\n    property string l:\''+nl2+'\';\n'
            cl0+='      width: 100;\n'
            cl0+='      height: r.fs*1.2;\n'
            cl0+='      Component.onCompleted:{\n'
            cl0+='              var an=r.fs*'+nl.length+';\n'
            cl0+='              if(an*2>flTE.contentWidth){\n'
            cl0+='                  flTE.contentWidth=ar*2\n'
            cl0+='              }\n'
            cl0+='      }\n'
            cl0+='\n}\n'
            ccolLin+=cl0
        }
        ccolLin+='      Component.onCompleted:{\n'
        ccolLin+='              r.flowLin=colLinea;\n'
        ccolLin+='      }\n'
        ccolLin+='}\n'
        var lin=Qt.createQmlObject(ccolLin, xData, 'qmlLin')
        for(var i=0;i<l.length;i++){
            var dl = ''+xData.children[0].children[i].l
            //console.log('-->>'+dl)
            var m0=dl.split('')
            cl0='import QtQuick 2.0\nRow{\n'
            //for(var i2=0;i2<m0.length;i2++){
            for(var i2=0;i2<maxCol;i2++){
                cl0+='\nXChar{\n'
                if(i2<m0.length){
                    cl0+='      c:\''+m0[i2]+'\';\n'
                }else{
                    cl0+='      c:\' \';\n'
                }
                cl0+='      h: r.fs;\n'
                cl0+='      fs: r.fs;\n'
                cl0+='      color: objectName===r.uCar?"red":"transparent";\n'
                cl0+='      fc: "white";\n'
                cl0+='      ed: r;\n'
                cl0+='      lin: '+i+';\n'
                cl0+='      col: '+i2+';\n'
                cl0+='      border.width: 1;\n'
                cl0+='      border.color: "white";\n'
                cl0+='\n}\n'
            }
            cl0+='\n}\n'
             var car=Qt.createQmlObject(cl0, xData.children[0].children[i], 'qmlChar')



        }
        r.maxCols=maxCol
    }
    function sl(){
        flTE.contentY=0-(flTE.height/2)+(r.fs*1.2*r.currentLine)+r.fs*0.6
        txtInf.text=''+xData.children[0].children[1].children[0].children[r.currentCol].x
        flTE.x=(r.width/2)-xData.children[0].children[1].children[0].children[r.currentCol].x
        r.uCar='c'+r.currentLine+'-'+r.currentCol
    }
}


