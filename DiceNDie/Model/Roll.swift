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
    var log : [Int] = []
    var desc : String
    
    init(name: String, mod: Int, desc: String) {
        self.name = name
        self.mod = mod
        self.desc = desc
    }
    
    func addDice(die : Die) {
        self.dice.append(die)
    }
    
    func rollAll(){
        for die in dice {
            die.roll()
        }
    }
}
