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
        total: _webView.elementsFound
        current: _webView.currentElement

        onMenuButtonClicked: {
            // here we reset the fragment so that the webview
            // scrolls even when the url doesn't change
            root.fragment = "";
            root.StackView.view.push(_index);
        }

        onBackButtonClicked: root.StackView.view.pop()

        onSearchTextChanged: _webView.find(text)
        onNextButtonClicked: _webView.next()
        onPrevButtonClicked: _webView.prev()
        onCloseSearchButtonClicked: _webView.init()
    }

    WebViewSearch {
        id: _webView
        anchors.fill: parent

        url: root.rulebookUrl + root.fragment
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
