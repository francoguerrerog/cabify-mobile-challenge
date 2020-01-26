import Foundation
import RxSwift

protocol ProductsService {
    func find() -> Single<Products>
}
