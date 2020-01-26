import Foundation

protocol DiscountCondition {
    func evaluate(_ cart: Cart) -> Discount?
}
