import QtQuick 2.0
Rectangle{
	width:parent.width
	height:parent.height
	color:"blue"
	ListView{
		width:parent.width*0.4
		height:width
		spacing:4
		anchors.centerIn: parent
		model:listModel
		delegate: delegate
		ListModel{
			id:listModel
			ListElement{
				txt:"Articulo 1"
			}
			ListElement{
				txt:"Articulo 2"
			}
			ListElement{
				txt:"Articulo 3"
			}
		}
		Component{
			id:delegate
			Text{
				text:txt
				width:parent.width*0.9
				height: 20
				font.pixelSize: parent.width*0.1
				wrapMode: Text.WordWrap
				}
		}
	}	
}
