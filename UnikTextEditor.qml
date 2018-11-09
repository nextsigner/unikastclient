import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle{
    id:r
    property var flowLin

    property int modo: 1

    property int fs: width*0.04

    property int lineCount: 2
    property int charCount: 0
    property int cursorPosition: 1
    property int currentLine: 0
    property int currentCol: 0
    property string text:''
    property string uCar:''
    property int maxCols: 0


    property string splitString:''

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

        if(r.currentCol>0){
            //r.cursorPosition--
            r.currentCol--
        }

    }
    Keys.onUpPressed:  {
        if(r.currentLine>0){
            r.currentLine--
        }else{
            var nl=''
            for(var i=0;i<r.maxCols;i++){
                nl+=' '
            }
            //r.text=nl+'\n'+r.text
            r.currentLine=0
            //r.text='las dñlfkasñlf sñlkf ñslak fñsl'
            updateChars()
        }

    }
    Keys.onDownPressed:    {
        var cantCol=xData.children[0].children[r.currentLine+1].children[0].children.length
        console.log('AC'+cantCol)
        if(r.currentCol>cantCol){
            r.currentCol=cantCol-1
        }
        r.currentLine++
    }
    //onCursorPositionChanged: r.centrar()
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
            visible:false
        }
        Column{
            id:xD
            Repeater{
                id:repXD
                Rectangle{
                    width:te.contentWidth
                    height: r.fs*1.2
                    border.width: 1
                    border.color: 'black'
                    TextEdit{
                       id:te
                        text:modelData
                        font.pixelSize: r.fs
                        color: 'black'
                        cursorDelegate: Rectangle{width: 6;color:'red'}
                        height: r.fs*1.2
                        anchors.centerIn: parent
                        property int vpr: 0
                        onVprChanged: {
                            if(vpr===2){
                                //var d=new Date(Date.now())
                                //r.splitString=''+d.getTime()+''+d.getTime()
                                //te.insert(te.cursorPosition,r.splitString)
                                //r.splitBlock()
                                //r.splitString
                                //te.insert(te.cursorPosition,''+xD.children[1].children[0].text+'-->')
                            }else{

                            }
                        }
                        Keys.onReturnPressed: {
                            //vpr++
                            //te.insert(te.cursorPosition,'\n')
                            //tret.restart()
                            var d=new Date(Date.now())
                            r.splitString=''+d.getTime()+''+d.getTime()
                            te.insert(te.cursorPosition,r.splitString)
                            r.setEnter()
                        }
                        Timer{
                            id:tret
                            running: false
                            repeat: false
                            interval: 500
                            onTriggered: {
                                    te.vpr=0
                            }
                        }
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

    function updateCharsOut(){
        /*for(var i=0;i<xData.children.length;i++){
            xData.children[i].destroy(0)
        }*/


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
            var m0=dl.split('')
            cl0='import QtQuick 2.0\nRow{\n'
            for(var i2=0;i2<m0.length;i2++){
                cl0+='\nXChar{\n'
                if(i2===0){
                    cl0+='      t:0;\n'
                }else if(i2===m0.length-1){
                    cl0+='      t:1;\n'
                }else{
                    cl0+='      t:-1;\n'
                }
                cl0+='      c:\''+m0[i2]+'\';\n'

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
        sl()
    }
    function setEnter(){
        var nt=''
        for(var i=0;i<xD.children.length-1;i++){
            var d =''+xD.children[i].children[0].text
            console.log('\n\n\n\nt'+i+':'+d)
            var a=d.split(r.splitString)
            if(a.length>1){
                nt+=a[0]+'\n'
                nt+=a[1]+'\n'
            }else{
                nt+=d+'\n'
            }
            //console.log('ssss:'+xD.children[0].children[i].width)
            //var nl=(''+l[i]).length

        }
        r.text=nt
        updateChars()
    }

    function splitBlock(){
        var nt=''
        for(var i=0;i<xD.children.length-1;i++){
            var d =''+xD.children[i].children[0].text
            console.log('\n\n\n\nt'+i+':'+d)
            var a=d.split(r.splitString)
            if(a.length>1){
                nt+=a[0]+'\n'
                nt+=a[1]+'\n'
            }else{
                nt+=d+'\n'
            }
            //console.log('ssss:'+xD.children[0].children[i].width)
            //var nl=(''+l[i]).length

        }
        r.text=nt
        updateChars()
    }
    function updateChars(){
        var d=r.text.replace(/\\n/g,'\\\\n')
        var l=d.split('\n')
        var maxCol=0
        var narray=[]
        for(var i=0;i<l.length;i++){
            var nl=(''+l[i]).length
            if(nl>maxCol){
                maxCol=nl
            }
        }
        repXD.model=l
    }
    function sl(){
        flTE.contentY=0-(flTE.height/2)+(r.fs*1.2*r.currentLine)+r.fs*0.6
        //txtInf.text=''+xData.children[0].children[1].children[0].children[r.currentCol].x
        flTE.x=(r.width/2)-xData.children[0].children[1].children[0].children[r.currentCol].x
        r.uCar='c'+r.currentLine+'-'+r.currentCol
    }
    function addEsp(l,c){
        var cl0=''
        cl0='import QtQuick 2.0\n'
        cl0+='\nXChar{\n'
        cl0+='      t: 1;\n'
        cl0+='      c:\' \';\n'
        cl0+='      h: r.fs;\n'
        cl0+='      fs: r.fs;\n'
        cl0+='      color: objectName===r.uCar?"blue":"yellow";\n'
        cl0+='      fc: "white";\n'
        cl0+='      ed: r;\n'
        cl0+='      lin: '+l+';\n'
        cl0+='      col: '+parseInt(c+1)+';\n'
        cl0+='      border.width: 1;\n'
        cl0+='      border.color: "red";\n'
        cl0+='      Timer {\n'
        cl0+='      running: true\n'
        cl0+='      repeat: false\n'
        cl0+='      interval: 100\n'
        cl0+='      onTriggered: r.currentCol='+parseInt(c+1)+';\n'
        cl0+='      }\n'
        cl0+='\n}\n'
        //console.log('--->'+xData.children[0].children[l].children[0].children.length)
        var car=Qt.createQmlObject(cl0, xData.children[0].children[l].children[0], 'qmlChar')
        xData.children[0].children[r.currentLine].children[0].children[c].t=-1
        //r.maxCols++
        //r.currentCol++

        //sl()
    }
    function dDer(){
        //console.log('RRR: '+xData.children[0].children[r.currentLine].children[0].children[r.currentCol].t)
        /*if(xData.children[0].children[r.currentLine].children[0].children[r.currentCol].t===1){
            addEsp(r.currentLine, r.currentCol)
        }else{
            r.currentCol++
            xData.children[0].children[r.currentLine].children[0].children[r.currentCol].t=-1
        }*/
        if(xData.children[0].children[r.currentLine].children[0].children.length-1===r.currentCol){
            addEsp(r.currentLine, r.currentCol)
        }else{
            r.currentCol++
        }
    }
}


