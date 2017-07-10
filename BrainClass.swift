import Foundation
import Darwin

class CalcLogic: Model {
    
    var x:Double = 0
    var y:Double = 0
    static let shared = CalcLogic()
    var flagEntrence = 1
    var flagY = 1
    var operationActive = 0
    var decimalPoint = 0
    var power = 1
    var result: String = ""
    var output = OutputAdapter.shared
    
    func tapDigit (digit: Int) {
        if flagEntrence == 1
        {
            x = 0
            flagEntrence = 0
        }
        
        if decimalPoint == 0
        {
            x = x * 10 + Double(digit)
            
            switch String(x) {
            case let z where z.hasSuffix(".0"):
                result = " " + String(Int(x))
            default:  result = " " + String(x)
            }
        }
        else
        {
            x = x + Double(digit) / pow (10, Double(power))
            
            switch String(x)
            {   case let z where z.hasSuffix(".0"):
                result = " " + String(Int(x))
            default:  result = " " + String(x)
            }
            
        }
        output.presentResult(result: String(x))
    }
    func tapUtility (symbol: Int) {
        
        decimalPoint = 0
        
        if  flagEntrence != 1 && flagY == 1
        {
            switch operationActive
            {
            case 10001: x = y + x
            case 10002: x = y - x
            case 10003: x = y * x
            case 10004: x = y / x
            case 10013: print()
            
            default:  result = " " + String(x)
            }
            
        }
        switch operationActive
        {
        case 10013: print()
        case 10014: clearAllclear()
        case 10016: Inverse()
        case 10015: decimal()
        default:  result = " " + String(x)
        }
        operationActive = symbol
        
        y = x
        
        flagY = 1
        flagEntrence = 1
        
        result = " " + String(x)
        //Написати аутпут щоб забирав крапку
        output.presentResult(result: String(y))
        //decimalPoint = 0 - переніс вгору
        power = 1
        

    }
    func decimal() {
        
        if decimalPoint == 0
        {
            decimalPoint = 1
            
        }
    }
    func clearAllclear() {
        x = 0
        y = 0
        decimalPoint = 0
        switch String(x) {
        case let z where z.hasSuffix(".0"):
        self.result = " " + String(Int(x))
        default:  self.result = " " + String(x)
        }
        flagEntrence = 1
        flagY = 1
        power = 1
        operationActive = 0
    }
    
    func Inverse() {
        x = -x
        switch String(x)
        {   case let z where z.hasSuffix(".0"):
            self.result = " " + String(Int(x))
        default:  self.result = " " + String(x)
        }
    }


    func enterEquation(equation: String) {
        
    }
    func print() {
        output.presentResult(result: result)
    }
}
