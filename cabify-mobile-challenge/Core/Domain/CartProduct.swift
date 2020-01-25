import Foundation

class CartProduct {
    let product: Product
    private(set) var quantity: Int
    
    init(product: Product, quantity: Int) {
        self.product = product
        self.quantity = quantity
    }
    
    func addQuantity(_ quantity: Int) {
        self.quantity += quantity
    }
}
