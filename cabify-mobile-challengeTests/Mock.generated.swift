// Generated using Sourcery 0.17.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// Generated with SwiftyMocky 3.3.4

import SwiftyMocky
#if !MockyCustom
import XCTest
#endif
import RxSwift
@testable import cabify_mobile_challenge


// MARK: - CartRepository
open class CartRepositoryMock: CartRepository, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }





    open func put(cart: Cart) {
        addInvocation(.m_put__cart_cart(Parameter<Cart>.value(`cart`)))
		let perform = methodPerformValue(.m_put__cart_cart(Parameter<Cart>.value(`cart`))) as? (Cart) -> Void
		perform?(`cart`)
    }

    open func find() -> Single<Cart> {
        addInvocation(.m_find)
		let perform = methodPerformValue(.m_find) as? () -> Void
		perform?()
		var __value: Single<Cart>
		do {
		    __value = try methodReturnValue(.m_find).casted()
		} catch {
			onFatalFailure("Stub return value not specified for find(). Use given")
			Failure("Stub return value not specified for find(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_put__cart_cart(Parameter<Cart>)
        case m_find

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_put__cart_cart(let lhsCart), .m_put__cart_cart(let rhsCart)):
                guard Parameter.compare(lhs: lhsCart, rhs: rhsCart, with: matcher) else { return false } 
                return true 
            case (.m_find, .m_find):
                return true 
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_put__cart_cart(p0): return p0.intValue
            case .m_find: return 0
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func find(willReturn: Single<Cart>...) -> MethodStub {
            return Given(method: .m_find, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func find(willProduce: (Stubber<Single<Cart>>) -> Void) -> MethodStub {
            let willReturn: [Single<Cart>] = []
			let given: Given = { return Given(method: .m_find, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<Cart>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func put(cart: Parameter<Cart>) -> Verify { return Verify(method: .m_put__cart_cart(`cart`))}
        public static func find() -> Verify { return Verify(method: .m_find)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func put(cart: Parameter<Cart>, perform: @escaping (Cart) -> Void) -> Perform {
            return Perform(method: .m_put__cart_cart(`cart`), performs: perform)
        }
        public static func find(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_find, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - DiscountCondition
open class DiscountConditionMock: DiscountCondition, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }





    open func evaluate(_ cart: Cart) -> Discount? {
        addInvocation(.m_evaluate__cart(Parameter<Cart>.value(`cart`)))
		let perform = methodPerformValue(.m_evaluate__cart(Parameter<Cart>.value(`cart`))) as? (Cart) -> Void
		perform?(`cart`)
		var __value: Discount? = nil
		do {
		    __value = try methodReturnValue(.m_evaluate__cart(Parameter<Cart>.value(`cart`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_evaluate__cart(Parameter<Cart>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_evaluate__cart(let lhsCart), .m_evaluate__cart(let rhsCart)):
                guard Parameter.compare(lhs: lhsCart, rhs: rhsCart, with: matcher) else { return false } 
                return true 
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_evaluate__cart(p0): return p0.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func evaluate(_ cart: Parameter<Cart>, willReturn: Discount?...) -> MethodStub {
            return Given(method: .m_evaluate__cart(`cart`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func evaluate(_ cart: Parameter<Cart>, willProduce: (Stubber<Discount?>) -> Void) -> MethodStub {
            let willReturn: [Discount?] = []
			let given: Given = { return Given(method: .m_evaluate__cart(`cart`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Discount?).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func evaluate(_ cart: Parameter<Cart>) -> Verify { return Verify(method: .m_evaluate__cart(`cart`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func evaluate(_ cart: Parameter<Cart>, perform: @escaping (Cart) -> Void) -> Perform {
            return Perform(method: .m_evaluate__cart(`cart`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - DiscountsService
open class DiscountsServiceMock: DiscountsService, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }





    open func applyDiscountsToCart(_ cart: Cart) -> Single<Cart> {
        addInvocation(.m_applyDiscountsToCart__cart(Parameter<Cart>.value(`cart`)))
		let perform = methodPerformValue(.m_applyDiscountsToCart__cart(Parameter<Cart>.value(`cart`))) as? (Cart) -> Void
		perform?(`cart`)
		var __value: Single<Cart>
		do {
		    __value = try methodReturnValue(.m_applyDiscountsToCart__cart(Parameter<Cart>.value(`cart`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for applyDiscountsToCart(_ cart: Cart). Use given")
			Failure("Stub return value not specified for applyDiscountsToCart(_ cart: Cart). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_applyDiscountsToCart__cart(Parameter<Cart>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_applyDiscountsToCart__cart(let lhsCart), .m_applyDiscountsToCart__cart(let rhsCart)):
                guard Parameter.compare(lhs: lhsCart, rhs: rhsCart, with: matcher) else { return false } 
                return true 
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_applyDiscountsToCart__cart(p0): return p0.intValue
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func applyDiscountsToCart(_ cart: Parameter<Cart>, willReturn: Single<Cart>...) -> MethodStub {
            return Given(method: .m_applyDiscountsToCart__cart(`cart`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func applyDiscountsToCart(_ cart: Parameter<Cart>, willProduce: (Stubber<Single<Cart>>) -> Void) -> MethodStub {
            let willReturn: [Single<Cart>] = []
			let given: Given = { return Given(method: .m_applyDiscountsToCart__cart(`cart`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<Cart>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func applyDiscountsToCart(_ cart: Parameter<Cart>) -> Verify { return Verify(method: .m_applyDiscountsToCart__cart(`cart`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func applyDiscountsToCart(_ cart: Parameter<Cart>, perform: @escaping (Cart) -> Void) -> Perform {
            return Perform(method: .m_applyDiscountsToCart__cart(`cart`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - ProductsRepository
open class ProductsRepositoryMock: ProductsRepository, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }





    open func put(_ products: Products) {
        addInvocation(.m_put__products(Parameter<Products>.value(`products`)))
		let perform = methodPerformValue(.m_put__products(Parameter<Products>.value(`products`))) as? (Products) -> Void
		perform?(`products`)
    }

    open func find() -> Single<Products> {
        addInvocation(.m_find)
		let perform = methodPerformValue(.m_find) as? () -> Void
		perform?()
		var __value: Single<Products>
		do {
		    __value = try methodReturnValue(.m_find).casted()
		} catch {
			onFatalFailure("Stub return value not specified for find(). Use given")
			Failure("Stub return value not specified for find(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_put__products(Parameter<Products>)
        case m_find

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_put__products(let lhsProducts), .m_put__products(let rhsProducts)):
                guard Parameter.compare(lhs: lhsProducts, rhs: rhsProducts, with: matcher) else { return false } 
                return true 
            case (.m_find, .m_find):
                return true 
            default: return false
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_put__products(p0): return p0.intValue
            case .m_find: return 0
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func find(willReturn: Single<Products>...) -> MethodStub {
            return Given(method: .m_find, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func find(willProduce: (Stubber<Single<Products>>) -> Void) -> MethodStub {
            let willReturn: [Single<Products>] = []
			let given: Given = { return Given(method: .m_find, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<Products>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func put(_ products: Parameter<Products>) -> Verify { return Verify(method: .m_put__products(`products`))}
        public static func find() -> Verify { return Verify(method: .m_find)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func put(_ products: Parameter<Products>, perform: @escaping (Products) -> Void) -> Perform {
            return Perform(method: .m_put__products(`products`), performs: perform)
        }
        public static func find(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_find, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

// MARK: - ProductsService
open class ProductsServiceMock: ProductsService, Mock {
    init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }





    open func find() -> Single<Products> {
        addInvocation(.m_find)
		let perform = methodPerformValue(.m_find) as? () -> Void
		perform?()
		var __value: Single<Products>
		do {
		    __value = try methodReturnValue(.m_find).casted()
		} catch {
			onFatalFailure("Stub return value not specified for find(). Use given")
			Failure("Stub return value not specified for find(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_find

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Bool {
            switch (lhs, rhs) {
            case (.m_find, .m_find):
                return true 
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_find: return 0
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func find(willReturn: Single<Products>...) -> MethodStub {
            return Given(method: .m_find, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func find(willProduce: (Stubber<Single<Products>>) -> Void) -> MethodStub {
            let willReturn: [Single<Products>] = []
			let given: Given = { return Given(method: .m_find, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Single<Products>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func find() -> Verify { return Verify(method: .m_find)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func find(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_find, performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let invocations = matchingCalls(method.method)
        MockyAssert(count.matches(invocations.count), "Expected: \(count) invocations of `\(method.method)`, but was: \(invocations.count)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        invocations.append(call)
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher) }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType) -> [MethodType] {
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher) }
    }
    private func matchingCalls(_ method: Verify) -> Int {
        return matchingCalls(method.method).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        #if Mocky
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleMissingStubError(message: message, file: file, line: line)
        #endif
    }
}

