import QtQuick 2.7
import QtTest 1.1

import "qrc:/qml/components"

TestCase {
    id: testCase
    width: 400; height: 400
    visible: true
    name: "WebViewSearch"

    WebViewSearch {
        id: webView
        anchors.fill: parent
    }

    // Verifies that the init function reset the properties
    function test_init_reset_properties() {
        webView.elementsFound = 10;
        webView.currentElement = 1;
        webView.init();
        compare(webView.elementsFound, 0);
        compare(webView.currentElement, 0);
    }
}
