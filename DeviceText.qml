import QtQuick

Text {
  color: "#191919"
  font.family: russoFontLoader.status === FontLoader.Ready ? russoFontLoader.name : "Sans Serif"
  font.weight: russoFontLoader.font.weight
  font.pixelSize: 9
}
