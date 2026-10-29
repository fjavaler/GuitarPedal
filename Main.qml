import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Basic

ApplicationWindow {
  id: window
  minimumWidth: 260
  minimumHeight: 380
  maximumWidth: minimumWidth
  maximumHeight: minimumHeight
  visible: true
  title: qsTr("Guitar Pedal")

  FontLoader {
    id: russoFontLoader
    source: "fonts/RussoOne-Regular.ttf"
  }

  FontLoader {
    id: prismaFontLoader
    source: "fonts/Prisma.ttf"
  }

  Image {
    id: pedalBackground
    source: "assets/Guitar-Pedal-Background.png"
    anchors.fill: parent
  }

  Item {
    anchors.fill: parent
    anchors.leftMargin: 15
    anchors.rightMargin: 15
    anchors.topMargin: 15
    anchors.bottomMargin: 15

    ScrewImage {
      anchors.top: parent.top
      anchors.left: parent.left
    }

    ScrewImage {
      anchors.top: parent.top
      anchors.right: parent.right
    }

    ScrewImage {
      anchors.bottom: parent.bottom
      anchors.left: parent.left
    }

    ScrewImage {
      anchors.bottom: parent.bottom
      anchors.right: parent.right
    }

    InfoText {
      text: qsTr("IN")
      anchors.top: parent.top
      anchors.topMargin: 60
      anchors.right: parent.right
      lineWidth: 30
      lineHeight: 2
    }

    InfoText {
      text: qsTr("OUT")
      anchors.top: parent.top
      anchors.topMargin: 60
      anchors.left: parent.left
      lineWidth: 30
      lineHeight: 2
    }

    InfoText {
      text: qsTr("TIME BLENDER")
      anchors.top: parent.verticalCenter
      anchors.topMargin: 16
      anchors.horizontalCenter: parent.horizontalCenter
      spacing: 10
      font.family: prismaFontLoader.status === FontLoader.Ready ? prismaFontLoader.name : "Sans Serif"
      font.pixelSize: 18
    }

    SwitchImage {
      x: parent.width * 0.33 - width / 2
      y: 14
      sourceBaseName: "LED"
      checked: footPedal.checked

      DeviceText {
        text: qsTr("CHECK")
        anchors.top: parent.bottom
        anchors.topMargin: 4
        anchors.horizontalCenter: parent.horizontalCenter
      }
    }

    DeviceSwitch {
      x: parent.width * 0.66 - width / 2
      y: 14
      sourceBaseName: "Switch"
      topMargin: 16

      DeviceText {
        text: qsTr("MODE")
        anchors.top: parent.bottom
        anchors.topMargin: 4
        anchors.horizontalCenter: parent.horizontalCenter
      }
    }

    DeviceSwitch {
      id: footPedal
      sourceBaseName: "Button-Pedal"
      anchors.bottom: parent.bottom
      anchors.horizontalCenter: parent.horizontalCenter
    }

    DeviceDial {
      anchors.horizontalCenter: parent.horizontalCenter
      y: 67 - height / 2
      text: qsTr("LEVEL")
    }

    DeviceDial {
      anchors.left: footPedal.left
      y: 130 - height / 2
      text: qsTr("TIME")
    }

    DeviceDial {
      anchors.right: footPedal.right
      y: 130 - height / 2
      text: qsTr("FEEDBACK")
    }
  }

  component DeviceDial: Image {
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

  component DeviceSwitch: SwitchImage {
    property alias topMargin: tapHandler.margin

    TapHandler {
      id: tapHandler
      onTapped: parent.checked = !parent.checked
    }
  }

  component SwitchImage: Image {
    required property string sourceBaseName
    property bool checked

    // Component.onCompleted: {
    //   console.log("SwitchImage sourceBaseName: " + sourceBaseName + ", checked: " + checked);
    // }
    source: `assets/${sourceBaseName}${checked ? "-Checked" : ""}.png`
  }

  component DeviceText: Text {
    color: "#191919"
    font.family: russoFontLoader.status === FontLoader.Ready ? russoFontLoader.name : "Sans Serif"
    font.weight: russoFontLoader.font.weight
    font.pixelSize: 9
  }

  component InfoText: Column {
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

  component ScrewImage: Image {
    source: "assets/Screw.png"
  }
}
