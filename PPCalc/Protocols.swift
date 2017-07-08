//  Protocols.swift
//  PPCalc
//  Created by Yevhen Roman on 08.07.17.
//  Copyright © 2017 EugeneRoman. All rights reserved.

import Foundation


protocol InputProtocol {
    func enterNum(_ number: Int)
    func enterUtility(_ symbol: Int)
}

protocol OutputProtocol {
    func presentResult(result: String)
}

protocol Model {
    func EnterEquation(equation: String)
}
