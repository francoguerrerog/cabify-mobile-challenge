import Foundation
import RxSwift

protocol GetCartWithDiscounts {
    func execute() -> Single<Cart>
}

class GetCartWithDiscountsDefault: GetCartWithDiscounts {
    private let cartRepository: CartRepository
    private let discountsService: DiscountsService
    
    init(_ cartRepository: CartRepository, _ discountsService: DiscountsService) {
        self.cartRepository = cartRepository
        self.discountsService = discountsService
    }
    
    func execute() -> Single<Cart> {
        return cartRepository.find()
            .flatMap{ self.discountsService.applyDiscountsToCart($0) }
            .flatMap{ self.updateCartRepository($0)}
    }
    
    private func updateCartRepository(_ cart: Cart) -> Single<Cart> {
        cartRepository.put(cart: cart)
        return .just(cart)
    }
}
