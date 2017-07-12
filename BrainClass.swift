import Foundation
import Darwin

class CalcLogic: Model {
    
    var x:Double = 0
    var y:Double = 0
    var tmp: Double = 0
    static let shared = CalcLogic()
    var flagEntrance = 1
    var flagY = 1
    var operationActive = 0
    var decimalPoint = 0
   
    var power = 1 //???
    
    var result: String = ""
    var output = OutputAdapter.shared
    var continueCalculation: Bool = true
    
    func tapDigit (digit: Int) {
        
        continueCalculation = false
        
        if flagEntrance == 1
        {
            x = 0
            flagEntrance = 0
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
        
        if  flagEntrance != 1 && flagY == 1
        {
            switch operationActive
            {
            case 10001: x = y + x
            case 10002: x = y - x
            case 10003: x = y * x
            case 10004: x = y / x
                
            default:  result = " " + String(x)
            }
            
        }
        switch operationActive
        {
        case 10013: output.presentResult(result: String(x))
        case 10014: clearAllclear()
        case 10016: Inverse()
        case 10015: decimal()
        case 10013: equal( &x,&y ) ; continueCalculation = true

        default:  result = " " + String(x)
        }
        operationActive = symbol
        
        y = x
        
        flagY = 1
        flagEntrance = 1
        result = " " + String(x)
        //Написати аутпут щоб забирав крапку
        output.presentResult(result: String(x))
        //decimalPoint = 0 - переніс вгору
        power = 1
        

    }
    func equal(_ x: inout Double, _ y: inout  Double) {
        
        if !continueCalculation {
            tmp = y
        }
        if flagEntrance == 1
        {
            print(String(y))
        }
        else { print(String(x))}
        
        if continueCalculation {
            switch operationActive
            {
            case 10001: x = tmp + x
            case 10002: x = tmp - x
            case 10003: x = tmp * x
            case 10004: x = tmp / x
                
            default:  result = " " + String(x)
            }
            print(String(x))
        }
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
        
        flagEntrance = 1
        flagY = 1
        power = 1
        operationActive = 0
        output.presentResult(result: "0")
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
    func print( _ printIt: String) {
        output.presentResult(result: printIt)
    }
}
