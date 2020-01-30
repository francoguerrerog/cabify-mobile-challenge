import Foundation

class Tshirt3OrMoreCondition: DiscountCondition {
    
    private let TSHIRT_CODE = "TSHIRT"
    private let DISCOUNT_NAME = "3 or more tshirts"
    private let PRICE_WHEN_DISCOUNT = 19.0
    
    func evaluate(_ cart: Cart) -> Discount? {
        let products = cart.products.filter{ $0.product.code == TSHIRT_CODE }
        guard let tshirts = products.first else { return nil }
        guard tshirts.quantity > 2 else { return nil }
        
        let discountPrice = getDiscountPrice(tshirts)
        
        return Discount(name: DISCOUNT_NAME, price: discountPrice)
    }
    
    private func getDiscountPrice(_ tshirts: CartProduct) -> Price {
        let unitDiscountAmount = tshirts.product.price.amount - PRICE_WHEN_DISCOUNT
        let discountAmount = unitDiscountAmount * Double(tshirts.quantity)
        return Price(amount: discountAmount, currency: tshirts.product.price.currency)
    }
}
