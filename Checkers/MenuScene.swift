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
        guard let button = childNode(withName: "SinglePlayerButton") as? Button else {
            fatalError("SinglePlayerButton couldn't be loaded")
        }
        
        button.setAction{sender in view.changeSceneTo(sceneName: "GameScene")}
        singlePlayerButton = button
        
        guard let button2 = childNode(withName: "MultiplayerButton") as? Button else {
            fatalError("MultilayerButton couldn't be loaded")
        }
        button2.setAction{sender in view.changeSceneTo(sceneName: "GameScene")}
        multiplayerButton = button
    }
}
