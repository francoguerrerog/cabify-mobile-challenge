import XCTest

@testable import cabify_mobile_challenge

class Tshirt3OrMoreConditionTests: XCTestCase {
    
    private let emptyCart = CartFactoryTests.createEmptyCart()
    private let twoTshirts = CartFactoryTests.createCartWith2Thirts()
    private let fourTshirts = CartFactoryTests.createCartWith4Thirts()
    private var condition: Tshirt3OrMoreCondition!
    private var discount: Discount! = nil
    
    func test_emptyCart() {
        givenACondition()
        
        whenEvaluateCart(emptyCart)
        
        thenReturnNoDiscount()
    }
    
    func test_notApplyDiscountWhenTwoTshirts() {
        givenACondition()
        
        whenEvaluateCart(twoTshirts)
        
        thenReturnNoDiscount()
    }
    
    func test_ApplyDiscountWhenFourTshirts() {
        givenACondition()
        
        whenEvaluateCart(fourTshirts)
        
        XCTAssertEqual(discount.name, "3 or more tshirts")
        XCTAssertEqual(discount.price.amount, 4.00)
    }
    
    private func givenACondition() {
        condition = Tshirt3OrMoreCondition()
    }
    
    private func whenEvaluateCart(_ cart: Cart) {
        discount = condition.evaluate(cart)
    }
    
    private func thenReturnNoDiscount() {
        XCTAssertNil(discount)
    }
}
