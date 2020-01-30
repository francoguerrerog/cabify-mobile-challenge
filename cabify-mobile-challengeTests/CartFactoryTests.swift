import Foundation

@testable import cabify_mobile_challenge

struct CartFactoryTests {
    
    public static func createEmptyCart() -> Cart {
        return Cart()
    }
    
    public static func createCartWith2for1Condition() -> Cart {
        let cart = Cart()
        let voucher = Product(code: "VOUCHER", name: "Cabify Voucher", price: Price(amount: 5.00, currency: .Euro))
        cart.addProduct(CartProduct(product: voucher, quantity: 3))
        return cart
    }
    
    public static func createCartWithMultiple2for1Conditions() -> Cart {
        let cart = Cart()
        let voucher = Product(code: "VOUCHER", name: "Cabify Voucher", price: Price(amount: 5.00, currency: .Euro))
        cart.addProduct(CartProduct(product: voucher, quantity: 5))
        return cart
    }
    
    public static func createCartWith2Thirts() -> Cart {
        let cart = Cart()
        let tshirt = Product(code: "TSHIRT", name: "Cabify T-Shirt", price: Price(amount: 20.00, currency: .Euro))
        cart.addProduct(CartProduct(product: tshirt, quantity: 2))
        return cart
    }
    
    public static func createCartWith4Thirts() -> Cart {
        let cart = Cart()
        let tshirt = Product(code: "TSHIRT", name: "Cabify T-Shirt", price: Price(amount: 20.00, currency: .Euro))
        cart.addProduct(CartProduct(product: tshirt, quantity: 4))
        return cart
    }
    
    public static func createProducts() -> Products {
        let voucher = Product(code: "VOUCHER", name: "Cabify Voucher", price: Price(amount: 5.00, currency: .Euro))
        let tshirt = Product(code: "TSHIRT", name: "Cabify T-Shirt", price: Price(amount: 20.00, currency: .Euro))
        let mug = Product(code: "MUG", name: "Cabify Coffee Mug", price: Price(amount: 7.50, currency: .Euro))
        let products = Products(products: [voucher, tshirt, mug])
        return products
    }
    
    public static func createCartProduct() -> CartProduct {
        let voucher = Product(code: "VOUCHER", name: "Cabify Voucher", price: Price(amount: 5.00, currency: .Euro))
        return CartProduct(product: voucher, quantity: 3)
    }
}
