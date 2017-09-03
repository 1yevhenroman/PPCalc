//
//  CalcOutputAdapter.swift
//  PPCalc
//
//  Created by Yevhen Roman on 08.07.17.
//  Copyright © 2017 EugeneRoman. All rights reserved.
//

import Foundation

class OutputAdapter: OutputProtocol {
    
    static let shared = OutputAdapter()
    
    
    
    
    
    
    
    
    
    
    
    
    var resultDisplay: CalcScreenController?
    
    func presentResult(result: String) {
       resultDisplay?.presentResult(result)
    }
    
}
