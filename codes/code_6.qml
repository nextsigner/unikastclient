import QtWebEngine 1.4
WebEngineView{
	id: wv
	anchors.fill:parent
	//url: 'http://www.unikode.org/'
	url: 'https://www.youtube.com/watch?v=VcwBZMzYXzY'
	
	property int previsibility: 1
	onFullScreenRequested: {
            if(request.toggleOn){
                wv.previsibility=app.visibility
                app.visibility = "FullScreen"
                wv.state = "FullScreen"
            }else{
                app.visibility = wv.previsibility
                wv.state = ""
            }
            request.accept()
        }
}
