import Foundation
import RxSwift

class CartViewModel {
    
    struct Output {
        let products: Observable<[CartProduct]>
        let discounts: Observable<[Discount]>
        let showAddedToCartAlert: Observable<Void>
    }
    
    public lazy var output = Output(products: productsSubject.asObservable(),
                                    discounts: discountsSubject.asObservable(),
                                    showAddedToCartAlert: showAddedToCartAlertSubject.asObservable())
    
    private let productsSubject = BehaviorSubject<[CartProduct]>(value: [])
    private let discountsSubject = BehaviorSubject<[Discount]>(value: [])
    private let showAddedToCartAlertSubject = PublishSubject<Void>()
    
    private let getCartWithDiscounts: GetCartWithDiscounts
    
    private let disposeBag = DisposeBag()
    
    init(_ getCartWithDiscounts: GetCartWithDiscounts) {
        self.getCartWithDiscounts = getCartWithDiscounts
    }
    
    private func emitProducts(_ cart: Cart) {
        productsSubject.onNext(cart.getProducts())
    }
    
    private func emitDiscounts(_ cart: Cart) {
        discountsSubject.onNext(cart.discounts)
    }
}

extension CartViewModel {
    func viewDidLoad() {
        getCartWithDiscounts.execute()
            .subscribe(onSuccess: { [weak self] cart in
                self?.emitProducts(cart)
                self?.emitDiscounts(cart)
            }).disposed(by: disposeBag)
    }
}
