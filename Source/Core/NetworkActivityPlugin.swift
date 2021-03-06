//
//  NetworkActivityPlugin.swift
//  Hint
//
//  Created by Denys Telezhkin on 20.01.16.
//  Copyright © 2015 - present MLSDev. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import UIKit

/**
 Plugin, that monitors sent api requests, and automatically sets UIApplication networkActivityIndicatorVisible property.
 
 - Note: this plugin should be used globally by `TRON` instance. It also assumes, that you have only one `TRON` in your application.
 */
public class NetworkActivityPlugin : Plugin {
    
    /**
     Network activity count, based on sent `APIRequests`.
     */
    static var networkActivityCount = 0 {
        didSet {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = networkActivityCount > 0
        }
    }
    
    public init() {}
    
    public func willSendRequest(request: NSURLRequest?) {
        self.dynamicType.networkActivityCount++
    }
    
    public func requestDidReceiveResponse(response: (NSURLRequest?, NSHTTPURLResponse?, NSData?, NSError?)) {
        self.dynamicType.networkActivityCount--
    }
}