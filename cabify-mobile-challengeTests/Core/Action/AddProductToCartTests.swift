import XCTest
import RxSwift
import RxBlocking
import SwiftyMocky

@testable import cabify_mobile_challenge

class AddProductToCartTests: XCTestCase {
    private let voucher = Product(code: "VOUCHER", name: "Cabify Voucher", price: Price(amount: 5.00, currency: .Euro))
    private let cartRepository = CartRepositoryMock()
    private var addProductToCart: AddProductToCart!
    
    func test_addProductToCart() {
        givenAnAction()
        
        whenExecute()
        
        thenFindCart()
    }
    
    private func givenAnAction() {
        Given(cartRepository, .find(willReturn: .just(Cart())))
        addProductToCart = AddProductToCartDefault(cartRepository)
    }
    
    private func whenExecute() {
        _ = addProductToCart.execute(product: CartProduct(product: voucher, quantity: 1)).toBlocking().materialize()
    }
    
    private func thenFindCart() {
        Verify(cartRepository, .once, .find())
    }

}
