//
//  OutputAdapter.swift
//  Calculator
//
//  Created by Yevhen Roman on 6/28/17.
//  Copyright © 2017 Yevhen Roman. All rights reserved.
//

import Foundation

class OutputAdapter: OutputProtocol {
    static let shared = OutputAdapter()
    
    var resultDisplay: CalcScreenController?
    
    func presentResult(result: String) {
        resultDisplay?.presentResult(result)
    }
}
