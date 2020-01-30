import XCTest
import RxSwift
import SwiftyMocky
import RxBlocking

@testable import cabify_mobile_challenge

class DeleteProductsFromCartTests: XCTestCase {
    
    private var deleteProductsFromCart: DeleteProductsFromCartDefault!
    private let cartRepository = CartRepositoryMock()
    private let product = CartFactoryTests.createCartProduct()
    private var result: MaterializedSequenceResult<Never>!
    
    func test_deleteProducts() {
        givenAnAction()
        
        whenExecute()
        
        thenUpdateCartRepository()
    }
    
    private func givenAnAction() {
        Given(cartRepository, .find(willReturn: .just(CartFactoryTests.createCartWithMultiple2for1Conditions())))
        deleteProductsFromCart = DeleteProductsFromCartDefault(cartRepository)
    }
    
    private func whenExecute() {
        result = deleteProductsFromCart.execute(product: product).toBlocking().materialize()
    }
    
    private func thenUpdateCartRepository() {
        switch result {
        case .completed:
            Verify(cartRepository, .once, .find())
            Verify(cartRepository, .once, .put(cart: .any))
        default:
            XCTFail()
        }
    }
}
