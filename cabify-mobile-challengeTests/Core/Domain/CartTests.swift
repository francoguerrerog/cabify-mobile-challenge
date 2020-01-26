import XCTest

@testable import cabify_mobile_challenge

class CartTests: XCTestCase {
    
    private let voucher = Product(code: "VOUCHER", name: "Cabify Voucher", price: Price(amount: 5.00, currency: .Euro))
    private let tshirt = Product(code: "TSHIRT", name: "Cabify T-Shirt", price: Price(amount: 20.00, currency: .Euro))
    private let mug = Product(code: "MUG", name: "Cabify Coffee Mug", price: Price(amount: 7.50, currency: .Euro))
    private var cart: Cart!
    
    func test_addFirstProduct() {
        givenACart()
        
        whenAddProducts(voucher, 1)
        
        thenAddFirstProduct()
    }
    
    func test_addSecondProduct() {
        givenACart()
        givenAVoucher()
        
        whenAddProducts(voucher, 2)
        
        thenAddSameProductQuantity()
    }
    
    fileprivate func givenACart() {
        cart = Cart()
    }
    
    private func givenAVoucher() {
        whenAddProducts(voucher, 1)
    }
    
    private func whenAddProducts(_ product: Product, _ quantity: Int) {
        cart.addProduct(CartProduct(product: product, quantity: quantity))
    }
    
    private func thenAddFirstProduct() {
        let products = cart.getProducts()
        XCTAssertEqual(products.count, 1)
        XCTAssertEqual(products.first?.quantity, 1)
        XCTAssertEqual(products.first?.product.code, voucher.code)
    }
    
    private func thenAddSameProductQuantity() {
        let products = cart.getProducts()
        XCTAssertEqual(products.count, 1)
        XCTAssertEqual(products.first?.quantity, 3)
        XCTAssertEqual(products.first?.product.code, voucher.code)
    }
}
