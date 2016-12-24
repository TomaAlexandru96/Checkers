//
//  ViewPiece.swift
//  Checkers
//
//  Created by Toma Alexandru on 24/12/2016.
//  Copyright © 2016 bart games. All rights reserved.
//

import Foundation
import SpriteKit

class ViewPiece: SKSpriteNode {
    private let cachedTextures: [String:SKTexture] = [
        "red_checker":SKTexture(imageNamed: "red_checker"),
        "red_king_checker":SKTexture(imageNamed: "red_king_checker"),
        "white_checker":SKTexture(imageNamed: "white_checker"),
        "white_king_checker":SKTexture(imageNamed: "white_king_checker")
    ]
    private var piece: Piece
    private var board: SKTileMapNode
    private var gameView: GameView
    
    init(gameView: GameView, piece: Piece, board: SKTileMapNode) {
        var texture: SKTexture
        self.piece = piece
        self.board = board
        self.gameView = gameView
        
        if (piece.getPlayer().isWhite()) {
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
        super.init(texture: texture, color: UIColor.clear, size: board.tileSize)
        zPosition = 2
        setPosTo(tile: piece.getPosition())
    }
    
    func move(to: Move) -> Void {
        setPosTo(tile: to.getLastPosition())
        to.captures.forEach({capture in
            //gameView.remove(piece: capture)
        })
    }
    
    private func setPosTo(tile: Tile) -> Void {
        position = board.centerOfTile(atColumn: tile.x, row: tile.y)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
