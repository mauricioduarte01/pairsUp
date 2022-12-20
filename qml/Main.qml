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
import "utils.js" as Util
import QtMultimedia 5.12

MainView {
    id: mainView
    objectName: 'mainView'
    applicationName: 'memtest.md'
    automaticOrientation: true
    width: units.gu(45)
    height: units.gu(75)

    //headerColor: "#57365E"
    //backgroundColor: "#A55263"
    property bool soundMuted: false
    onSoundMutedChanged: soundMuted ? soundtrack.stop() : soundtrack.play()

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
        id: soundtrack

        source: "../assets/soundtrack.ogg"

        autoLoad: true
        muted: soundMuted
        loops: Audio.Infinite
        //        autoPlay: true
    }

    Connections {
        target: Qt.application

        onActiveChanged: {
            if (Qt.application.active && !soundMuted) {
                soundtrack.play();
            } else {
                soundtrack.pause();
            }
        }
        onAboutToQuit: {
            soundtrack.stop()
        }
    }

    Component.onCompleted:{
//        soundtrack.play();
        pageStack.push(Qt.resolvedUrl("L1.qml"))
    }

    PageStack {
        id: pageStack
    }
}

