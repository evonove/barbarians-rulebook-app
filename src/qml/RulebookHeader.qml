import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

ToolBar {
    id: root

    /* This is the total number of elements found for the current search */
    property int total: 0

    /* This is the current element index within the current search */
    property int current: 0

    readonly property string search: "\uE8B6"
    readonly property string formatListBulleted: "\uE241"
    readonly property string apps: "\uE5C3"
    readonly property string close: "\uE5CD"
    readonly property string navigateBefore: "\uE408"
    readonly property string navigateNext: "\uE409"

    signal searchButtonClicked()
    signal menuButtonClicked()
    signal backButtonClicked()
    signal closeSearchButtonClicked()
    signal prevButtonClicked()
    signal nextButtonClicked()
    signal searchTextChanged(string text)

    signal searchTextPressed()
    signal searchTextAccepted(string text)

    font.family: "Material Icons"
    font.pixelSize: 24

    /* This toolbar is managed as a stackview because we show
     * other actions when the user clicks on the search button */
    StackView {
        id: _headerStack
        objectName: "_headerStack"

        anchors.fill: parent

        initialItem: RowLayout {
            spacing: 0

            Item {
                Layout.fillWidth: true
            }

            /* This button pushes the search bar to the header */
            ToolButton {
                id: _searchButton
                objectName: "_searchButton"

                text: root.search
                font: root.font

                onClicked: _headerStack.push(_searchHeader)
            }

            /* This button should open a menu in drawer */
            ToolButton {
                id: _menuButton
                objectName: "_menuButton"

                text: root.formatListBulleted
                font: root.font
            }

            /* This button should go back to the previous page */
            ToolButton {
                id: _backButton
                objectName: "_backButton"

                text: root.apps
                font: root.font
            }
        }

        /* This component is pushed to the stack
         * when the user clicks on the search button */
        Component {
            id: _searchHeader

            RowLayout {
                objectName: "_searchHeader"

                spacing: 0

                ToolButton {
                    id: _closeSearchButton
                    objectName: "_closeSearchButton"

                    text: root.close
                    font: root.font

                    onClicked: _headerStack.pop();
                }
                TextField {
                    id: _searchText
                    objectName: "_searchText"

                    placeholderText: qsTr("Find text")
                    onTextChanged: root.searchTextChanged(text)

                    onPressed: root.searchTextPressed()
                    onAccepted: root.searchTextAccepted(text)

                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
                ToolButton {
                    id: _prevButton
                    objectName: "_prevButton"

                    text: root.navigateBefore
                    font: root.font
                    enabled: root.total > 0
                }

                Label {
                    objectName: "_searchLabel"

                    text: qsTr("%1 of %2").arg(root.current).arg(root.total)
                }

                ToolButton {
                    id: _nextButton
                    objectName: "_nextButton"

                    text: root.navigateNext
                    font: root.font
                    enabled: root.total > 0
                }

                Component.onCompleted: {
                    _closeSearchButton.clicked.connect(root.closeSearchButtonClicked);
                    _prevButton.clicked.connect(root.prevButtonClicked);
                    _nextButton.clicked.connect(root.nextButtonClicked);
                }
            }
        }
    }

    Component.onCompleted: {
        _searchButton.clicked.connect(root.searchButtonClicked);
        _menuButton.clicked.connect(root.menuButtonClicked);
        _backButton.clicked.connect(root.backButtonClicked);
    }
}
