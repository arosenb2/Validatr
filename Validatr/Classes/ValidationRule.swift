//
//  Validatr.swift
//  Validatr
//
//  Created by Aaron Rosenbaum on 9/15/19.
//  Copyright © 2019 arosenb2. All rights reserved.
//

import Foundation

struct ValidationRule: Equatable {
    private var fn: (String) -> Bool

    private let comparisonIdentifier: String = UUID.init().uuidString
    static func == (lhs: ValidationRule, rhs: ValidationRule) -> Bool {
        return lhs.comparisonIdentifier == rhs.comparisonIdentifier
    }

    var errorText: String = "field is invalid"

    func validate(_ text: String?) -> Bool {
        return fn(text ?? "")
    }

    static func isRequired(_ errorText: String = "field is required") -> ValidationRule {
        return hasMinLength(1, errorText)
    }

    static func hasMinLength(_ length: Int) -> ValidationRule {
        return hasMinLength(length, "field requires min length of \(length)")
    }

    static func hasMinLength(_ length: Int, _ errorText: String) -> ValidationRule {
        return ValidationRule(fn: { text in text.count >= length }, errorText: errorText)
    }

    static func hasMaxLength(_ length: Int) -> ValidationRule {
        return hasMaxLength(length, "field requires max length of \(length)")
    }

    static func hasMaxLength(_ length: Int, _ errorText: String) -> ValidationRule {
        return ValidationRule(fn: { text in text.count <= length }, errorText: errorText)
    }

    static func contains(_ text: String) -> ValidationRule {
        return contains(text, "field must contain '\(text)'")
    }

    static func contains(_ text: String, _ errorText: String) -> ValidationRule {
        return ValidationRule(fn: { given in given.contains(text) }, errorText: errorText)
    }

    static func containsUppercase(_ errorText: String = "field must contain uppercase value") -> ValidationRule {
        return try! matches(expression: #"[A-Z]+"#, options: [], errorText: errorText)
    }

    static func containsLowercase(_ errorText: String = "field must contain lowercase value") -> ValidationRule {
        return try! matches(expression: #"[a-z]+"#, options: [], errorText: errorText)
    }

    static func containsNumber(_ errorText: String = "field must contain number value") -> ValidationRule {
        return try! matches(expression: #"\d+"#, errorText: errorText)
    }

    static func matches(expression: String, options: NSRegularExpression.Options = [.caseInsensitive], errorText: String = "field does not match expression") throws -> ValidationRule {
        let regex = try NSRegularExpression(pattern: expression, options: options)

        return matches(expression: regex, options: options, errorText: errorText)
    }

    static func matches(expression regex: NSRegularExpression, options: NSRegularExpression.Options = [.caseInsensitive], errorText: String = "field does not match expression") -> ValidationRule {
        return ValidationRule(fn: { text in
            regex.firstMatch(in: text, options: [], range: NSRange(location: 0, length: text.count)) != nil
        }, errorText: errorText)
    }
}
