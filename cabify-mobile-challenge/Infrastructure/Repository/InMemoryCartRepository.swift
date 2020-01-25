import Foundation
import RxSwift

class InMemoryCartRepository: CartRepository {
    
    private var cart: Cart?
    
    func put(cart: Cart) {
        self.cart = cart
    }
    
    func find() -> Single<Cart> {
        guard let cart = self.cart else {
            return .error(DomainError.CartNotFound)
        }
        return .just(cart)
    }
}
