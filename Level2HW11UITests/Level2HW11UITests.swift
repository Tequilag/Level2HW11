//
//  Level2HW11UITests.swift
//  Level2HW11UITests
//
//  Created by Andrey Buksha on 26.04.2021.
//

import XCTest
@testable import Level2HW11

class Level2HW11UITests: XCTestCase {
    
    var app = XCUIApplication()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSignInButtonActivate() throws {
        // UI tests must launch the application that they test.
        
        let emailTextField = app.textFields["emailTextField"]
        let passwordTextField = app.textFields["passwordTextField"]
        let signInButton = app.buttons["signInButton"]
        
        emailTextField.tap()
        emailTextField.typeText("test@mail.com")
        XCTAssert(!signInButton.isEnabled, "кнопка «Войти» становится активной, если поле логина и поле пароля не пустые")
        passwordTextField.tap()
        passwordTextField.typeText("Passwd000!")
        XCTAssert(signInButton.isEnabled, "кнопка «Войти» становится активной, если поле логина и поле пароля не пустые")
    }
    
    func testWrongEmail() throws {
        
        let emailTextField = app.textFields["emailTextField"]
        let passwordTextField = app.textFields["passwordTextField"]
        let signInButton = app.buttons["signInButton"]
        
        emailTextField.tap()
        emailTextField.typeText("!@mail.com")
        passwordTextField.tap()
        passwordTextField.typeText("Passwd000!")
        signInButton.tap()
        XCTAssertTrue(app.alerts["Error"].waitForExistence(timeout: 1))
    }
    
    func testInvalidPassword() {
        
        let emailTextField = app.textFields["emailTextField"]
        let passwordTextField = app.textFields["passwordTextField"]
        let signInButton = app.buttons["signInButton"]
        
        emailTextField.tap()
        emailTextField.typeText("test@mail.com")
        passwordTextField.tap()
        passwordTextField.typeText("Passwd!")
        signInButton.tap()
        XCTAssertTrue(app.alerts["Error"].waitForExistence(timeout: 1))
    }
    
    func testValidCredentials() {
        
        let emailTextField = app.textFields["emailTextField"]
        let passwordTextField = app.textFields["passwordTextField"]
        let signInButton = app.buttons["signInButton"]
        
        emailTextField.tap()
        emailTextField.typeText("test@mail.com")
        passwordTextField.tap()
        passwordTextField.typeText("Passwd000!")
        signInButton.tap()
        XCTAssertTrue(app.alerts["Success"].waitForExistence(timeout: 1))
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
