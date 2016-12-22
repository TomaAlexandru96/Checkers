//
//  GameModel.swift
//  Checkers
//
//  Created by Toma Alexandru on 21/12/2016.
//  Copyright © 2016 bart games. All rights reserved.
//

import Foundation

class GameModel {
    private var controller: GameControllerDelegate
    private var board: Board
    private var player1: Player
    private var player2: Player
    private var moveStack: [Move] = []
    private var turn: Player
    
    init(controller: GameControllerDelegate, name1: String, name2: String) {
        self.controller = controller
        self.player1 = Player(name: name1, isFirst: true)
        self.player2 = Player(name: name2, isFirst: false)
        self.board = Board(first: player1, second: player2)
        self.turn = player1
    }
    
    func changeTurn() {
        turn = turn == player1 ? player2 : player1
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
}
