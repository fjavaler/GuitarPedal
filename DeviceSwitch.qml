import QtQuick

SwitchImage {
  property alias topMargin: tapHandler.margin

  TapHandler {
    id: tapHandler
    onTapped: parent.checked = !parent.checked
  }
}
