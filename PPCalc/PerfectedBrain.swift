//
//  PerfectedBrain.swift
//  PPCalc
//
//  Created by Yevhen Roman on 12.07.17.
//  Copyright © 2017 EugeneRoman. All rights reserved.
//

import Foundation

extension String {
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound - r.lowerBound)
        return self[Range(start ..< end)]
    }
}
extension String {
    
    func stringsMatchingRegularExpression(expression exp:String) -> [String]? {
        var strArray:[String]?
        var rangeArray:[NSRange]?
        let strLength = self.characters.count
        var startOfRange = 0
        do {
            let regexString = try NSRegularExpression(pattern: exp, options: [])
            while startOfRange <= strLength {
                let rangeOfMatch = regexString.rangeOfFirstMatch(in: self, options: [], range: NSMakeRange(startOfRange, strLength-startOfRange))
                if let rArray = rangeArray {
                    rangeArray = rArray + [rangeOfMatch]
                }
                else {
                    rangeArray = [rangeOfMatch]
                }
                startOfRange = rangeOfMatch.location+rangeOfMatch.length
                
                
            }
            if let ranArr = rangeArray {
                for r in ranArr {
                    
                    if !NSEqualRanges(r, NSMakeRange(NSNotFound, 0)) {
                        self.index(startIndex, offsetBy: r.length)
                        
                        let r =  self.index(startIndex, offsetBy:r.location)..<self.index(startIndex, offsetBy:r.location + r.length)
                        
                        // return the value
                        let substringForMatch = self.substring(with: r)
                        if let sArray = strArray {
                            strArray = sArray + [substringForMatch]
                        }
                        else {
                            strArray = [substringForMatch]
                        }
                        
                    }
                    
                }
            }
        }
        catch {
            // catch errors here
        }
        
        return strArray
    }
}





class PerfectedBrain: Model {
    
    private var input: String = ""
    private let regex: String = "[-+]?\\d+.?\\d+"
    private var index: Int = 0
    private var firstEntrance: Bool = true
    private var counterForNumber: Int = 0
    static let shared = PerfectedBrain()
    var output = OutputAdapter.shared
    
    //Підглядає на карент елемент
    private func peek()->Character {
        
        let symbol = input [index] as Character
        return symbol
    }
    private func get()->Character {
        let symbol = input [index] as Character
        index += 1
        return symbol
    }
    private func number()->Double {
        
        var result: Double = 0//ініціалізація
        let parse = input.stringsMatchingRegularExpression(expression: regex)
        
        if ((parse?[counterForNumber]) != nil)  {
            result = Double((parse?[counterForNumber])!)!
            counterForNumber += 1
        }
        return result
    }
    private func factor()->Double {
        //має бути як '0'
        if ((peek() >= Character("0") && peek() <= Character("9")) || peek() == Character(".")) {
            return number()
        }
        else if (peek() == Character("(")) {
            //Ignore warning
            get()// '('
            let result:Double = expression()
            //Ignore warning
            get()//')'
            return result
        }
        else if(peek() == Character("-")) {
            //Ignore warning
            get()
            return -expression()
        }
        return 0 //error
    }
    private func term()->Double {
        var result:Double = factor()
        while (peek() == Character("*") || peek() == Character("/")) {
            if (get() == Character ("*")) {
                result *= factor()
            }
            else {
                result /= factor()
            }
        }
        return result
    }
    private func expression()->Double {
        var result:Double = term()
        while (peek() == Character("+") || peek() == Character("-")) {
            if (get() == Character ("+")) {
                result += factor()
            }
            else {
                result -= factor()
            }
        }
        return result
    }
    private func reset() {
        index = 0
        counterForNumber = 0
        input = ""
        firstEntrance = true
        output.presentResult(result: "0")
        
    }
    private func calculate(_ equation: String)->Double {
        input = equation
        var result: Double = expression()
        reset()
        return result
    }
    func enterEquation (equation: String) {
        output.presentResult(result:String(calculate(equation)))
    }
    func formingEquationDigit(_ digit: Int) {
            input += String (digit)
        
    }
    func formingEquationSymbol(symbol: Int) {
        
        switch symbol {
        case Operation.pls.rawValue: input += String ("+")
        case Operation.mns.rawValue: input += String ("-")
        case Operation.mul.rawValue: input += String ("*")
        case Operation.div.rawValue: input += String ("/")
        case Operation.equal.rawValue: output.presentResult(result:String(calculate(input)))
        case Operation.clear.rawValue: reset()
        default: output.presentResult(result:String(calculate(input)))
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
