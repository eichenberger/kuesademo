/*
    SceneEntity.qml

    This file is part of Kuesa.

    Copyright (C) 2019 Klarälvdalens Datakonsult AB, a KDAB Group company, info@kdab.com
    Author: Robert Brock <robert.brock@kdab.com>

    Licensees holding valid proprietary KDAB Kuesa licenses may use this file in
    accordance with the Kuesa Enterprise License Agreement provided with the Software in the
    LICENSE.KUESA.ENTERPRISE file.

    Contact info@kdab.com if any conditions of this licensing are not clear to you.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

//! [0]
import Qt3D.Core 2.12
import Qt3D.Render 2.12
import Qt3D.Input 2.12
import Qt3D.Extras 2.12
import QtQuick 2.12
import Qt3D.Animation 2.12

import Kuesa 1.1 as Kuesa
import Kuesa.Effects 1.1 as KuesaFX

Kuesa.SceneEntity {
    id: root3D

    property string toneMappingAlgorithmName: "None"
    property int screenWidth
    property int screenHeight

    property double exposure: 1.7
    property bool rotating: false

    property var __winSize: Qt.size(_view.width, _view.height)

    Kuesa.Skybox {
        // Optional: Use the irradiance instead of the radiance for a simple blurry background
        baseName: _assetsPrefix + "skybox2"
        extension: ".dds"
    }

    components: [
        RenderSettings {
            //! [2.2]
            activeFrameGraph: Kuesa.ForwardRenderer {
                id: frameGraph
                camera: camera
                clearColor: Qt.rgba(0.1, 0.1, 0.1, 1.0)
                exposure: root3D.exposure
            }
            //! [2.2]
        },
        InputSettings { },
        EnvironmentLight {
            irradiance: TextureLoader {
                source: _assetsPrefix + "environment_irradiance2.dds"

                minificationFilter: Texture.LinearMipMapLinear
                magnificationFilter: Texture.Linear
                wrapMode {
                    x: WrapMode.ClampToEdge
                    y: WrapMode.ClampToEdge
                }
                generateMipMaps: false
            }
            specular: TextureLoader {
                source: _assetsPrefix +  "environment_specular2.dds"

                minificationFilter: Texture.LinearMipMapLinear
                magnificationFilter: Texture.Linear
                wrapMode {
                    x: WrapMode.ClampToEdge
                    y: WrapMode.ClampToEdge
                }
                generateMipMaps: false
            }
        }
    ]

    Camera {
        id: camera
        position: Qt.vector3d(0.0, 150.0, -500.0)
        upVector: Qt.vector3d(0.0, 1.0, 0.0)
        exposure: root3D.exposure
        viewCenter: Qt.vector3d(0.0, 50.0, 0.0)
        aspectRatio: root3D.__winSize.width / root3D.__winSize.height
        Timer {
            running: true
            repeat: true
            interval: 30
            onTriggered: camera.panAboutViewCenter(-0.2, Qt.vector3d(0.0, 1.0, 0.0))
        }
    }

    OrbitCameraController {
        id: controller
        camera: frameGraph.camera
        linearSpeed: 800
    }

    Clock {
        id: animationClock
    }

    Kuesa.AnimationPlayer {
        id: clawMoveUp
        sceneEntity: root3D
        clock: animationClock
        clip: "Action"
        running: true
        loops: Kuesa.AnimationPlayer.Infinite
    }

    Kuesa.AnimationPlayer {
        id: baseRotation
        sceneEntity: root3D
        clock: animationClock
        clip: "Action.001"
        running: true
        loops: Kuesa.AnimationPlayer.Infinite
    }

    Kuesa.AnimationPlayer {
        sceneEntity: root3D
        clock: animationClock
        clip: "Action.002"
        running: true
        loops: Kuesa.AnimationPlayer.Infinite
    }

    Kuesa.AnimationPlayer {
        sceneEntity: root3D
        clock: animationClock
        clip: "Action.003"
        running: true
        loops: Kuesa.AnimationPlayer.Infinite
    }

    Kuesa.AnimationPlayer {
        sceneEntity: root3D
        clock: animationClock
        clip: "Action.004"
        running: true
        loops: Kuesa.AnimationPlayer.Infinite
    }

    Kuesa.AnimationPlayer {
        sceneEntity: root3D
        clock: animationClock
        clip: "Action.005"
        running: true
        loops: Kuesa.AnimationPlayer.Infinite
    }

    Kuesa.AnimationPlayer {
        sceneEntity: root3D
        clock: animationClock
        clip: "Action.006"
        running: true
        loops: Kuesa.AnimationPlayer.Infinite
    }

    Kuesa.AnimationPlayer {
        sceneEntity: root3D
        clock: animationClock
        clip: "Action.007"
        running: true
        loops: Kuesa.AnimationPlayer.Infinite
    }

    Kuesa.AnimationPlayer {
        sceneEntity: root3D
        clock: animationClock
        clip: "Action.008"
        running: true
        loops: Kuesa.AnimationPlayer.Infinite
    }

    Kuesa.AnimationPlayer {
        sceneEntity: root3D
        clock: animationClock
        clip: "Action.009"
        running: true
        loops: Kuesa.AnimationPlayer.Infinite
    }

    Kuesa.AnimationPlayer {
        sceneEntity: root3D
        clock: animationClock
        clip: "Action.010"
        running: true
        loops: Kuesa.AnimationPlayer.Infinite
    }

    Kuesa.AnimationPlayer {
        sceneEntity: root3D
        clock: animationClock
        clip: "Action.011"
        running: true
        loops: Kuesa.AnimationPlayer.Infinite
    }

    Kuesa.Asset {
        id: materialsAsset
        name: "green"
        collection: root3D.materials
    }

    Kuesa.GLTF2Importer {
        id: gltf2importer
        sceneEntity: root3D
        assignNames: true
        source: _assetsPrefix + "mearm_animation.gltf"
        options.generateTangents: true
    }

}
