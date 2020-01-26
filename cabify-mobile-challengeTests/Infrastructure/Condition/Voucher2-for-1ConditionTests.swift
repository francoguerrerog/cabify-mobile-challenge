import XCTest

@testable import cabify_mobile_challenge

class Voucher2_for_1ConditionTests: XCTestCase {
    
    private let emptyCart = CartFactoryTests.createEmptyCart()
    private let cartWithDiscount = CartFactoryTests.createCartWith2for1Condition()
    private let cartWithMultipleDiscounts = CartFactoryTests.createCartWithMultiple2for1Conditions()
    private var condition: Voucher2_for_1Condition!
    private var discount: Discount! = nil
    
    func test_emptyCart() {
        givenACondition()
        
        whenEvaluateCart(emptyCart)
        
        thenReturnNoDiscount()
    }
    
    func test_applyDiscount() {
        givenACondition()
        
        whenEvaluateCart(cartWithDiscount)
        
        thenApplyDiscount()
    }
    
    func test_applyMultipleDiscounts() {
        givenACondition()
        
        whenEvaluateCart(cartWithMultipleDiscounts)
        
        thenApplyMultipleDiscounts()
    }
    
    private func givenACondition() {
        condition = Voucher2_for_1Condition()
    }
    
    private func whenEvaluateCart(_ cart: Cart) {
        discount = condition.evaluate(cart)
    }
    
    private func thenReturnNoDiscount() {
        XCTAssertNil(discount)
    }
    
    private func thenApplyDiscount() {
        XCTAssertEqual(discount.name, "2-for-1 Voucher")
        XCTAssertEqual(discount.price.amount, 5.00)
    }
    
    private func thenApplyMultipleDiscounts() {
        XCTAssertEqual(discount.name, "2-for-1 Voucher")
        XCTAssertEqual(discount.price.amount, 10.00)
    }
}

