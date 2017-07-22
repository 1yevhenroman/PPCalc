//
//  PerfectedBrain.swift
//  PPCalc
//
//  Created by Yevhen Roman on 12.07.17.
//  Copyright © 2017 EugeneRoman. All rights reserved.
//

import Foundation

class Perfected: Model {
    
    static let shared = Perfected()
    
    var operations: Dictionary< Operation, TypeOperation> = [
        
        .pi : TypeOperation.constant(Double.pi),
        .sqrt : TypeOperation.unaryOperation(sqrt),
        .cos: TypeOperation.unaryOperation(cos),
        .sign : TypeOperation.unaryOperation({-$0}),
        .mul : TypeOperation.binaryOperation({$0 * $1}),
        .div : TypeOperation.binaryOperation({$0 / $1}),
        .pls : TypeOperation.binaryOperation({$0 + $1}),
        .mns : TypeOperation.binaryOperation({$0 - $1}),
        .per :TypeOperation.unaryOperation({$0/100}),
        .equal : TypeOperation.equals,
        .clear: TypeOperation.clear
    ]
    
    
    var input: String = " "
    var output = OutputAdapter.shared
    private var accumulator: Double?
    
    enum TypeOperation {
        case constant(Double)
        case unaryOperation((Double)->Double)
        case binaryOperation((Double,Double)->Double)
        case equals
        case clear
    }
    
    struct PendingBinaryOperation {
        let function: (Double,Double)->Double
        let firstOperand: Double
        func perform(with secondOperand: Double)->Double{
            return function(firstOperand, secondOperand)
        }
    }
    var pendingBinaryOperation: PendingBinaryOperation?
    
    func performOperation(_ symbol: Operation) {
        if let operation = operations[symbol] {
            switch operation {
            case .constant(let value): accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)}
            case .binaryOperation(let function):
                if accumulator != nil {
                    pendingBinaryOperation=PendingBinaryOperation(function: function, firstOperand: accumulator!)
                    accumulator=nil
                }
            case .equals():
                performPendingBinaryOperation()
            case .clear():
                accumulator = nil
                input = " "
                output.presentResult(result: result)
            }
        }
        if accumulator != nil {
        output.presentResult(result: result)
        }
    }
    
    func performPendingBinaryOperation() {
        if pendingBinaryOperation != nil && accumulator != nil {
            accumulator = pendingBinaryOperation!.perform(with: accumulator!)
        }
        pendingBinaryOperation = nil
    }
    func setOperand( _ operand: String) {
        if let number = Double(operand)  {
            accumulator = number
            output.presentResult(result: result)
        }
    }
    func printOnScreen () {
        output.presentResult(result: result)
    }
    
    var result: String {
        get {
            if let res = accumulator {
                var modifiedResult = String(res)
                if modifiedResult.hasSuffix(".0") {
                    let range = modifiedResult.index(modifiedResult.endIndex, offsetBy: -2)..<modifiedResult.endIndex
                    modifiedResult.removeSubrange(range)
                    return modifiedResult
                }
                return String(res)
            }
            else {
                return " "
            }
        }
    }
    func performingForShowing(result: String)->String {
        if var modifiedResult = String(result) {
            if modifiedResult.hasSuffix(".0") {
                let range = modifiedResult.index(modifiedResult.endIndex, offsetBy: -2)..<modifiedResult.endIndex
                modifiedResult.removeSubrange(range)
                return modifiedResult
            }
        }
        return " "
    }
    func enterEquation(equation: String) {
        
    }
    
}
