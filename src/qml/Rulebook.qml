import QtQuick 2.7
import QtQuick.Controls 2.2

import "components"

Page {
    id: root

    /* The URI to the rulebook html page */
    property string rulebookUrl: ""

    /* The fragment property is used to navigate through
     * the sections of the rulebook page. */
    property string fragment: ""

    padding: 0

    header: RulebookHeader {
        total: _webViewLoader.active ? _webViewLoader.item.elementsFound : 0
        current: _webViewLoader.active ? _webViewLoader.item.currentElement : 0

        onMenuButtonClicked: {
            // here we reset the fragment so that the webview
            // scrolls even when the url doesn't change
            root.fragment = "";
            root.StackView.view.push(_index);
        }

        onBackButtonClicked: root.StackView.view.pop()

        onSearchTextChanged: _webViewLoader.active && _webViewLoader.item.find(text)
        onNextButtonClicked: _webViewLoader.active && _webViewLoader.item.next()
        onPrevButtonClicked: _webViewLoader.active && _webViewLoader.item.prev()
        onCloseSearchButtonClicked: _webViewLoader.active && _webViewLoader.item.init()
    }

    Loader {
        id: _webViewLoader
        anchors.fill: parent
        asynchronous: true

        sourceComponent: WebViewSearch {
            url: root.rulebookUrl + root.fragment
        }
    }

    Component {
        id: _index

        RulebookIndex {
            // Here we handle the itemClicked signal and set
            // the fragment property so that the web view url
            // is updated and the view moves to the selected section.
            onItemClicked: root.fragment = fragment
        }
    }
}
