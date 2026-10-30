import QtQuick

Image {
  required property string sourceBaseName
  property bool checked

  source: `assets/${sourceBaseName}${checked ? "-Checked" : ""}.png`
}
