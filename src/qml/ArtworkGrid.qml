import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3


BasePage {
    id: root

    signal thumbClicked(int index)
    signal menuClicked()

    // Material Icons needed by this page
    readonly property string menu: "\uE5D2"

    readonly property int cellWidth: Math.floor(root.availableWidth / 2)
    readonly property int cellHeight: Math.floor(root.availableHeight / 2.5)

    property alias model: _grid.model

    topPadding: 8; bottomPadding: 8
    leftPadding: 4; rightPadding: 0

    header: ToolBar {
        topPadding: root.safeTopMargin
        leftPadding: 0

        RowLayout {
            anchors.fill: parent

            ToolButton {
                objectName: "_menuButton"
                text: root.menu
                onClicked: root.menuClicked()

                font.family: "Material Icons"
                font.pixelSize: 24
            }

            Label {
                text: qsTr("Artwork")

                font.weight: Font.Medium
                font.pixelSize: 20

                Layout.leftMargin: 8
            }

            Item { Layout.fillWidth: true }

        }
    }

    GridView {
        id: _grid
        objectName: "_grid"

        anchors.fill: parent

        cellWidth: root.cellWidth
        cellHeight: root.cellHeight

        delegate: ItemDelegate {
            id: _delegate
            padding: 0
            width: _grid.cellWidth - 4; height: _grid.cellHeight - 4

            Image {
                anchors.fill: parent
                source: model.thumbnail
                asynchronous: true
                fillMode: Image.PreserveAspectCrop
                smooth: false
                cache: false
                opacity: _delegate.pressed || _delegate.hovered ? 0.8 : 1.0

                BusyIndicator { anchors.centerIn: parent; running: parent.status !== Image.Ready }
            }

            onClicked: root.thumbClicked(model.index)
        }
    }
}
