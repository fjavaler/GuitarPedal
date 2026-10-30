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
}
