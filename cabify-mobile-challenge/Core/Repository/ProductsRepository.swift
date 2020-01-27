import Foundation
import RxSwift

protocol ProductsRepository {
    func put(_ products: Products)
    func find() -> Single<Products>
}
