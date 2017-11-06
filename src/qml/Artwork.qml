import QtQuick 2.7
import QtQuick.Controls 2.2


Page {
    id: root

    Keys.forwardTo: [_stackView.currentItem]
    Keys.onPressed: console.log("artwork main", event, event.text)

    StackView {
        id: _stackView
        anchors.fill: parent

        initialItem: ArtworkGrid {
            model: _artworkModel

            onThumbClicked: _stackView.push(_artworkSlides, { currentIndex: index })
            onMenuClicked: root.StackView.view.pop()
        }
    }

    ArtworkModel {
        id: _artworkModel
    }

    Component {
        id: _artworkSlides

        ArtworkSlides {
            model: _artworkModel

            onMenuClicked: root.StackView.view.pop()
        }
    }
}
