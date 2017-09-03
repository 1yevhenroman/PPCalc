//
//  CalcCheckerInput.swift
//  PPCalc
//
//  Created by Yevhen Roman on 08.07.17.
//  Copyright © 2017 EugeneRoman. All rights reserved.
//

import Foundation

class Checker {
    
    private var lastSymbol: String = ""
    static let shared = Checker()
    private var inTheMiddleOfTyping: Bool = false
    private var decimal: Bool = false
    
    func transformInput(_ symbol: Int)->String
    {
        
        switch symbol {
            
        case Operation.pls.rawValue : return "+"
        case Operation.mns.rawValue : return "-"
        case Operation.mul.rawValue : return "×"
        case Operation.div.rawValue : return "÷"
        case Operation.pow.rawValue : return "ˆ"
        case Operation.dot.rawValue : return "."
        case Operation.log.rawValue : return "log"
        case Operation.sin.rawValue : return "sin"
        case Operation.cos.rawValue : return "cos"
        case Operation.sqrt.rawValue : return "√"
        case Operation.equal.rawValue: return "="
        case Operation.clear.rawValue: return "С"
        default: break
        }
        return ""
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
