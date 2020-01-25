import Foundation

struct Price {
    let amount: Double
    let currency: Currency

    enum Currency {
        case Euro
    }
}
