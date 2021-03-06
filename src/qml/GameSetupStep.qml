import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3

Page {
    id: root

    signal back()

    property alias mainImageSource: _mainImage.source
    property alias content: _content.text

    padding: 16

    // we need a transparent background because it is set on
    // the main GameSetup page
    Material.background: "transparent"

    Keys.onPressed: {
        console.log("game setup step", event, event.text);
        if (event.key === Qt.Key_Escape || event.key === Qt.Key_Back) {
            root.back();
            event.accepted = true;
        }
    }

    ScrollView {
        anchors.fill: parent

        Material.theme: Material.Light

        Column {
            spacing: 16

            Image {
                id: _mainImage
                width: root.availableWidth
                fillMode: Image.PreserveAspectFit

                smooth: false
            }

            Label {
                id: _title
                width: root.availableWidth
                text: root.title
                wrapMode: Text.Wrap

                font.pixelSize: 20
                font.weight: Font.DemiBold
            }

            Label {
                id: _content
                width: root.availableWidth
                wrapMode: Text.Wrap
                textFormat: Text.RichText

                font.pixelSize: 16
            }
        }
    }
}
