import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3



Page {
    id: root

    signal appsClicked()
    signal menuClicked()

    property alias model: _slides.model

    // Material Icons needed by this page
    readonly property string apps: "\uE5C3"
    readonly property string menu: "\uE5D2"

    property alias currentIndex: _swipeView.currentIndex

    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            spacing: 0

            ToolButton {
                text: root.apps

                font.family: "Material Icons"
                font.pixelSize: 24

                onClicked: root.StackView.view.pop()
            }

            Label {
                text: qsTr("Artwork")
                elide: Text.ElideRight

                font.weight: Font.Medium
                font.pixelSize: 20
            }

            Item {
                Layout.fillWidth: true
            }

            ToolButton {
                objectName: "_backButton"
                text: root.menu

                font.family: "Material Icons"
                font.pixelSize: 24

                onClicked: root.menuClicked()
            }
        }
    }

    SwipeView {
        id: _swipeView
        anchors.fill: parent

        Repeater {
            id: _slides
            model: ArtworkModel {
                id: _artworkModel
            }

            Loader {
                active: SwipeView.isCurrentItem || SwipeView.isNextItem
                asynchronous: true
                opacity: status === Loader.Ready ? 1.0 : 0

                sourceComponent: ArtworkSlideDelegate {
                    title: model.title
                    category: model.category
                    image: model.image
                    description: model.description
                }

                Behavior on opacity {
                    NumberAnimation { duration: 200 }
                }
            }
        }
    }
}
