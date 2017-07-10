//
//  InputAdapter.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 6/28/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

class IntputAdapter: InputProtocol {
    
    static let shared = IntputAdapter()
    let brain = Brain.shared
    
    func enterNum(_ number: Int) {
        Validator.validateNum(number)
        brain.EnterEquation(equation: Validator.Buffer)
    }
    
    func enterUtility(_ symbol: Int) {
        switch symbol {
        case Operation.pls.rawValue : Validator.validatePls()
        case Operation.mns.rawValue : Validator.validateMns()
        case Operation.mul.rawValue : Validator.validateMul()
        case Operation.div.rawValue : Validator.validateDiv()
        case Operation.pow.rawValue : Validator.validatePow()
        case Operation.dot.rawValue : Validator.validateDot()
        case Operation.log.rawValue : Validator.validateLog()
        case Operation.sin.rawValue : Validator.validateSin()
        case Operation.cos.rawValue : Validator.validateCos()
        case Operation.sqrt.rawValue : Validator.validateSqrt()
        case Operation.equal.rawValue: Validator.Buffer = brain.equal()
        case Operation.clear.rawValue: Validator.Buffer = nil; brain.clear()
        case Operation.leftBracket.rawValue : Validator.validateLeftBracket()
        case Operation.rightBracket.rawValue : Validator.validateRightBracket()
        default: break
        }

        brain.presentHistory(currentInput: Validator.Buffer)
    }
    
}
