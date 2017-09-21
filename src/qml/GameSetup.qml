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
                text: root.currentStep === 0 ? qsTr("Game Setup") : qsTr("Wizard %1 of 9").arg(root.currentStep)
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
                visible: root.currentStep > 0

                font.family: "Material Icons"
                font.pixelSize: 24

                onClicked: root.currentStep -= 1
            }

            ToolButton {
                objectName: "_nextButton"
                text: root.navigateNext
                enabled: root.currentStep < 9
                visible: root.currentStep > 0

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

    background: Image {
        anchors.fill: root
        source: "qrc:/assets/background.jpg"
        fillMode: Image.PreserveAspectCrop

        horizontalAlignment: Image.AlignHCenter
        verticalAlignment: Image.AlignTop
    }

    // The swipe view contains all the steps of the
    // setup wizard
    SwipeView {
        anchors.fill: parent
        currentIndex: root.currentStep

        GameSetupMap {
            onStepClicked: root.currentStep = step
        }
        Repeater {
            model: 9
            Rectangle { }
        }

    }
}
