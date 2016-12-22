//
//  GameScene.swift
//  Checkers
//
//  Created by Toma Alexandru on 21/12/2016.
//  Copyright © 2016 bart games. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, GameControllerDelegate {
    private var game: GameModel!
    private var gameView: GameView!
    
    override func didMove(to view: SKView) {
        gameView = GameView(scene: self)
        game = GameModel(controller: self, name1: "Player1", name2: "Player2")
        gameView.setBoard(to_configuration: game.getBoard())
        gameView.setPlayerNames()
    }
    
    func tappedTile(tile: Tile) -> Void {
        gameView.clearTiles()
        gameView.highlight(tile: tile, to: GameView.selectColor)
    }
    
    override func update(_ currentTime: TimeInterval) {
        gameView.update(currentTime)
    }
    
    func getPlayer1() -> Player {
        return game.getPlayer1()
    }
    
    func getPlayer2() -> Player {
        return game.getPlayer2()
    }
}
