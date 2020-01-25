import Foundation
import RxSwift

protocol DiscountsService {
    func applyDiscountsToCart(_ cart: Cart) -> Single<Cart>
}
