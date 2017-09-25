import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3


Page {
    id: root

    // Material Icons needed by this page
    readonly property string apps: "\uE5C3"
    readonly property string menu: "\uE5D2"
    readonly property string navigateBefore: "\uE408"
    readonly property string navigateNext: "\uE409"

    property alias currentIndex: _swipeView.currentIndex

    header: ToolBar {
        leftPadding: root.currentIndex === 0 ? 16 : 0

        RowLayout {
            anchors.fill: parent
            spacing: 0

            ToolButton {
                text: root.apps
                visible: root.currentIndex > 0

                font.family: "Material Icons"
                font.pixelSize: 24

                onClicked: _swipeView.setCurrentIndex(0)
            }

            Label {
                text: root.currentIndex === 0 ? qsTr("Game Setup") : qsTr("Wizard %1 of 9").arg(root.currentIndex)
                elide: Text.ElideRight

                font.weight: Font.Medium
                font.pixelSize: 20
            }

            Item {
                Layout.fillWidth: true
            }

            ToolButton {
                objectName: "_prevButton"
                text: root.navigateBefore
                visible: root.currentIndex > 0

                font.family: "Material Icons"
                font.pixelSize: 24

                onClicked: _swipeView.decrementCurrentIndex()
            }

            ToolButton {
                objectName: "_nextButton"
                text: root.navigateNext
                enabled: root.currentIndex < 9
                visible: root.currentIndex > 0

                font.family: "Material Icons"
                font.pixelSize: 24

                onClicked: _swipeView.incrementCurrentIndex()
            }

            ToolButton {
                objectName: "_backButton"
                text: root.menu
                onClicked: root.StackView.view.pop()

                font.family: "Material Icons"
                font.pixelSize: 24
            }
        }
    }

    background: Image {
        anchors.fill: root
        asynchronous: true
        cache: true
        source: "qrc:/assets/setup/background.jpg"
        fillMode: Image.PreserveAspectCrop

        horizontalAlignment: Image.AlignHCenter
        verticalAlignment: Image.AlignTop
    }

    // The swipe view contains all the steps of the
    // setup wizard
    SwipeView {
        id: _swipeView
        anchors.fill: parent

        Loader {
            objectName: "_mapLoader"
            asynchronous: true

            sourceComponent: GameSetupMap {
                onStepClicked: _swipeView.setCurrentIndex(step)
            }
        }


        Repeater {
            model: GameSetupModel {}

            Loader {
                asynchronous: true

                sourceComponent: GameSetupStep {
                    id: _step
                    title: model.title
                    content: model.index === 0 ? model.content.arg(_step.availableWidth) : model.content
                    mainImageSource: model.image
                }
            }
        }

    }
}
