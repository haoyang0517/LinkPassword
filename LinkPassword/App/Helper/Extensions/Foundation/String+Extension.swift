//
//  String+Extension.swift
//  LinkPassword
//
//  Created by Hao Yang Yip on 29/02/2024.
//

import Foundation

extension String {
    public var isEmail: Bool {
        let emailRegex = try? NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)

        let range = NSRange(location: 0, length: count)
        let matches = emailRegex?.matches(in: self, options: [], range: range)

        return matches?.count ?? 0 > 0
    }

}
