import Foundation
import RxSwift

protocol AddProductToCart {
    func execute(product: CartProduct) -> Completable
}

class AddProductToCartDefault: AddProductToCart {
    private let cartRepository: CartRepository
    init(_ cartRepository: CartRepository) {
        self.cartRepository = cartRepository
    }
    
    func execute(product: CartProduct) -> Completable {
        return cartRepository.find()
            .flatMapCompletable{ self.addProduct($0, product) }
    }
    
    private func addProduct(_ cart: Cart, _ product: CartProduct) -> Completable {
        cart.addProduct(product)
        return .empty()
    }
}
