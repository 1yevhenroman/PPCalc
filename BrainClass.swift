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
    
    var operations: Dictionary< Operation, TypeOperation> =
        [
            
            .pi : TypeOperation.constant(Double.pi),
            .sqrt : TypeOperation.unaryOperation(sqrt),
            .cos: TypeOperation.unaryOperation(cos),
            .sign : TypeOperation.unaryOperation({-$0}),
            .mul : TypeOperation.binaryOperation({$0 * $1}),
            .div : TypeOperation.binaryOperation({$0 / $1}),
            .pls : TypeOperation.binaryOperation({$0 + $1}),
            .mns : TypeOperation.binaryOperation({$0 - $1}),
            .equal : TypeOperation.equals
    ]

    
    var input: String = ""
    private let regex: String = "[-+]?\\d+.?\\d+"
//    private var counterForNumber: Int = 0
//    private var x: Double = 0
//    private var y: Double = 0
//    
//    private var xSet: Bool = false
//    private var ySet: Bool = false
    var output = OutputAdapter.shared
    private var accumulator: Double?

    //pretty good working
//    private func number() {
//        var num = input.components(separatedBy: ["+", "*", "/","-"])
//        
//        if !(xSet && ySet) {
//            x = Double(num[0])!
//            y = Double(num[1])!
//            return
//        }
//        if !xSet {
//            x = Double(num[0])!
//        }
//        else {
//            y = Double(num[0])!
//        }
//    }
        enum TypeOperation {
            case constant(Double)
            case unaryOperation((Double)->Double)
            case binaryOperation((Double,Double)->Double)
            case equals
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
                    performPendingBinaryOperation()            }
            }
            //output.presentResult(result: result)
        }
        
         func performPendingBinaryOperation(){
            if pendingBinaryOperation != nil && accumulator != nil {
                accumulator = pendingBinaryOperation!.perform(with: accumulator!)}
                pendingBinaryOperation = nil
            
        }
        
         func setOperand( _ operand: String) {
           
            let subStringArray = operand.stringsMatchingRegularExpression(expression: "[-+]?\\d+.?\\d+")
            if let number = subStringArray?[0] {
                accumulator = Double(number)
            }
           
    }
    func printOnScreen () {
     output.presentResult(result: input)
    }
    var result: String {
        get {//Поставити усмови для комфортного виводу
            if let res = accumulator {
                return String(res)
            }
            else {
              return "Error"
            }
        }
    }
    
        func enterEquation(equation: String) {
            
        }
        
   
    

    
}
