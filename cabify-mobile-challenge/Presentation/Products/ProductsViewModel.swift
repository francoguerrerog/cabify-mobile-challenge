import Foundation
import RxSwift

class ProductsViewModel {

    struct Output {
        let products: Observable<[Product]>
        let loading: Observable<Bool>
        let showAddedToCartAlert: Observable<Void>
    }
    
    public lazy var output = Output(products: productsSubject.asObservable(),
                                    loading: loadingSubject.asObservable(),
                                    showAddedToCartAlert: showAddedToCartAlertSubject.asObservable())
    
    private let productsSubject = BehaviorSubject<[Product]>(value: [])
    private let loadingSubject = PublishSubject<Bool>()
    private let showAddedToCartAlertSubject = PublishSubject<Void>()
    
    private let coordinator: Coordinator
    private let findProducts: FindProducts
    private let addProductToCart: AddProductToCart
    
    private let disposeBag = DisposeBag()
    
    init(_ coordinator: Coordinator,
         _ findProducts: FindProducts,
         _ addProductToCart: AddProductToCart) {
        self.coordinator = coordinator
        self.findProducts = findProducts
        self.addProductToCart = addProductToCart
    }
    
    private func emitProducts(products: Products) {
        productsSubject.onNext(products.products)
    }
    
    private func productAtIndex(_ products: [Product], _ index: Int) -> Product? {
        if index >= 0 && index < products.count {
            return products[index]
        }
        return nil
    }
    
    private func addProductToCart(_ product: Product, _ quantity: Int) {
        let cartProduct = CartProduct(product: product, quantity: quantity)
        addProductToCart.execute(product: cartProduct)
            .subscribe(onCompleted: { [weak self] in
                self?.showAddedToCartAlertSubject.onNext(())
            })
            .disposed(by: disposeBag)
    }
}

extension ProductsViewModel {
    func viewDidLoad() {
        loadingSubject.onNext(true)
        findProducts.execute()
            .subscribe(onSuccess: { [weak self] (products) in
                self?.emitProducts(products: products)
                self?.loadingSubject.onNext(false)
            }, onError: { [weak self] _ in
                self?.loadingSubject.onNext(false)
            }).disposed(by: disposeBag)
    }
    
    func selectProduct(_ index: Int, _ quantity: Int) {
        output.products
            .take(1)
            .subscribe(onNext: { [weak self] (products) in
                guard let product = self?.productAtIndex(products, index) else { return }
                self?.addProductToCart(product, quantity)
            }).disposed(by: disposeBag)
    }
    
    func selectContinueButton() {
        coordinator.goToCart()
    }
}
