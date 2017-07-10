//
//  Validator.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 7/4/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

class Validator {
    private static var buffer: String!
    static var Buffer: String! { set { self.buffer = newValue } get { return self.buffer } }
    
    static func validateNum(_ num: Int) {
        if buffer == nil || buffer == "0" {
            buffer = String(num)
            
        } else if buffer.characters.last == "." || buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
            buffer = buffer + "\(num)"
            
        } else if buffer.characters.count == 1 && (buffer.characters.last == "+" || buffer.characters.last == "-")  {
            buffer = buffer + "\(num)"
        } else {
            buffer = buffer + " \(num)"
        }
    }
    
    static func validatePls() {
        if buffer == nil || buffer == "0" || buffer.characters.count == 1 && buffer.characters.last == "-" {
            buffer = "+"
        } else if buffer.characters.last == ")" {
            buffer = buffer + " +"
            
        } else if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
            buffer = buffer + " +"
        } else {
            buffer.characters.removeLast()
            buffer = buffer + "+"
        }
    }
    
    static func validateMns() {
        if buffer == nil || buffer == "0" || buffer.characters.count == 1 && buffer.characters.last == "+" {
            buffer = "-"
        } else if buffer.characters.last == ")" {
            buffer = buffer + " )"
            
        } else if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
            buffer = buffer + " -"
        } else {
            buffer.characters.removeLast()
            buffer = buffer + "-"
        }
    }
    
    static func validateDot() {
        if buffer == nil || buffer == "0" {
            buffer = "0."
        } else if buffer.characters.last != "." {
            if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
                buffer! += "."
            } else {
                buffer = buffer + " 0."
            }
        }
    }
    
    static func validateMul() {
        if buffer != nil && buffer.characters.count > 1 {
            if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
                buffer = buffer + " ×"
            } else if buffer.characters.last == ")" {
                buffer = buffer + " ×"
                
            } else {
                buffer.characters.removeLast()
                buffer = buffer + "×"
            }
        }
    }
    
    static func validateDiv() {
        if buffer != nil && buffer.characters.count > 1 {
            if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
                buffer = buffer + " ÷"
            } else if buffer.characters.last == ")" {
                buffer = buffer + " ÷"
                
            } else {
                buffer.characters.removeLast()
                buffer = buffer + "÷"
            }
        }
    }
    
    static func validatePow() {
        if (buffer != nil && buffer != "0") && buffer.characters.count >= 1 {
            if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" {
                buffer = buffer + " ^"
            } else if buffer.characters.last == ")" {
                buffer = buffer + " ^"
                
            } else {
                buffer.characters.removeLast()
                buffer = buffer + "^"
            }
        }
    }
    
    static func validateSqrt() {
        buffer == nil || buffer == "0" ? (buffer = "√") : (buffer = buffer + " √")
    }
    
    static func validateLog() {
        buffer == nil || buffer == "0" ? (buffer = "ln (") : (buffer = buffer + " ln (")
        Brain.shared.countLeftBrackets += 1
    }
    
    static func validateSin() {
        buffer == nil || buffer == "0" ? (buffer = "sin (") : (buffer = buffer + " sin (")
        Brain.shared.countLeftBrackets += 1
    }
    
    static func validateCos() {
        buffer == nil || buffer == "0" ? (buffer = "cos (") : (buffer = buffer + " cos (")
        Brain.shared.countLeftBrackets += 1
    }
    
    static func validateLeftBracket() {
        if buffer == nil || buffer == "0" {
            buffer = "("
            Brain.shared.countLeftBrackets += 1
        } else if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" || buffer.characters.last! == ")" {
            buffer = buffer + " × ("
            Brain.shared.countLeftBrackets += 1
        } else {
            buffer = buffer + " ("
            Brain.shared.countLeftBrackets += 1
        }
    }
    
    static func validateRightBracket() {
        if Brain.shared.countLeftBrackets != 0 {
            if buffer.characters.last! >= "0" && buffer.characters.last! <= "9" ||
                (buffer.characters.last == ")" && Brain.shared.countLeftBrackets > Brain.shared.countRightBrackets) {
                
                buffer = buffer + " )"
                Brain.shared.countRightBrackets += 1
            } else {
                buffer.characters.removeLast()
                buffer = buffer + ")"
                Brain.shared.countRightBrackets += 1
            }
        }
    }
}
