//
//  OutputAdapter.swift
//  Calculator
//
//  Created by Kristina Del Rio Albrechet on 6/28/17.
//  Copyright © 2017 Kristina Del Rio Albrechet. All rights reserved.
//

import Foundation

class OutputAdapter: OutputProtocol {
    static let shared = OutputAdapter()

    var resultDisplay: CalcScreenController?

    func presentResult(result: String) {
        resultDisplay?.presentResult(result)
    }
}
