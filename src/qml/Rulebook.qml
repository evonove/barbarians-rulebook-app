import QtQuick 2.7
import QtQuick.Controls 2.2
import QtWebView 1.1

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

        onBackButtonClicked: {
            _webViewLoader.active = false;
            root.StackView.view.pop();
        }

        onSearchTextPressed: {
            if (Qt.platform.os === "android") {
                _webViewLoader.active = false;
            }
        }

        onSearchTextAccepted: {
            if (Qt.platform.os === "android") {
                _webViewLoader.active = true;
                _webViewLoader.loaded.connect(function() {
                    _webViewLoader.item.loadingChanged.connect(function (loadRequest) {
                        if (loadRequest.status === WebView.LoadSucceededStatus) {
                            console.log("webview loaded");
                            _webViewLoader.item.find(text);
                        }
                    })
                });
            }
        }

        onCloseSearchButtonClicked: {
            if (_webViewLoader.active) {
                _webViewLoader.item.init();
            } else {
                _webViewLoader.active = true;
                _webViewLoader.loaded.connect(function() {
                    _webViewLoader.item.loadingChanged.connect(function (loadRequest) {
                        if (loadRequest.status === WebView.LoadSucceededStatus) {
                            console.log("webview loaded");
                            _webViewLoader.item.init();
                        }
                    })
                });
            }
        }

        onSearchTextChanged: _webViewLoader.active && _webViewLoader.item.find(text)
        onNextButtonClicked: _webViewLoader.active && _webViewLoader.item.next()
        onPrevButtonClicked: _webViewLoader.active && _webViewLoader.item.prev()
    }

    Loader {
        id: _webViewLoader
        anchors.fill: parent
        asynchronous: true
        visible: active && !item.loading

        sourceComponent: WebViewSearch {
            url: root.rulebookUrl + root.fragment
        }
    }

    BusyIndicator {
        anchors.centerIn: parent
        running: _webViewLoader.status !== Loader.Ready || !_webViewLoader.visible
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
