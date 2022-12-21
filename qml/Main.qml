/*
 * Copyright (C) 2022  Mauricio Duarte
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * pairs-up is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.7
import Ubuntu.Components 1.3
import "utils.js" as Util
import QtMultimedia 5.12
import QtQuick.Layouts 1.3

MainView {
    id: mainView
    objectName: 'mainView'
    applicationName: 'pairs-up.md'
    automaticOrientation: true
    width: units.gu(45)
    height: units.gu(75)

    //headerColor: "#57365E"
    //backgroundColor: "#A55263"
    property bool soundMuted: false
    onSoundMutedChanged: soundMuted ? music.stop() : music.play()

    Rectangle {
        id: bgd
        anchors.fill: parent
        z: -1
        gradient: Gradient {
            //GradientStop { position: 0; color: "#1B0E17" }
            GradientStop { position: 0.0; color: "#49253E" }
            //GradientStop { position: 0.20; color: "#652B2A" }
            //GradientStop { position: 0.36; color: "#7B3433" }
            GradientStop { position: 0.9; color: "#9E4442" }
        }
    }
    //AnimatedImage { id: animation; anchors.fill: parent; source: "qrc:/assets/bgd1.gif"; z: -1 }

    //Implement music once it's completed. WIP
    Audio {
        id: music
        source: "../assets/soundtrack.ogg"
        autoLoad: true
        muted: soundMuted
        loops: Audio.Infinite
    }

    Connections {
        target: Qt.application

        onActiveChanged: {
            if (Qt.application.active && !soundMuted) {
                music.play();
            } else {
                music.pause();
            }
        }
        onAboutToQuit: {
            music.stop()
        }
    }

    Component.onCompleted:{
        pageStack.push(Qt.resolvedUrl("L1.qml"))
    }

    PageStack {
        id: pageStack
    }

    BottomEdge {
        id: bottomEdge
        height: units.gu(10)
        contentComponent: Rectangle {
            width: bottomEdge.width
            height: bottomEdge.height
            color: "#301938"

            Icon {
                id: on
                width: units.gu(5)
                height: units.gu(5)
                name: soundMuted ? 'audio-speakers-muted-symbolic' : "audio-speakers-symbolic"
                anchors {
                    margins: 50
                    top: parent.top
                    bottom: parent.bottom
                    left: parent.left
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: soundMuted = !soundMuted
                }
            }

            Icon {
                id: collapse
                width: units.gu(4)
                height: units.gu(5)
                name: "down"
                anchors {
                    margins: 50
                    top: parent.top
                    bottom: parent.bottom
                    right: parent.right
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: bottomEdge.collapse()
                }
            }
        }
    }
}



