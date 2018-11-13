import QtQuick 2.0
Rectangle{
	width:parent.width
	height:parent.height
	color:"#ff8833"
	Flow{
		width: 300
		//layoutDirection: Qt.RightToLeft
		layoutDirection: Qt.LeftToRight
		spacing: 4
		anchors.centerIn: parent
		Repeater{
			model: 10
			Rectangle{
				width:30
				height:30
				color:"blue"
			}
		}
	}
}
