//
//  PluginTestCase.swift
//  TRON
//
//  Created by Denys Telezhkin on 30.01.16.
//  Copyright © 2016 Denys Telezhkin. All rights reserved.
//

import XCTest
import TRON
import Nimble

class PluginTestCase: XCTestCase {
    
    func testGlobalPluginsAreCalledCorrectly() {
        let pluginTester = PluginTester()
        let tron = TRON(baseURL: "http://httpbin.org", plugins: [pluginTester])
        let request : APIRequest<Int,Int> = tron.request(path: "status/200")
        
        request.performWithSuccess({_ in })
        
        expect(pluginTester.didReceiveResponseCalled).toEventually(equal(true))
        expect(pluginTester.willSendCalled).toEventually(equal(true))
    }
    
    func testLocalPluginsAreCalledCorrectly() {
        let pluginTester = PluginTester()
        let tron = TRON(baseURL: "http://httpbin.org")
        let request: APIRequest<String,Int> = tron.request(path: "status/200")
        let expectation = expectationWithDescription("PluginTester expectation")
        request.plugins.append(pluginTester)
        request.performWithSuccess({ _ in
            if pluginTester.didReceiveResponseCalled && pluginTester.willSendCalled {
                expectation.fulfill()
            }
        }, failure: { error in
            if pluginTester.didReceiveResponseCalled && pluginTester.willSendCalled {
                expectation.fulfill()
            }
        })
        
        waitForExpectationsWithTimeout(10, handler: nil)
    }
    
}
