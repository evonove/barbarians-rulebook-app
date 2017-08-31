import QtQuick 2.7
import QtQuick.Controls 2.2

import "components"

Page {
    id: root

    padding: 0

    header: RulebookHeader {
        total: _webView.elementsFound
        current: _webView.currentElement

        onSearchTextChanged: _webView.find(text)
        onNextButtonClicked: _webView.next()
        onPrevButtonClicked: _webView.prev()
        onCloseSearchButtonClicked: _webView.init()
    }

    WebViewSearch {
        id: _webView

        anchors.fill: parent
        url: baseUrl
    }
}
