import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2


/* A rounded button specific for the GameSetupMap */
RoundButton {
    width: 56; height: 56

    font.weight: Font.DemiBold
    font.pixelSize: 24

    Material.background: Material.color(Material.Amber, Material.Shade200)
    Material.foreground: Material.color(Material.Grey, Material.Shade900)
}
