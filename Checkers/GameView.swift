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
    private var tiles: [[ViewTile?]] = []
    private var pieces: [Piece: ViewPiece] = [:]
    
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
        self.tiles = [[ViewTile?]](repeating: [ViewTile?](repeating: nil, count: Board.BOARD_SIZE_X), count: Board.BOARD_SIZE_Y)
        
        for y in (0..<board.numberOfRows).reversed() {
            for x in 0..<board.numberOfColumns {
                let tile: Tile = Tile(y: y, x: x)
                let viewTile = ViewTile(action: ViewActionTile(position: tile, board: board, scene: scene), info: ViewInfoTile(position: tile, board: board))
                tiles[y][x] = viewTile
                scene.addChild(viewTile.action)
                scene.addChild(viewTile.info)
            }
        }
    }
    
    private func getViewTile(tile: Tile) -> ViewTile {
        guard let viewTile = tiles[tile.y][tile.x] else {
            fatalError()
        }
        
        return viewTile
    }
    
    private func getViewTile(y: Int, x: Int) -> ViewTile {
        return getViewTile(tile: Tile(y: y, x: x))
    }
    
    func highlight(tile: Tile, to: UIColor) {
        getViewTile(tile: tile).info.color = to
    }
    
    func clearTiles() {
        for y in (0..<board.numberOfRows).reversed() {
            for x in 0..<board.numberOfColumns {
                getViewTile(y: y, x: x).info.color = UIColor.clear
            }
        }
    }
    
    func setBoard(to_configuration config: Board) {
        config.forEachPiece {piece in
            let viewPiece = ViewPiece(gameView: self, piece: piece, board: board)
            self.pieces[piece] = viewPiece
            scene.addChild(viewPiece)
        }
    }
    
    // TODO
    func remove(piece: Piece) -> Void {
    }
    
    func make(move: Move) -> Void {
        setPlayerCounts()
        clearTiles()
        pieces[move.piece]?.move(to: move)
    }
    
    func update(_ currentTime: TimeInterval) {
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
