// https://github.com/Quick/Quick

import UIKit
import Quick
import Nimble

@testable import Validatr

class UITextField_ValidatableSpec: QuickSpec {
    override func spec() {
        describe("UITextField+Validatable") {
            context("validate") {
                it("asserts every validation rule") {
                    let textField = UITextField()
                    let rules = [
                        ValidationRule.isRequired(),
                        ValidationRule.contains("abc"),
                        ValidationRule.hasMinLength(4)
                    ]
                    textField.text = "abc123"
                    expect(textField.validate(rules)).to(beTrue())
                }

                it("returns false when any rule fails") {
                    let textField = UITextField()
                    let rules = [
                        ValidationRule.isRequired(),
                        ValidationRule.contains("abc"),
                        ValidationRule.hasMinLength(4)
                    ]
                    textField.text = "Should fail on contains"
                    expect(textField.validate(rules)).to(beFalse())
                }
            }
        }
    }
}
