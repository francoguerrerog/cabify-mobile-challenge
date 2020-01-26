import Foundation

struct ProductResponse: Codable {    
    let code: String
    let name: String
    let price: Double
    
    func toProduct() -> Product {
        return Product(code: code, name: name, price: Price(amount: price, currency: .Euro))
    }
}
