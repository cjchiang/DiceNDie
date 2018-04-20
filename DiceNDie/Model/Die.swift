//
//  Dice.swift
//  DiceNDie
//
//  Created by Nate Chiang on 2018-04-18.
//  Copyright © 2018 Nate Chiang. All rights reserved.
//

import Foundation
import Darwin

class Die {
    var max : Int
    var value : Int
    init(max: Int) {
        self.max = max
        self.value = 0
    }
    
    func roll() {
        let range = max
        value =  Int(arc4random_uniform(UInt32(range))) + 1
    }
}
