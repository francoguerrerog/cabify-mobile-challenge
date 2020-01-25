import XCTest
import RxSwift
import RxBlocking
import SwiftyMocky

@testable import cabify_mobile_challenge

class GetCartWithDiscountsTests: XCTestCase {
    
    private let cartRepository = CartRepositoryMock()
    private let discountsService = DiscountsServiceMock()
    private var getCartWithDiscounts: GetCartWithDiscounts!
    private var result: MaterializedSequenceResult<Cart>!
    
    func test_findCartRepository() {
        givenAnAction()
        
        whenExecute()
        
        thenFindCart()
    }
    
    func test_applyDiscounts() {
        givenAnAction()
        
        whenExecute()
        
        thenApplyDiscounts()
    }
    
    func test_updateCartWithDiscounts() {
        givenAnAction()
        
        whenExecute()
        
        Verify(cartRepository, .once, .put(cart: .any))
    }

    private func givenAnAction() {
        Given(discountsService, .applyDiscountsToCart(.any, willReturn: .just(Cart())))
        Given(cartRepository, .find(willReturn: .just(Cart())))
        getCartWithDiscounts = GetCartWithDiscountsDefault(cartRepository, discountsService)
    }
    
    private func whenExecute() {
        result = getCartWithDiscounts.execute().toBlocking().materialize()
    }
    
    private func thenFindCart() {
        Verify(cartRepository, .once, .find())
    }
    
    private func thenApplyDiscounts() {
        Verify(discountsService, .once, .applyDiscountsToCart(.any))
    }
}
