import QtQuick

Column {
  id: infoLabel
  spacing: 5

  property alias text: label.text
  property alias font: label.font
  property int lineWidth: 200
  property int lineHeight: 2
  property color lineColor: "#191919"

  Rectangle {
    width: infoLabel.lineWidth
    height: infoLabel.lineHeight
    color: infoLabel.lineColor
  }

  Text {
    id: label
    anchors.horizontalCenter: parent.horizontalCenter
  }

  Rectangle {
    width: infoLabel.lineWidth
    height: infoLabel.lineHeight
    color: infoLabel.lineColor
  }
}
