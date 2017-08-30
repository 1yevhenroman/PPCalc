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
    let brain = Perfected.shared
    
    func enterNum(_ number: Int) {
       brain.input+=String(number)
    }
    
    func enterUtility(_ symbol: Int) {
        
    }
    
}
