//
//  UITextField+Validation.swift
//  Validatr
//
//  Created by Aaron Rosenbaum on 9/15/19.
//  Copyright © 2019 arosenb2. All rights reserved.
//

import Foundation
import UIKit

protocol Validatable {
    associatedtype T

    func validate(_ functions: [T]) -> Bool
    func getValidRules(_ rules: [T]) -> [T]
    func getInvalidRules(_ rules: [T]) -> [T]
    func getValidationErrors(_ rules: [T]) -> [String]
}

extension UITextField: Validatable {
    func validate(_ rules: [ValidationRule]) -> Bool {
        return rules.map { rule in rule.validate(self.text) }.reduce(true) { $0 && $1 }
    }

    func getValidRules(_ rules: [ValidationRule]) -> [ValidationRule] {
        return rules.filter { rule in rule.validate(self.text) }
    }

    func getInvalidRules(_ rules: [ValidationRule]) -> [ValidationRule] {
        return rules.filter { rule in !rule.validate(self.text) }
    }

    func getValidationErrors(_ rules: [ValidationRule]) -> [String] {
        return rules.filter { rule in !rule.validate(self.text) }.map { rule in rule.errorText }
    }
}
