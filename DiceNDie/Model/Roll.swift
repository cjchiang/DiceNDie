//
//  Roll.swift
//  DiceNDie
//
//  Created by Nate Chiang on 2018-04-18.
//  Copyright © 2018 Nate Chiang. All rights reserved.
//

import Foundation

class Roll {
    var name : String
    var desc : String
    var dice : [Die] = []
    var mod : Int
    var log : [Int] = []
    
    init(name: String, desc: String, mod: Int) {
        self.name = name
        self.desc = desc
        self.mod = mod
    }
    
    func addDice(die : Die) {
        self.dice.append(die)
    }
    
    func getRoll() -> Int {
        var total = 0
        for die in dice {
            let diceRoll = die.roll()
            log.append(diceRoll)
            total += diceRoll
        }
        log.append(mod)
        return total + mod
    }
    
}
