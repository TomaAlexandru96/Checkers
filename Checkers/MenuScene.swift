//
//  MenuScene.swift
//  Checkers
//
//  Created by Toma Alexandru on 21/12/2016.
//  Copyright © 2016 bart games. All rights reserved.
//

import Foundation
import SpriteKit

class MenuScene: SKScene {
    var singlePlayerButton: Button?
    var multiplayerButton: Button?
    
    override func didMove(to view: SKView) {
        if let button = childNode(withName: "SinglePlayerButton") as? Button {
            button.setAction{sender in view.changeSceneTo(sceneName: "GameScene")}
            singlePlayerButton = button
        }
        
        if let button = childNode(withName: "MultiplayerButton") as? Button {
            button.setAction{sender in view.changeSceneTo(sceneName: "GameScene")}
            multiplayerButton = button
        }
    }
}
