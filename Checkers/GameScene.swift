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
    private var game: GameModel!
    private var gameView: GameView!
    private var resetSpace: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        gameView = GameView(scene: self)
        game = GameModel(controller: self, name1: "Player1", name2: "Player2")
        gameView.setBoard(to_configuration: game.getBoard())
        gameView.setPlayerCounts()
        gameView.setPlayerNames()
        guard let resetSpace = childNode(withName: "ResetSpace") as? SKSpriteNode else {
            fatalError("ResetSpace not loaded")
        }
        self.resetSpace = resetSpace
    }

    func tappedTile(tile: Tile) -> Void {
        gameView.clearTiles()
        game.tileSelected(tile: tile)
    }
    
    func highlight(tile: Tile, to: UIColor) -> Void {
        gameView.highlight(tile: tile, to: to)
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
    
    func gameHasEnded() -> Void {
        
    }
    
    func informMove(move: Move) -> Void {
        gameView.make(move: move)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let first = touches.first else {
            return
        }
        
        let nodesUnder = nodes(at: first.location(in: self))
        
        if nodesUnder.contains(resetSpace) {
            gameView.clearTiles()
            game.cancelMove()
        }
    }
}
