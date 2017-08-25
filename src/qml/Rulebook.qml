import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtWebView 1.1

Page {
    id: root

    padding: 0

    header: ToolBar {
        id: _header

        readonly property string search: "\uE8B6"
        readonly property string formatListBulleted: "\uE241"
        readonly property string apps: "\uE5C3"
        readonly property string close: "\uE5CD"
        readonly property string navigateBefore: "\uE408"
        readonly property string navigateNext: "\uE409"

        font.family: "Material Icons"
        font.pixelSize: 24

        StackView {
            id: _headerStack
            anchors.fill: parent

            initialItem: RowLayout {
                spacing: 0

                Item {
                    Layout.fillWidth: true
                }

                ToolButton {
                    text: _header.search
                    font: _header.font
                }

                ToolButton {
                    text: _header.formatListBulleted
                    font: _header.font
                }

                ToolButton {
                    text: _header.apps
                    font: _header.font
                }
            }
        }
    }

    WebView {
        id: _webView

        anchors.fill: parent
        url: baseUrl

    }
}
