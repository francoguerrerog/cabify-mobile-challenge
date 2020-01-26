import XCTest
import RxSwift
import RxBlocking
import SwiftyMocky

@testable import cabify_mobile_challenge

class DiscountsServiceTests: XCTestCase {
    
    private let firstDiscount = Discount(name: "2-for-1 Voucher", price: Price(amount: 5.00, currency: .Euro))
    private let secondDiscount = Discount(name: "3 or more tshirts", price: Price(amount: 3.00, currency: .Euro))
    private let firstCondition = DiscountConditionMock()
    private let secondCondition = DiscountConditionMock()
    private let thirdCondition = DiscountConditionMock()
    private var discountsService: DiscountsServiceDefault!
    private var result: MaterializedSequenceResult<Cart>!
    
    func test_evaluateConditions() {
        givenAService()
        
        whenApplyDiscounts()
        
        thenEvaluateConditions()
    }
    
    func test_dontGetDiscounts() {
        givenAService()
        
        whenApplyDiscounts()
        
        thenDontGetDiscounts()
    }
    
    func test_getADiscount() {
        Given(firstCondition, .evaluate(.any, willReturn: firstDiscount))
        givenAService()
        
        whenApplyDiscounts()
        
        thenGetADiscount()
    }
    
    func test_getMultipleDiscounts() {
        Given(firstCondition, .evaluate(.any, willReturn: firstDiscount))
        Given(secondCondition, .evaluate(.any, willReturn: secondDiscount))
        givenAService()
        
        whenApplyDiscounts()
        
        thenGetMultipleDiscounts()
    }

    private func givenAService() {
        discountsService = DiscountsServiceDefault([firstCondition, secondCondition, thirdCondition])
    }
    
    private func whenApplyDiscounts() {
        result = discountsService.applyDiscountsToCart(Cart()).toBlocking().materialize()
    }
    
    private func thenEvaluateConditions() {
        Verify(firstCondition, .once, .evaluate(.any))
        Verify(secondCondition, .once, .evaluate(.any))
        Verify(thirdCondition, .once, .evaluate(.any))
    }
    
    private func thenDontGetDiscounts() {
        switch result {
        case .completed(let elements):
            XCTAssertEqual(elements.count, 1)
            XCTAssertEqual(elements.first!.discounts.count, 0)
        default:
            XCTFail()
        }
    }
    
    private func thenGetADiscount() {
        switch result {
        case .completed(let elements):
            XCTAssertEqual(elements.count, 1)
            XCTAssertEqual(elements.first!.discounts.count, 1)
            XCTAssertEqual(elements.first!.discounts.first?.name, firstDiscount.name)
        default:
            XCTFail()
        }
    }
    
    private func thenGetMultipleDiscounts() {
        switch result {
        case .completed(let elements):
            XCTAssertEqual(elements.count, 1)
            XCTAssertEqual(elements.first!.discounts.count, 2)
            XCTAssertEqual(elements.first!.discounts[0].name, firstDiscount.name)
            XCTAssertEqual(elements.first!.discounts[1].name, secondDiscount.name)
        default:
            XCTFail()
        }
    }
}
