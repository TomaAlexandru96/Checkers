//
//  Player.swift
//  Checkers
//
//  Created by Toma Alexandru on 21/12/2016.
//  Copyright © 2016 bart games. All rights reserved.
//

import Foundation

class Player: Equatable {
    private var name: String
    private var isFirst: Bool
    private var numberOfPieces: Int = 0
    
    init(name: String, isFirst: Bool) {
        self.name = name
        self.isFirst = isFirst
    }
    
    func incrementNumberOfPiceces() -> Void {
        numberOfPieces += 1
    }
    
    func decrementNumberOfPiceces() -> Void {
        numberOfPieces -= 1
    }
    
    func getNumberOfPieces() -> Int {
        return numberOfPieces
    }
    
    func isPlayerFirst() -> Bool {
        return isFirst
    }
    
    func getName() -> String {
        return name
    }
}

func ==(this: Player, other: Player) -> Bool{
    return this.isPlayerFirst() == other.isPlayerFirst()
}
