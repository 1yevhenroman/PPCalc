//
//  CalcBrain.swift
//  PPCalc
//
//  Created by Yevhen Roman on 08.07.17.
//  Copyright © 2017 EugeneRoman. All rights reserved.
//

import Foundation

class Brain: Model {
    static let shared = Brain()
    
    var x: Double = 0
    var y: Double = 0
    
    var flagEntrence = 1
    var flagY = 1
    var operationActive = 0
    var decimalPoint: Bool = false
    var power = 1
    var result: String = ""
    var output = OutputAdapter.shared
    
    func putOperation (_ symbol: Int) {
        
        if  flagEntrence != 1 && self.flagY == 1
        {
            switch operationActive
            {
            case 10001: self.x = self.y + self.x
            case 10002: self.x = self.y - self.x
            case 10003: self.x = self.y * self.x
            case 10004: self.x = self.y / self.x
            case 10015: decimalPoint = true; print(decimalPoint)
            case 10014: clearAllclear()
            case 10016: inverse()
            default:  self.result = " " + String(x)
            }
            
        }
        
        operationActive = symbol
        y = x
        flagY = 1
        flagEntrence = 1
        
        self.result = " " + String(x)
        decimalPoint = false
        power = 1
        EnterEquation(equation: result)
    }
    func putOperand (_ digit: Int) {
        
        debugPrint(decimalPoint)

        if flagEntrence == 1
        {
            x = 0
            flagEntrence = 0
        }
        
        if !decimalPoint
        {
            x = x * 10 + Double(digit)
            
            switch String(self.x)
            {   case let z where z.hasSuffix(".0"):
                self.result = " " + String(Int(x))
            default: self.result = " " + String(x)
            }
            EnterEquation(equation: result)
            print ("NOT Decimal")
        }
        
        else
        {   print("DECIMAL")
            x = x + Double(digit)/pow(10,Double(power))
            power += 1
            
            switch String(x)
            {   case let z where z.hasSuffix(".0"):
                self.result = " " + String(Int(x))
            default:  self.result = " " + String(x)
            }
            
        }
        EnterEquation(equation: result)
        
    }
    private func decimal() {
        
        if decimalPoint == false
        {
            debugPrint(Brain.shared)
            decimalPoint = true
            
        }
    }
    private func clearAllclear() {
        x = 0
        y = 0
        decimalPoint = false
        switch String(x)
        {   case let z where z.hasSuffix(".0"):
            self.result = " " + String(Int(x))
        default:  self.result = " " + String(x)
        }
        flagEntrence = 1
        flagY = 1
        power = 1
        operationActive = 0
        result = "0"
        EnterEquation(equation: result)
    }
    private func inverse() {
        x = -x
        switch String(x)
        {   case let z where z.hasSuffix(".0"):
            self.result = " " + String(Int(x))
        default:  self.result = " " + String(x)
        }
        EnterEquation(equation: result)
    }
    func EnterEquation(equation: String) {
      
       output.presentResult(result: equation)
        
    }
    
}
