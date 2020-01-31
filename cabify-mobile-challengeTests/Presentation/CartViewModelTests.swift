import XCTest
import SwiftyMocky
import RxTest
import RxSwift

@testable import cabify_mobile_challenge

class CartViewModelTests: XCTestCase {
    
    private let getCartWithDiscounts = GetCartWithDiscountsMock()
    private let deleteProductFromCart = DeleteProductsFromCartMock()
    private var viewModel: CartViewModel!
    
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    private var productsObserver: TestableObserver<[CartProduct]>!
    private var discountsObserver: TestableObserver<[Discount]>!
    
    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        productsObserver = scheduler.createObserver([CartProduct].self)
        discountsObserver = scheduler.createObserver([Discount].self)
    }
    
    func test_getCartWithDiscounts() {
        givenACartWithDiscount()
        
        whenViewDidLoad()
        
        thenGetCartWithDiscounts()
    }
    
    func test_emitCartProducts() {
        givenACartWithDiscount()
        
        viewModel.output.products.subscribe(productsObserver).disposed(by: disposeBag)
        whenViewDidLoad()
        
        thenEmitProducts()
    }
    
    func test_emitCartDiscounts() {
        givenACartWithDiscount()
        
        viewModel.output.discounts.subscribe(discountsObserver).disposed(by: disposeBag)
        whenViewDidLoad()
        
        thenEmitDiscounts()
    }
    
    func test_deleteProduct() {
        givenADeleteProductScenario()
        
        whenDeleteProduct()
        
        thenDeleteProductFromCart()
    }
    
    private func givenACartWithDiscount() {
        Given(getCartWithDiscounts, .execute(willReturn: .just(CartFactoryTests.createCartWith2Thirts())))
        viewModel = CartViewModel(getCartWithDiscounts, deleteProductFromCart)
    }
    
    private func givenADeleteProductScenario() {
        givenACartWithDiscount()
        whenViewDidLoad()
        Given(deleteProductFromCart, .execute(product: .any, willReturn: .empty()))
    }
    
    private func whenViewDidLoad() {
        viewModel.viewDidLoad()
    }
    
    private func whenDeleteProduct() {
        viewModel.deleteProduct(0)
    }
    
    private func thenGetCartWithDiscounts() {
        Verify(getCartWithDiscounts, .once, .execute())
    }
    
    private func thenEmitProducts() {
        let events = productsObserver.events
        XCTAssertEqual(events.count, 2)
    }

    private func thenEmitDiscounts() {
        let events = discountsObserver.events
        XCTAssertEqual(events.count, 2)
    }
    
    private func thenDeleteProductFromCart() {
        Verify(deleteProductFromCart, .once, .execute(product: .any))
    }
}
