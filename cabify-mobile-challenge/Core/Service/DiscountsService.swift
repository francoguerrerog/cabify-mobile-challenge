import Foundation
import RxSwift

protocol DiscountsService {
    func applyDiscountsToCart(_ cart: Cart) -> Single<Cart>
}

class DiscountsServiceDefault: DiscountsService {
    private let conditions: [DiscountCondition]
    
    init(_ conditions: [DiscountCondition]) {
        self.conditions = conditions
    }
    
    func applyDiscountsToCart(_ cart: Cart) -> Single<Cart> {
        let discounts = conditions.compactMap{ $0.evaluate(cart) }
        let cartWithDiscounts = cart
        cartWithDiscounts.discounts = discounts
        return .just(cartWithDiscounts)
    }
}
