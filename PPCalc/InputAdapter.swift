//
//  InputAdapter.swift
//  Calculator
//
//  Created by Yevhen Roman on 6/28/17.
//  Copyright © 2017 Yevhen Roman. All rights reserved.
//

import Foundation

class IntputAdapter: InputProtocol {
    
    var inTheMiddleOfTyping = false
    var dot = false
    static let shared = IntputAdapter()
    let brain = Perfected.shared
    
    func enterNum(_ number: Int) {
        inTheMiddleOfTyping = true
        brain.input+=String(number)
        brain.printOnScreen()
    }
    
    func enterUtility(_ symbol: Int) {
        switch symbol {
        case Operation.dot.rawValue:
            if inTheMiddleOfTyping && !dot {
                brain.input = brain.input + "."
                brain.printOnScreen()
                dot = true
            }
        default:
            brain.setOperand(brain.input)
            inTheMiddleOfTyping = false
            brain.performOperation(symbol)
            brain.input = ""
            dot = false
        }
    }
    
}
