import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2
import Qt.WebSockets 1.0
import "qwebchannel.js" as WebChannel
Item {
    id: r
    anchors.fill: parent
    property int fs: app && app.fs ? app.fs:r.width*0.03
    property var channel
    property var listView
    property url url: "ws://127.0.0.1:12345"
    property var arrayUserList: []
    property string sqliteFileName: 'wssqlclient.sqlite'
    //property var textInputData
    property string loginUserName
    onUrlChanged: {
        socket.url=url
        xWsUrl.visible=false
        xUserName.visible=false
        l.visible=true
    }
    WebSocket {
        id: socket

        // the following three properties/functions are required to align the QML WebSocket API
        // with the HTML5 WebSocket API.
        property var send: function(arg) {
            sendTextMessage(arg);
        }
        onTextMessageReceived: {
            onmessage({data: message});
        }

        property var onmessage

        active: true
        //url: "ws://127.0.0.1:12345"
        url: r.url
        onStatusChanged: {
            switch (socket.status) {
            case WebSocket.Error:
                errorDialog.text = "Error: " + socket.errorString;
                errorDialog.visible = true;
                l.visible=false
                break;
            case WebSocket.Closed:
                errorDialog.text = "Error: Socket at " + url + " closed.";
                errorDialog.visible = true;
                l.visible=false
                break;
            case WebSocket.Open:
                //open the webchannel with the socket as transport
                l.visible=true
                new WebChannel.QWebChannel(socket, function(ch) {
                    r.channel = ch;
                    //r.url=socket.url

                    //connect to the changed signal of the userList property
                    ch.objects.chatserver.userListChanged.connect(function(args) {
                        r.arrayUserList=ch.objects.chatserver.userList
                        var d = new Date(Date.now())
                        var ul = r.arrayUserList
                        for(var i=0; i < ul.length; i++){
                            console.log('Unik WsSql: Addign User: '+ul[i])
                            var sql = 'INSERT INTO users(user, ws, ms)VALUES(\''+ul[i]+'\', \''+r.url+'\',  '+d.getTime()+')'
                            unik.sqlQuery(sql)
                            if(''+ul[i]===tiUserName.text){
                                xUserName.visible=false
                            }
                        }
                        //listModelUser.arrayUserList = ch.objects.chatserver.userList
                        //listModelUser.updateUserList()

                        l.visible=false
                        //                        mainUi.userlist.text = '';
                        //                        ch.objects.chatserver.userList.forEach(function(user) {
                        //                            //mainUi.userlist.text += user + '\n';
                        //                            listModelUser
                        //                        });
                    });

                    //connect to the newMessage signal
                    ch.objects.chatserver.newMessage.connect(function(time, user, message) {
                        var d = new Date(Date.now())
                        console.log('Unik WsSql: Addign QmlCode: '+message)
                        var sql = 'INSERT INTO users(user, ws, ms)VALUES(\''+message+'\', \''+user+'\', \''+r.url+'\',  '+d.getTime()+')'
                        unik.sqlQuery(sql)
                    });

                    //connect to the keep alive signal
                    ch.objects.chatserver.keepAlive.connect(function(args) {
                        if (r.loginUserName !== '')
                            //and call the keep alive response method as an answer
                            ch.objects.chatserver.keepAliveResponse(r.loginUserName);
                    });
                });
                xUserName.visible=true;
                break;
            }
        }
    }

    ListModel{
        id: listModelUser
        property var arrayUserList: []
        function createElement(u){
            return {
                user: u
            }
        }
        function updateUserList(){
            console.log('Unik WsSql: Updating User List...')
            clear()
            var ul = arrayUserList;
            for(var i=0; i < ul.length; i++){
                append(createElement(ul[i]))
                console.log('Unik WsSql: Addign User: '+ul[i])
            }
        }
    }
    ListModel{
        id: listModelMsg
        function createElement(m){
            return {
                msg: m
            }
        }
        function addMsg(msg){
            append(createElement(msg))
        }
    }

    Rectangle {
        id: xUserName
        width: 300
        height: 200
        visible:false
        anchors.centerIn: parent
        Column{
            spacing: r.fs*0.5
            Row{
                spacing: r.fs*0.5
                Text{
                    text: 'User Name: '
                    font.pixelSize: r.fs
                }
                TextArea{
                    id:tiUserName
                    width: r.width*0.5

                }
                /*Rectangle{
                    id:xTiUser
                    width: r.width*0.5
                    height: r.fs*1.2
                    border.width: 1
                    radius: 8
                    TextInput{
                        id:tiUserName
                        font.pixelSize: r.fs
                        width: parent.width
                        height: r.fs
                        anchors.centerIn: parent
                    }
                }*/
            }
            Button{
                text: 'Conectar'
                font.pixelSize: r.fs
                anchors.right: parent.right
                onClicked: {
                    //call the login method
                    r.channel.objects.chatserver.login(tiUserName.text, function(arg) {
                        //check the return value for success
                        if (arg === true) {
                            //loginUi.nameInUseError.visible = false;
                            r.loginUserName=tiUserName.text
                            tiUserName.color=undefined
                            xUserName.visible=false
                        } else {
                            tiUserName.color='red'
                        }
                    });
                }
            }
        }
    }


    Rectangle {
        id: xWsUrl
        width: r.width*0.8
        height: r.width*0.02
        anchors.centerIn: parent
        visible:false
        onVisibleChanged: {
            if(visible){
                tiWebSocketUrl.text=r.url
            }
        }
        Column{
            spacing: r.fs*0.5
            Row{
                spacing: r.fs*0.5
                Text{
                    text: 'WebSockets Url: '
                    font.pixelSize: r.fs
                }
                Rectangle{
                    width: r.width*0.5
                    height: r.fs*1.2
                    border.width: 1
                    radius: 8
                    TextInput{
                        id:tiWebSocketUrl
                        font.pixelSize: r.fs
                        width: parent.width
                        height: r.fs
                        anchors.centerIn: parent
                        Keys.onReturnPressed:r.url=tiWebSocketUrl.text
                        //                        onEditingFinished:{
                        //
                        //                        }
                    }
                }
            }
            Button{
                text: 'Conectar'
                font.pixelSize: r.fs
                anchors.right: parent.right
                onClicked: {
                    xWsUrl.visible=false
                    r.url=tiWebSocketUrl.text
                }
            }
        }
    }

    Text {
        id: l
        text: 'Connecting '+socket.url
        font.pixelSize: r.fs
        anchors.horizontalCenter: r.horizontalCenter
        anchors.top: r.top
        anchors.topMargin: r.fs*0.5
        visible: false
    }
    MessageDialog {
        id: errorDialog
        icon: StandardIcon.Critical
        standardButtons: StandardButton.Close
        title: "Unik WebSockets Client"
        onAccepted: {
            xUserName.visible=false
            tiWebSocketUrl.text=r.url
            xWsUrl.visible=true
        }
        onRejected: {
            xUserName.visible=false
            tiWebSocketUrl.text=r.url
            xWsUrl.visible=true
        }
    }
    Component.onCompleted:{
        unik.sqliteInit(sqliteFileName)
        var sql=''
        sql= 'CREATE TABLE IF NOT EXISTS users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user TEXT,
            ws TEXT,
            ms NUMERIC
            )'
        unik.sqlQuery(sql)

        sql= 'CREATE TABLE IF NOT EXISTS qmlcodes(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            code TEXT,
            user TEXT,
            ws TEXT,
            ms NUMERIC
            )'
        unik.sqlQuery(sql)
    }
    function sendCode(c){
        console.log("WsSql sending "+r.loginUserName+" "+c)
        r.channel.objects.chatserver.sendMessage(r.loginUserName,c);
    }
}
