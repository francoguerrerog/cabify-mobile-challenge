import Foundation
import RxSwift

protocol CartRepository {
    func put(cart: Cart)
    func find() -> Single<Cart>
}
