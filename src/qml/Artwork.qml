import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3


Page {
    id: root

    // Material Icons needed by this page
    readonly property string apps: "\uE5C3"
    readonly property string navigateBefore: "\uE408"
    readonly property string navigateNext: "\uE409"

    /* This is the number of the step we are currently on */
    property int currentStep: 0

    header: ToolBar {
        leftPadding: 16

        RowLayout {
            anchors.fill: parent
            spacing: 0

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
                objectName: "_prevButton"
                text: root.navigateBefore
                enabled: root.currentStep > 0

                font.family: "Material Icons"
                font.pixelSize: 24

                onClicked: root.currentStep -= 1
            }

            ToolButton {
                objectName: "_nextButton"
                text: root.navigateNext
                enabled: root.currentStep < (_artworkModel.count - 1)

                font.family: "Material Icons"
                font.pixelSize: 24

                onClicked: root.currentStep += 1
            }

            ToolButton {
                objectName: "_backButton"
                text: root.apps
                onClicked: root.StackView.view.pop()

                font.family: "Material Icons"
                font.pixelSize: 24
            }
        }
    }

    Loader {
        id: _artworkLoader

        anchors.fill: parent
        asynchronous: true
        opacity: status === Loader.Ready ? 1.0 : 0.0

        sourceComponent:  SwipeView {
            currentIndex: root.currentStep
            onCurrentIndexChanged: root.currentStep = currentIndex

            Repeater {
                model: _artworkModel

                Pane {
                    padding: 0

                    Image {
                        anchors.fill: parent
                        fillMode: Image.PreserveAspectCrop
                        smooth: false
                        source: model.image
                    }
                }
            }
        }

        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }
    }

    BusyIndicator {
        anchors.centerIn: parent
        running: _artworkLoader.status !== Loader.Ready
    }

    ArtworkModel {
        id: _artworkModel
    }

    footer: ToolBar {
        leftPadding: 16

        RowLayout {
            anchors.fill: parent

            /* The label shows the caption of the current selected Artwork */
            Label {
                text: _artworkModel.get(root.currentStep).caption
                elide: Text.ElideRight
            }
        }
    }
}
