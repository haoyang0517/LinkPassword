//
//  DI.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 26/02/2024.
//

import Foundation
import Swinject
import UIKit
import SwifterSwift

struct DI {
    static let container = Container()
    static let resolver = container.synchronize()
}


extension UIStoryboard {
    func instantiateViewController<T>(withIdentifier identifier: String) -> T {
        return self.instantiateViewController(withIdentifier: identifier) as! T
    }
}

extension DI {
    static func registerViewController<T>(storyboard: UIStoryboard, type:T.Type, identifier: String) {
        DI.container.register(T.self) { r -> T in
            return storyboard.instantiateViewController(withIdentifier: identifier)
        }
    }
}

protocol DIRegistor {
    static func register()
}
protocol DIModuleRegistor {
    static func registerView()
    static func registerViewModel()
}
extension DIModuleRegistor {
    static func register() {
        registerViewModel()
        registerView()
    }
}

@propertyWrapper
struct Injected<Service> {
    var service: Service?
    var container: Resolver = DI.resolver
    //public var name: String?
    var wrappedValue: Service {
        mutating get {
            if service == nil {
                service = container.resolve(Service.self)
            }
            return service!
        }
        mutating set {
            service = newValue
        }
    }
}
