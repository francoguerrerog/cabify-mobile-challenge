import Foundation

class CreateCartDefault {
    private let cartRepository: CartRepository
    
    init(_ cartRepository: CartRepository) {
        self.cartRepository = cartRepository
    }
    
    func execute(_ cart: Cart) {
        cartRepository.put(cart: cart)
    }
}
