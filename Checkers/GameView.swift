//
//  GameView.swift
//  Checkers
//
//  Created by Toma Alexandru on 21/12/2016.
//  Copyright © 2016 bart games. All rights reserved.
//

import Foundation
import SpriteKit

class GameView {
    static let selectColor: UIColor = UIColor.blue
    static let availableColor: UIColor = UIColor.green
    static let captureColor: UIColor = UIColor.red
    
    private let scene: GameScene
    private let player1Pieces: SKLabelNode
    private let player2Pieces: SKLabelNode
    private let player1Label: SKLabelNode
    private let player2Label: SKLabelNode
    private var board: SKTileMapNode!
    private let cachedTextures: [String:SKTexture] = [
        "red_checker":SKTexture(imageNamed: "red_checker"),
        "red_king_checker":SKTexture(imageNamed: "red_king_checker"),
        "white_checker":SKTexture(imageNamed: "white_checker"),
        "white_king_checker":SKTexture(imageNamed: "white_king_checker")
    ]
    
    init(scene: GameScene) {
        self.scene = scene
        
        guard let player1Label = scene.childNode(withName: "Player1") as? SKLabelNode else {
            fatalError("Player1 label couldn't be loaded")
        }
        
        self.player1Label = player1Label
        
        guard let player2Label = scene.childNode(withName: "Player2") as? SKLabelNode else {
            fatalError("Player2 label couldn't be loaded")
        }
        
        self.player2Label = player2Label
        
        guard let player1Pieces = scene.childNode(withName: "Player1/Player1PiecesCount") as? SKLabelNode else {
            fatalError("Player1/Player1PiecesCount couldn't be loaded")
        }
        
        self.player1Pieces = player1Pieces
        
        guard let player2Pieces = scene.childNode(withName: "Player2/Player2PiecesCount") as? SKLabelNode else {
            fatalError("Player2/Player2PiecesCount couldn't be loaded")
        }
        
        self.player2Pieces = player2Pieces
        initializeTaps()
    }
    
    func initializeTaps() {
        guard let board = scene.childNode(withName: "Board Border/Board") as? SKTileMapNode else {
            fatalError("Board couldn't be loaded")
        }
        
        self.board = board
        
        for y in (0..<board.numberOfRows).reversed() {
            for x in 0..<board.numberOfColumns {
                let pos = board.centerOfTile(atColumn: x, row: y)
                let tapRange = Button(color: UIColor.clear, size: board.tileSize)
                tapRange.position = pos
                tapRange.zPosition = 3
                tapRange.setAction { sender in self.scene.tappedTile(tile: Tile(y: y, x: x)) }
                scene.addChild(tapRange)
                
                let iTile: SKSpriteNode = SKSpriteNode(color: UIColor.clear, size: board.tileSize)
                iTile.position = pos
                iTile.zPosition = 1
                iTile.name = y.description + " " + x.description + " info"
                scene.addChild(iTile)
            }
        }
    }
    
    private func getInformativeTile(tile: Tile) -> SKSpriteNode {
        return scene.childNode(withName: tile.y.description + " " + tile.x.description + " info") as! SKSpriteNode
    }
    
    func highlight(tile: Tile, to: UIColor) {
        getInformativeTile(tile: tile).color = to
    }
    
    func clearTiles() {
        for y in (0..<board.numberOfRows).reversed() {
            for x in 0..<board.numberOfColumns {
                getInformativeTile(tile: Tile(y: y, x: x)).color = UIColor.clear
            }
        }
    }
    
    func setBoard(to_configuration config: Board) {
        config.forEachTile {piece in
            guard let piece = piece else {
                return
            }
            
            var texture: SKTexture
            
            if (piece.getPlayer().isPlayerFirst()) {
                if (piece.isPieceKing()) {
                    texture = cachedTextures["white_king_checker"]!
                } else {
                    texture = cachedTextures["white_checker"]!
                }
            } else {
                if (piece.isPieceKing()) {
                    texture = cachedTextures["red_king_checker"]!
                } else {
                    texture = cachedTextures["red_checker"]!
                }
            }
            let piecePos = piece.getPosition()
            let node = SKSpriteNode(texture: texture, size: board.tileSize)
            node.zPosition = 2
            node.position = board.centerOfTile(atColumn: piecePos.x, row: piecePos.y)
            scene.addChild(node)
        }
    }
    
    func update(_ currentTime: TimeInterval) {
        setPlayerCounts()
    }
    
    func setPlayerCounts() {
        player1Pieces.text = scene.getPlayer1().getNumberOfPieces().description
        player2Pieces.text = scene.getPlayer2().getNumberOfPieces().description
    }
    
    func setPlayerNames() {
        player1Label.text = scene.getPlayer1().getName()
        player2Label.text = scene.getPlayer2().getName()
    }
}
