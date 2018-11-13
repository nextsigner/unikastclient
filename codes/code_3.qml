import QtQuick 2.0
Rectangle{
	width:parent.width
	height:parent.height
	color:"yellow"
	Grid{
		columns: 3
		spacing: 4
		anchors.centerIn: parent
		Repeater{
			model: 10
			Rectangle{
				width:30
				height:30
				color:"#ff8833"
			}
		}
	}
}
