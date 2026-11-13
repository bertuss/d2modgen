/*
 * Copyright (C) 2026 Smirnov Vladimir / mapron1@gmail.com
 * SPDX-License-Identifier: BSL-1.0
 * See LICENSE file for details.
 */
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Fusion

Dialog {
    id: root
    property var matches: []
    property int selected: 0
    property bool isD2R: appConfig.versionMajor.value === 1

    function show(list, preselected) {
        matches = list;
        selected = preselected;
        open();
    }

    title: qsTr("Several Wine prefixes contain Diablo II")
    modal: true
    anchors.centerIn: Overlay.overlay
    standardButtons: Dialog.Ok | Dialog.Cancel

    onAccepted: appui.applyWineMatch(root.selected)

    ButtonGroup {
        id: group
    }

    ColumnLayout {
        spacing: 10

        Repeater {
            model: root.matches

            RowLayout {
                id: row
                required property var modelData
                required property int index
                spacing: 6

                RadioButton {
                    ButtonGroup.group: group
                    checked: row.index === root.selected
                    onClicked: root.selected = row.index
                    Layout.alignment: Qt.AlignTop
                }
                ColumnLayout {
                    spacing: 2
                    Label {
                        text: row.modelData.prefix
                        font.bold: true
                    }
                    Label {
                        text: {
                            let details = [qsTr("Game: %1").arg(row.modelData.installPath), row.modelData.hasSavedGames ? qsTr("Saved Games found") : qsTr("No Saved Games")];
                            if (root.isD2R)
                                details.push(row.modelData.hasBattleNetConfig ? qsTr("Battle.net settings found") : qsTr("No Battle.net settings"));
                            return details.join(", ");
                        }
                    }
                }
            }
        }
    }
}
