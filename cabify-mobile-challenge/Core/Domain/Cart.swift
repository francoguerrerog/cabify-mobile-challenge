import Foundation

class Cart {
    private var products: [CartProduct] = []
    var discounts: [Discount] = []
    
    func addProduct(_ product: CartProduct) {
        
        guard let indexProduct = products.firstIndex(where: { (cartProduct) -> Bool in
            cartProduct.product.code == product.product.code
        }) else {
            return products.append(product)
        }
        
        products[indexProduct].addQuantity(product.quantity)
    }
    
    func getProducts() -> [CartProduct] {
        return products
    }
}
