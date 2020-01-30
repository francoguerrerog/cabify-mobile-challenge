import Foundation
import RxSwift

protocol DeleteProductsFromCart {
    func execute(product: CartProduct) -> Completable
}

class DeleteProductsFromCartDefault: DeleteProductsFromCart {
    private let cartRepository: CartRepository
    
    init(_ cartRepository: CartRepository) {
        self.cartRepository = cartRepository
    }
    
    func execute(product: CartProduct) -> Completable {
        return cartRepository.find()
            .flatMap{ self.removeProductFromCart($0, product) }
            .flatMapCompletable{ self.saveCart($0) }
    }
    
    private func removeProductFromCart(_ cart: Cart, _ product: CartProduct) -> Single<Cart> {
        cart.removeProduct(product)
        return .just(cart)
    }
    
    private func saveCart(_ cart: Cart) -> Completable {
        cartRepository.put(cart: cart)
        return .empty()
    }
}
