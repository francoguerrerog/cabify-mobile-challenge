import Foundation
import RxSwift

class CartViewModel {
    
    struct Output {
        let products: Observable<[CartProduct]>
        let discounts: Observable<[Discount]>
        let totals: Observable<[Total]>
        let showAddedToCartAlert: Observable<Void>
    }
    
    public lazy var output = Output(products: productsSubject.asObservable(),
                                    discounts: discountsSubject.asObservable(),
                                    totals: totalsSubject.asObservable(),
                                    showAddedToCartAlert: showAddedToCartAlertSubject.asObservable())
    
    private let productsSubject = BehaviorSubject<[CartProduct]>(value: [])
    private let discountsSubject = BehaviorSubject<[Discount]>(value: [])
    private let totalsSubject = BehaviorSubject<[Total]>(value: [])
    private let showAddedToCartAlertSubject = PublishSubject<Void>()
    
    private let getCartWithDiscounts: GetCartWithDiscounts
    private let deleteProductsFromCart: DeleteProductsFromCart
    
    private let disposeBag = DisposeBag()
    
    init(_ getCartWithDiscounts: GetCartWithDiscounts, _ deleteProductsFromCart: DeleteProductsFromCart) {
        self.getCartWithDiscounts = getCartWithDiscounts
        self.deleteProductsFromCart = deleteProductsFromCart
    }
    
    private func emitProducts(_ cart: Cart) {
        productsSubject.onNext(cart.products)
    }
    
    private func emitDiscounts(_ cart: Cart) {
        discountsSubject.onNext(cart.discounts)
    }
    
    private func emitTotals(_ cart: Cart) {
        let subtotal = createSubtotal(cart)
        let discounts = createDiscounts(cart)
        let total = createTotal(subtotal, discounts: discounts)
        
        totalsSubject.onNext([subtotal, discounts, total])
    }
    
    private func createSubtotal(_ cart: Cart) -> Total {
        let initialSubtotal = Price(amount: 0, currency: .Euro)
        let subtotal = cart.products.reduce(initialSubtotal) { (price, product) -> Price in
            var resultAmount = price.amount
            resultAmount += Double(product.quantity) * product.product.price.amount
            return Price(amount: resultAmount, currency: price.currency)
        }
        
        return Total(name: "Subtotal", amount: subtotal)
    }
    
    private func createDiscounts(_ cart: Cart) -> Total {
        let initialDiscount = Price(amount: 0, currency: .Euro)
        let discounts = cart.discounts.reduce(initialDiscount) { (price, discount) -> Price in
            let resultAmount = discount.price.amount + price.amount
            return Price(amount: resultAmount, currency: price.currency)
        }
        return Total(name: "Discounts", amount: discounts)
    }
    
    private func createTotal(_ subtotal: Total, discounts: Total) -> Total {
        let totalAmount = subtotal.amount.amount - discounts.amount.amount
        let total = Price(amount: totalAmount, currency: subtotal.amount.currency)
        return Total(name: "Total", amount: total)
    }
    
    private func productAtIndex(_ products: [CartProduct], _ index: Int) -> CartProduct? {
        if index >= 0 && index < products.count {
            return products[index]
        }
        return nil
    }
    
    private func deleteProductFromCart(_ product: CartProduct) {
        deleteProductsFromCart
            .execute(product: product).subscribe(onCompleted: { [weak self] in
                self?.viewDidLoad()
            }).disposed(by: disposeBag)
    }
}

extension CartViewModel {
    func viewDidLoad() {
        getCartWithDiscounts.execute()
            .subscribe(onSuccess: { [weak self] cart in
                self?.emitProducts(cart)
                self?.emitDiscounts(cart)
                self?.emitTotals(cart)
            }).disposed(by: disposeBag)
    }
    
    func deleteProduct(_ index: Int) {
        output.products
            .take(1)
            .subscribe(onNext: { [weak self] products in
                guard let product = self?.productAtIndex(products, index) else { return }
                self?.deleteProductFromCart(product)
            }).disposed(by: disposeBag)
    }
}

struct Total {
    let name: String
    let amount: Price
}
