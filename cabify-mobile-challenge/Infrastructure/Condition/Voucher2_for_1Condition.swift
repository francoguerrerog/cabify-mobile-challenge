import Foundation

class Voucher2_for_1Condition: DiscountCondition {
    
    private let VOUCHER_CODE = "VOUCHER"
    private let DISCOUNT_NAME = "2-for-1 Voucher"
    
    func evaluate(_ cart: Cart) -> Discount? {
        let products = cart.getProducts().filter{ $0.product.code == VOUCHER_CODE }
        guard let vouchers = products.first else { return nil }
        guard vouchers.quantity > 1 else { return nil }
        
        let discountPrice = getDiscountPrice(vouchers)
        
        return Discount(name: DISCOUNT_NAME, price: discountPrice)
    }
    
    private func getDiscountPrice(_ vouchers: CartProduct) -> Price {
        let conditionTimes = vouchers.quantity / 2
        let discountAmount = vouchers.product.price.amount * Double(conditionTimes)
        return Price(amount: discountAmount, currency: vouchers.product.price.currency)
    }
}
