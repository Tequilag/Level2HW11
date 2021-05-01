//
//  Level2HW11Tests.swift
//  Level2HW11Tests
//
//  Created by Andrey Buksha on 26.04.2021.
//

import XCTest
@testable import Level2HW11

enum TestResult {
    
    case success
    case failed
}

class Level2HW11Tests: XCTestCase {
    
   private var viewController = TestController()

    override func setUpWithError() throws {
        
        viewController = TestController()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCredentials() throws {
        
        let examples: [(email: String, password: String, result: TestResult)] = [
            
            ("test@", "Passwd000!", .failed),
            (".@mail.com", "Passwd000!", .success),
            ("mail@.com", "Passwd000!", .failed),
            ("123@212.com", "Passwd000!", .success),
            ("test@gmail.com", "passwd000!", .failed),
            ("test@mail.com", "Pas0!", .failed),
            ("test@mail.com", "Passwd000", .failed),
            ("test@mail.com", "Passwdwqe!", .failed),
            ("test@mail.com", "Passwd000!", .success)
        ]
        
        for example in examples {
            
            viewController.output.emailDidChange(example.email)
            viewController.output.passwordDidChange(example.password)
            viewController.output.signInButtonDidTap()
            XCTAssert(viewController.result == example.result,
                      "Failed:\n - Example: \(example)\n - Result: \(viewController.result as Any)")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

private extension Level2HW11Tests {
    
    class TestController: SigningViewController {
        
        var result: TestResult!
        
        override func openSuccessModule() {
            
            result = .success
        }
        
        override func show(error: Error) {
            
            result = .failed
        }
        
    }
    
}
