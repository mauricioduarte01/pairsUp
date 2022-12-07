/*
 * Copyright (C) 2022  Mauricio Duarte
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * memtest is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Ubuntu.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import "utils.js" as Util
import QtMultimedia 5.12

Page {
    anchors.fill: parent
    id: mainPage
    header: PageHeader{
    visible: true
    title: i18n.tr('MemoTest')
    }

    ColumnLayout {
        spacing: units.gu(2)
        anchors {
            margins: units.gu(2)
            top: header.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        Item {
            Layout.fillHeight: true
        }

        Label {
            id: label
            Layout.alignment: Qt.AlignHCenter
            text: i18n.tr('Press the button below and check the logs!')
        }

        Button {
            id:button_playgame
            Layout.alignment: Qt.AlignHCenter
            text: i18n.tr('Play Game!')
            onClicked:pageStack.push(Qt.resolvedUrl("Lvl1.qml"))

        }

//        Button {
//            id:options
//            Layout.alignment: Qt.AlignHCenter
//            text: i18n.tr('Options')
//            onClicked:pageStack.push(Qt.resolvedUrl("Options.qml"))
//        }

        Item {
            Layout.fillHeight: true
        }
    }
}
