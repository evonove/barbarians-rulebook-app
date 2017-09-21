import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3

import "components"


/* This page shows the game setup map.
 * The buttons link to the detail page of the steps
 * that describe how to set up the game.
 */
Page {
    id: root

    signal stepClicked(int step)

    padding: 16

    // we need a transparent background because it is set on
    // the main GameSetup page
    Material.background: "transparent"

    ColumnLayout {
        anchors.fill: parent

        spacing: 8

        Item {
            id: _cards
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 370

            Image {
                width: parent.width; height: parent.height
                source: "qrc:/assets/0-setup/cards-alpha.png"
                smooth: false

                fillMode: Image.PreserveAspectFit
            }

            RoundButtonGS {
                objectName: "_four"
                anchors.centerIn: parent
                text: "4"

                onClicked: root.stepClicked(4)
            }
        }

        Item {
            id: _gameboard
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 972

            Image {
                anchors.horizontalCenter: parent.horizontalCenter
                height: parent.height
                source: "qrc:/assets/0-setup/gameboard-alpha.png"
                smooth: false

                fillMode: Image.PreserveAspectFit

                RoundButtonGS {
                    objectName: "_five"

                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.topMargin: Math.ceil(parent.height / 5)
                    anchors.leftMargin: Math.ceil(parent.width / 3)
                    text: "5"

                    onClicked: root.stepClicked(5)
                }

                RoundButtonGS {
                    objectName: "_one"

                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.topMargin: Math.ceil(parent.height / 5)
                    anchors.leftMargin: Math.ceil(parent.width / 3 * 2)
                    text: "1"

                    onClicked: root.stepClicked(1)
                }

                RoundButtonGS {
                    objectName: "_nine"

                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.topMargin: Math.ceil(parent.height / 2)
                    anchors.leftMargin: Math.ceil(parent.width / 2)
                    text: "9"

                    onClicked: root.stepClicked(9)
                }

                RoundButtonGS {
                    objectName: "_eight"
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    anchors.rightMargin: Math.ceil(parent.width / 5)
                    text: "8"

                    onClicked: root.stepClicked(8)
                }
            }
        }

        Item {
            id: _playerboard
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 633

            Image {
                width: parent.width; height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter
                source: "qrc:/assets/0-setup/player-alpha.png"
                smooth: false

                fillMode: Image.PreserveAspectFit

                RoundButtonGS {
                    objectName: "_six"
                    anchors.top: parent.top
                    anchors.left: parent.left
                    text: "6"

                    onClicked: root.stepClicked(6)
                }

                RoundButtonGS {
                    objectName: "_seven"
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    text: "7"

                    onClicked: root.stepClicked(7)
                }

                RoundButtonGS {
                    objectName: "_two"
                    anchors.centerIn: parent
                    text: "2"

                    onClicked: root.stepClicked(2)
                }

                RoundButtonGS {
                    objectName: "_three"
                    anchors.top: parent.top
                    anchors.right: parent.right
                    text: "3"

                    onClicked: root.stepClicked(3)
                }
            }
        }
    }
}
