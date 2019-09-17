// https://github.com/Quick/Quick

import Quick
import Nimble

@testable import Validatr

class ValidationRuleSpec: QuickSpec {
    override func spec() {
        describe("ValidationRule") {
            context("isRequired") {
                it("returns false for empty text values") {
                    let rule = ValidationRule.isRequired()
                    expect(rule.validate("")).to(beFalse())
                }

                it("returns true for text that has a non-empty value") {
                    let rule = ValidationRule.isRequired()
                    expect(rule.validate("a")).to(beTrue())
                }
            }

            context("hasMinLength") {
                it("returns true when the text has at least the minimum length") {
                    let rule = ValidationRule.hasMinLength(1)
                    expect(rule.validate("a")).to(beTrue())
                }

                it("returns false when the text doesn't have at least the minimum length") {
                    let rule = ValidationRule.hasMinLength(2)
                    expect(rule.validate("a")).to(beFalse())
                }
            }

            context("hasMaxLength") {
                it("returns true when the text has less than the max length") {
                    let rule = ValidationRule.hasMaxLength(5)
                    expect(rule.validate("a")).to(beTrue())
                }

                it("returns false when the text has more than the max length") {
                    let rule = ValidationRule.hasMaxLength(5)
                    expect(rule.validate("Too Long")).to(beFalse())
                }
            }

            context("contains") {
                it("returns true when the text contains the given phase") {
                    let rule = ValidationRule.contains("test")
                    expect(rule.validate("test should pass")).to(beTrue())
                }

                it("returns false when the text doesn't contain the given phrase") {
                    let rule = ValidationRule.contains("test")
                    expect(rule.validate("won't pass")).to(beFalse())
                }
            }

            context("containsUppercase") {
                it("returns true when the text contains a capital letter") {
                    let rule = ValidationRule.containsUppercase()
                    expect(rule.validate("Abc")).to(beTrue())
                }

                it("returns false when the text doesn't contain a capital letter") {
                    let rule = ValidationRule.containsUppercase()
                    expect(rule.validate("abc")).to(beFalse())
                }
            }

            context("containsLowercase") {
                it("returns true when the text contains a lowercase letter") {
                    let rule = ValidationRule.containsLowercase()
                    expect(rule.validate("abc")).to(beTrue())
                }

                it("returns false when the field doesn't contain a lowercase letter") {
                    let rule = ValidationRule.containsLowercase()
                    expect(rule.validate("ABC")).to(beFalse())
                }
            }

            context("containsNumber") {
                it("returns true when the text contains a number") {
                    let rule = ValidationRule.containsNumber()
                    expect(rule.validate("abc123")).to(beTrue())
                }

                it("returns false when the text doesn't contain a number") {
                    let rule = ValidationRule.containsNumber()
                    expect(rule.validate("abc")).to(beFalse())
                }
            }

            context("matches") {
                it("returns true when the text matches the regular expression") {
                    let rule = try! ValidationRule.matches(expression: "\\d+")
                    expect(rule.validate("abc123")).to(beTrue())
                }

                it("returns false when the text doesn't match the regular expression") {
                    let rule = try! ValidationRule.matches(expression: "\\d+")
                    expect(rule.validate("abc")).to(beFalse())
                }
            }
        }
    }
}
