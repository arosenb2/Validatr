// https://github.com/Quick/Quick

import UIKit
import Quick
import Nimble

@testable import Validatr

class ValidatableTextFieldSpec: QuickSpec {
    override func spec() {
        describe("ValidatrTextField") {
            context("validate") {
                it("uses the rules defined in the class for validation") {
                    let textField = ValidatrTextField()
                    textField.rules = [ValidationRule.isRequired()]
                    textField.text = "abc"
                    expect(textField.validate()).to(beTrue())
                    expect(textField.getValidRules()).to(haveCount(textField.rules.count))
                    expect(textField.getInvalidRules()).to(haveCount(0))
                }

                it("returns true when there aren't any rules to validate") {
                    let textField = ValidatrTextField()
                    expect(textField.validate()).to(beTrue())
                    expect(textField.getValidRules()).to(haveCount(0))
                    expect(textField.getInvalidRules()).to(haveCount(0))
                }
            }

            context("getValidRules") {
                it("returns an empty array when there aren't any valid rules") {
                    let textField = ValidatrTextField()
                    textField.rules = [ValidationRule.isRequired()]
                    expect(textField.getValidRules()).to(haveCount(0))
                }

                it("returns an array of only the validated rules") {
                    let isRequiredRule = ValidationRule.isRequired()
                    let containsNumberRule = ValidationRule.containsNumber()
                    let maxLengthRule = ValidationRule.hasMaxLength(5)

                    let textField = ValidatrTextField()
                    textField.rules = [
                        isRequiredRule,
                        containsNumberRule,
                        maxLengthRule
                    ]
                    textField.text = "test"

                    let validRules = textField.getValidRules()
                    expect(validRules).to(haveCount(2))
                    expect(validRules).to(contain(isRequiredRule))
                    expect(validRules).to(contain(maxLengthRule))
                    expect(validRules).notTo(contain(containsNumberRule))
                }
            }

            context("getInvalidRules") {
                it("returns an empty array when there aren't any invalid rules") {
                    let textField = ValidatrTextField()
                    textField.rules = [ValidationRule.isRequired()]
                    expect(textField.getValidRules()).to(haveCount(0))
                }

                it("returns an array of only the invalid rules") {
                    let isRequiredRule = ValidationRule.isRequired()
                    let containsNumberRule = ValidationRule.containsNumber()
                    let maxLengthRule = ValidationRule.hasMaxLength(5)

                    let textField = ValidatrTextField()
                    textField.rules = [
                        isRequiredRule,
                        containsNumberRule,
                        maxLengthRule
                    ]
                    textField.text = "test"

                    let invalidRules = textField.getInvalidRules()
                    expect(invalidRules).to(haveCount(1))
                    expect(invalidRules).to(contain(containsNumberRule))
                    expect(invalidRules).notTo(contain(isRequiredRule))
                    expect(invalidRules).notTo(contain(maxLengthRule))
                }
            }

            context("getValidationErrors") {
                it("returns an empty array when there aren't any invalid rules") {
                    let textField = ValidatrTextField()
                    textField.rules = [ValidationRule.isRequired()]

                    textField.text = "abc"
                    expect(textField.getValidationErrors()).to(equal([]))
                }

                it("returns an array of validation errors when validation rules fail") {
                    let requiredRule = ValidationRule.isRequired()
                    let textField = ValidatrTextField()
                    textField.rules = [requiredRule]
                    expect(textField.getValidationErrors()).to(equal([requiredRule.errorText]))
                }

                it("uses the custom error message for failed validation when one is provided") {
                    let customError = "required field"
                    let requiredRule = ValidationRule.isRequired()
                    let customRequiredRule = ValidationRule.isRequired(customError)
                    let textField = ValidatrTextField()
                    textField.rules = [requiredRule, customRequiredRule]
                    expect(textField.getValidationErrors()).to(equal([requiredRule.errorText, customError]))
                }

                it("returns error messages in the order in which they were evaluated") {
                    let textField = ValidatrTextField()
                    textField.rules = [
                        ValidationRule.isRequired("1"),
                        ValidationRule.isRequired("2"),
                        ValidationRule.isRequired("3")
                    ]
                    expect(textField.getValidationErrors()).to(equal(["1", "2", "3"]))
                }
            }
        }
    }
}
