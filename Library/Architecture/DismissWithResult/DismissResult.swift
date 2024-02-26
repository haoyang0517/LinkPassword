//
//  DismissResult.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 26/02/2024.
//

import Foundation

class DismissResult: NSObject {
    var result: Any?
    var identifier: Any?
    
    init(result: Any?, identifier: Any?) {
        self.result = result
        self.identifier = identifier
    }
    
    static var none: DismissResult {
        return DismissResult(result: nil, identifier: nil)
    }
}
