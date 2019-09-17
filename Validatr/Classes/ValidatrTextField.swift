//
//  ValidatrTextField.swift
//  Validatr
//
//  Created by Aaron Rosenbaum on 9/15/19.
//  Copyright © 2019 arosenb2. All rights reserved.
//

import Foundation
import UIKit

class ValidatrTextField: UITextField {
    var rules: [ValidationRule] = []

    func validate() -> Bool {
        return validate(rules)
    }

    func getValidRules() -> [ValidationRule] {
        return getValidRules(rules)
    }

    func getInvalidRules() -> [ValidationRule] {
        return getInvalidRules(rules)
    }

    func getValidationErrors() -> [String] {
        return getValidationErrors(rules)
    }
}
