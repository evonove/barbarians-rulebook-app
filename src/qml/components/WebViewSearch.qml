import QtQuick 2.7
import QtWebView 1.1

WebView {
    id: root

    property int elementsFound: 0
    property int currentElement: 0

    function init() {
        root.elementsFound = 0;
        root.currentElement = 0;

        root.runJavaScript("init()");
    }

    function find(text) {
        root.runJavaScript("find('%1')".arg(text), function(result) {
            root.elementsFound = result.elementsFound;
            root.currentElement = result.currentElement + 1;
        });
    }

    function next() {
        root.runJavaScript("next()", function(result) {
            root.currentElement = result + 1;
        });
    }

    function prev() {
        root.runJavaScript("prev()", function(result) {
            root.currentElement = result + 1;
        });
    }
}
