import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3


ApplicationWindow {
    visible: true
    width: 360
    height: 640
    title: qsTr("Hello World")

    FontLoader {
        source: "qrc:/fonts/MaterialIcons-Regular.ttf"
    }

    StackView {
        id: _stackView
        anchors.fill: parent

        initialItem: MainMenu {
            onRulebookClicked: _stackView.push(_rulebook)
        }
    }

    Component {
        id: _rulebook

        Rulebook {  }
    }
}
