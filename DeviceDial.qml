import QtQuick

Image {
  id: dial
  source: "assets/Knob-Markings.png"

  property alias text: dialLabel.text

  property int value
  property real angle

  readonly property int minimumValue: 0
  readonly property int maximumValue: 100
  readonly property int range: dial.maximumValue - dial.minimumValue

  DragHandler {
    target: null
    onCentroidChanged: updateValueAndRotation()

    function updateValueAndRotation() {
      if (centroid.pressedButtons !== Qt.LeftButton) {
        return;
      }

      const startAngle = -140;
      const endAngle = 140;

      const yy = dial.height / 2.0 - centroid.position.y;
      const xx = centroid.position.x - dial.width / 2.0;

      const radianAngle = Math.atan2(yy, xx);
      let newAngle = (-radianAngle / Math.PI * 180.0) + 90;

      newAngle = ((newAngle - dial.angle + 180) % 360) - 180 + dial.angle;

      dial.angle = Math.max(startAngle, Math.min(newAngle, endAngle));
      dial.value = (dial.angle - startAngle) / (endAngle - startAngle) * dial.range;

      console.log("angle: ", dial.angle, "value: ", dial.value);
    }
  }

  Image {
    source: "assets/Knob-Dial.png"
    anchors.centerIn: parent
    rotation: dial.angle
  }

  DeviceText {
    id: dialLabel
    anchors.top: dial.bottom
    anchors.horizontalCenter: dial.horizontalCenter
  }

  DeviceText {
    text: qsTr("MIN")
    anchors.left: dial.left
    anchors.bottom: dial.bottom
    font.pixelSize: 6
  }

  DeviceText {
    text: qsTr("MAX")
    anchors.left: dial.right
    anchors.bottom: dial.bottom
    font.pixelSize: 6
  }
}
