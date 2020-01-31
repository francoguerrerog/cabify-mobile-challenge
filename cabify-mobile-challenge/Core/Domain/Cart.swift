import Foundation

class Cart {
    private(set) var products: [CartProduct] = []
    var discounts: [Discount] = []
    
    func addProduct(_ product: CartProduct) {
        
        guard let indexProduct = products.firstIndex(where: { (cartProduct) -> Bool in
            cartProduct.product.code == product.product.code
        }) else {
            return products.append(product)
        }
        
        products[indexProduct].addQuantity(product.quantity)
    }
    
    func removeProduct(_ product: CartProduct) {
        products = products.filter{ $0.product.code != product.product.code }
    }
}
