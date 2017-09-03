//
//  PPCalcTests.swift
//  PPCalcTests
//
//  Created by Yevhen Roman on 12.07.17.
//  Copyright © 2017 EugeneRoman. All rights reserved.
//

import XCTest
@testable import PPCalc

class PPCalcTests: XCTestCase {
    
    let input = IntputAdapter.shared
        let output = OutputAdapter.shared
        
        var result: String?
        
        override func setUp() {
            super.setUp()
            
            //output.resultDisplay = { [weak self] result in self?.result = result }
        }
        
        override func tearDown() {
            
            super.tearDown()
        }
        
//        func testNumbers() {
//        input.enterUtility(.clear)
//            input.enterNum(5)
//            input.enterNum(9)
//            
//            XCTAssertNotNil(result, "Result cant be nil")
//            XCTAssert(result == "59", "Result must be 59")
//        }
//        
//        func test6BigNumbers() {
//           // input.enterUtility(.clear)
//            input.enterNum(123456)
//            
//            XCTAssertNotNil(result, "Result cant be nil")
//            XCTAssert(result == "123456", "Result must be 123456, but \(result!) is presented")
//        }
//        
//        func test9BigNumbers() {
//            input.enterUtility(.clear)
//            input.enterNum(123456789)
//            
//            XCTAssertNotNil(result, "Result cant be nil")
//            XCTAssert(result == "123456789", "Result must be 123456789, but \(result!) is presented")
//        }
//        
//        func testSimlePlus() {
//            input.enterUtility(.clear)
//            input.enterNum(25)
//            input.enterUtility(.pls)
//            input.enterNum(21)
//            
//            XCTAssertNotNil(result, "Result cant be nil")
//            XCTAssert(result == "46", "Result must be 46, but \(result!) is presented")
//        }
//        
//        func testDoublePlus() {
//            input.enterUtility(.clear)
//            input.enterNum(25)
//            input.enterUtility(.pls)
//            input.enterUtility(.pls)
//            input.enterNum(21)
//            
//            XCTAssertNotNil(result, "Result cant be nil")
//            XCTAssert(result == "46", "Result must be 46, but \(result!) is presented")
//        }
//        
//        func testPlusInSequence() {
//            input.enterUtility(.clear)
//            input.enterNum(25)
//            input.enterUtility(.pls)
//            input.enterNum(21)
//            input.enterUtility(.equal)
//            input.enterUtility(.equal)
//            input.enterUtility(.equal)
//            
//            XCTAssertNotNil(result, "Result cant be nil")
//            XCTAssert(result == "88", "Result must be 88, but \(result!) is presented")
//        }
//        
//        func testMinus() {
//            input.enterUtility(.clear)
//            input.enterNum(2)
//            input.enterUtility(.mns)
//            input.enterNum(3)
//            input.enterUtility(.equal)
//            
//            XCTAssertNotNil(result, "Result cant be nil")
//            XCTAssert(result == "-1", "Result must be -1, but \(result!) is presented")
//        }
//        
//        func testDoubleOperation() {
//            input.enterUtility(.clear)
//            input.enterNum(2)
//            input.enterUtility(.mul)
//            input.enterUtility(.mul)
//            input.enterNum(3)
//            input.enterUtility(.equal)
//            
//            XCTAssertNotNil(result, "Result cant be nil")
//            XCTAssert(result == "6", "Result must be 6, but \(result!) is presented")
//        }
//        
//        func testDivByZeroOperation() {
//            input.enterUtility(.clear)
//            input.enterNum(2)
//            input.enterUtility(.div)
//            input.enterNum(0)
//            input.enterUtility(.equal)
//            
//            XCTAssertNotNil(result, "Result cant be nil")
//            XCTAssert(result == "inf", "Result must be inf, but \(result!) is presented")
//        }
//        
//        func testSequenceOfOperations() {
//            input.enterUtility(.clear)
//            input.enterNum(2)
//            input.enterUtility(.pls)
//            input.enterNum(6)
//            input.enterUtility(.mul)
//            input.enterNum(8)
//            input.enterUtility(.div)
//            input.enterNum(2)
//            input.enterUtility(.mns)
//            input.enterNum(1)
//            input.enterUtility(.equal)
//            
//            XCTAssertNotNil(result, "Result cant be nil")
//            XCTAssert(result == "25", "Result must be 25, but \(result!) is presented")
//        }
//        
//        func testBrackets() {
//            input.enterUtility(.clear)
//            input.enterUtility(.leftBracket)
//            input.enterNum(5)
//            input.enterUtility(.pls)
//            input.enterNum(2)
//            input.enterUtility(.rightBracket)
//            input.enterUtility(.mul)
//            input.enterNum(3)
//            input.enterUtility(.equal)
//            
//            XCTAssertNotNil(result, "Result cant be nil")
//            XCTAssert(result == "21", "Result must be 21, but \(result!) is presented")
//        }
//        
//        func testLotsBracetsWithoutEnd() {
//            input.enterUtility(.clear)
//            input.enterUtility(.leftBracket)
//            input.enterUtility(.leftBracket)
//            input.enterNum(5)
//            input.enterUtility(.pls)
//            input.enterNum(2)
//            input.enterUtility(.rightBracket)
//            input.enterUtility(.mul)
//            input.enterNum(2)
//            input.enterUtility(.pls)
//            input.enterUtility(.leftBracket)
//            input.enterUtility(.leftBracket)
//            input.enterNum(3)
//            input.enterUtility(.mns)
//            input.enterNum(5)
//            input.enterUtility(.rightBracket)
//            input.enterUtility(.div)
//            input.enterNum(2)
//            
//            input.enterUtility(.equal)
//            
//            XCTAssertNotNil(result, "Result cant be nil")
//            XCTAssert(result == "13", "Result must be 21, but \(result!) is presented")
//        }
//        
//        
//        func testMulOnBracets() {
//            input.enterUtility(.clear)
//            input.enterNum(3)
//            input.enterUtility(.leftBracket)
//            input.enterNum(5)
//            input.enterUtility(.mns)
//            input.enterNum(6)
//            input.enterUtility(.leftBracket)
//            input.enterNum(5)
//            input.enterUtility(.mns)
//            input.enterNum(69)
//            
//            input.enterUtility(.equal)
//            
//            XCTAssertNotNil(result, "Result cant be nil")
//            XCTAssert(result == "1167", "Result must be 1167, but \(result!) is presented")
//        }
//        
//        
//        func testthreeLeftBrackets() {
//            input.enterUtility(.clear)
//            input.enterUtility(.leftBracket)
//            input.enterUtility(.leftBracket)
//            input.enterUtility(.leftBracket)
//            input.enterNum(3)
//            
//            input.enterUtility(.equal)
//            
//            XCTAssertNotNil(result, "Result cant be nil")
//            XCTAssert(result == "3", "Result must be 3, but \(result!) is presented")
//        }
//        
//        func testthreeRightBrackets() {
//            input.enterUtility(.clear)
//            input.enterUtility(.rightBracket)
//            input.enterUtility(.rightBracket)
//            input.enterUtility(.rightBracket)
//            input.enterNum(3)
//            
//            input.enterUtility(.equal)
//            
//            XCTAssertNotNil(result, "Result cant be nil")
//            XCTAssert(result == "3", "Result must be 3, but \(result!) is presented")
//        }
//        
//
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    
//    override func setUp() {
//        super.setUp()
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//    
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//    }
//    
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//    
}
