//
//  CalcInputAdapter.swift
//  PPCalc
//
//  Created by Yevhen Roman on 08.07.17.
//  Copyright © 2017 EugeneRoman. All rights reserved.
//

import Foundation

class IntputAdapter: InputProtocol {
    
    static let shared = IntputAdapter()
    let brain = EasyBrain.shared

func enterNum(_ number: Int) {
    brain.putDigit(number)
//    switch number {
//
//    }
}

func enterUtility(_ symbol: Int) {
    brain.putOperation(symbol)
   // brain.putOperation(symbol)
    }
    
}
