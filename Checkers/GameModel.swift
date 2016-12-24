//
//  GameModel.swift
//  Checkers
//
//  Created by Toma Alexandru on 21/12/2016.
//  Copyright © 2016 bart games. All rights reserved.
//

import Foundation

class GameModel {
    private var controller: GameScene
    private var board: Board
    private var player1: Player
    private var player2: Player
    private var moveStack: [Move] = []
    private var turn: Player
    private var currentMove: MoveSequence? = nil
    
    init(controller: GameScene, name1: String, name2: String) {
        self.controller = controller
        self.player1 = Player(name: name1, white: true)
        self.player2 = Player(name: name2, white: false)
        self.board = Board(first: player1, second: player2)
        self.turn = player1
    }
    
    func changeTurn() {
        turn = turn == player1 ? player2 : player1
    }
    
    func hasEnded() -> Bool {
        var ended: Bool = true
        
        board.forEachPiece { piece in
            if piece.getPlayer() == turn {
                if ended {
                    ended = piece.hasMoves()
                }
            }
        }
        
        return ended
    }
    
    func tileSelected(tile: Tile) -> Void {
        guard !hasEnded() else {
            return
        }
        
        if board.isOccupied(tile: tile, by: turn) && board.getPiece(from: tile)!.hasMoves() {
            currentMove = MoveSequence(piece: board.getPiece(from: tile)!)
            informControllerMoveSelection()
            return
        }
        
        guard let currentMove = currentMove else {
            return
        }
        
        guard currentMove.isValidTile(tile: tile) else {
            cancelMove()
            return
        }
        
        informControllerMoveSelection()
        guard let move = currentMove.place(tile: tile) else {
            return
        }
        make(move: move)
        self.currentMove = nil
    }
    
    func make(move: Move) -> Void {
        moveStack.append(move)
        move.piece.move(move: move)
        move.captures.forEach({tile in
            board.remove(tile: tile)
        })
        controller.informMove(move: move)
        if hasEnded() {
            controller.gameHasEnded()
        }
    }
    
    func informControllerMoveSelection() -> Void {
        guard let currentMove = currentMove else {
            return
        }
        controller.highlight(tile: currentMove.getPiecePosition(), to: GameView.selectColor)
        currentMove.getAvailablePositions().forEach({controller.highlight(tile: $0, to: GameView.availableColor)})
        currentMove.getCaptures().forEach({controller.highlight(tile: $0, to: GameView.captureColor)})
    }
    
    func cancelMove() {
        currentMove?.cancel()
        currentMove = nil
    }
    
    func getPlayer1() -> Player {
        return player1
    }
    
    func getPlayer2() -> Player {
        return player2
    }
    
    func getBoard() -> Board {
        return board
    }
    
    func getCurrentTurn() -> Player {
        return turn
    }
}
