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
    var dice : [Die] = []
    var mod : Int
    var desc : String
    var total : Int
    init(name: String, mod: Int, desc: String) {
        self.name = name
        self.mod = mod
        self.desc = desc
        self.total = 0
    }
    
    func addDice(die : Die) {
        self.dice.append(die)
    }
    
    func rollAll(){
        for die in dice {
            die.roll()
        }
    }
    
    func getRolls() -> String {
        var description = ""
        total = 0
        rollAll()
        for die in dice {
            let diceRoll = die.value
            total += diceRoll
            description += "\(diceRoll) \(die !== dice.last ? "+ " : "")"
        }
        total += mod
        description += mod != 0 ? "+ \(mod)" : ""
        return description
    }
}
