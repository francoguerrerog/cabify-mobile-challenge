import Foundation
import RxSwift

protocol Checkout {
    func execute() -> Completable
}

class CheckoutDefault: Checkout {
    private let cartRepository: CartRepository
    
    init(_ cartRepository: CartRepository) {
        self.cartRepository = cartRepository
    }
    
    func execute() -> Completable {
        cartRepository.put(cart: Cart())
        return .empty()
    }
}
