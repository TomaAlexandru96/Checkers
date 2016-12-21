//
//  GameScene.swift
//  Checkers
//
//  Created by Toma Alexandru on 21/12/2016.
//  Copyright © 2016 bart games. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var board: SKTileMapNode?
    
    override func didMove(to view: SKView) {
        if let board = childNode(withName: "Board Border/Board") as? SKTileMapNode {
            self.board = board
        }
    }
}
