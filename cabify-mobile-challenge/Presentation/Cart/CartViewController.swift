import UIKit
import RxSwift

class CartViewController: UIViewController {
    
    private let viewModel: CartViewModel
    private lazy var mainView = CartView.initFromNib()
    
    private let disposeBag = DisposeBag()
    
    private var productsData: [CartProduct] = []
    private var discountsData: [Discount] = []

    init(viewModel: CartViewModel) {
        self.viewModel = viewModel
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
            
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTitle()
        setupTableView()
        bindViewModel()
        viewModel.viewDidLoad()
    }
    
    private func setupTitle() {
        self.title = "Cart List"
    }
    
    private func setupTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(UINib(nibName: ItemCellView.cellIdentifier, bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: ItemCellView.cellIdentifier)
    }

    private func bindViewModel() {
        bindProducts()
        bindDiscounts()
    }
    
    private func bindProducts() {
        viewModel.output.products
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] products in
                self?.reloadProducts(products)
            }).disposed(by: disposeBag)
    }
    
    private func reloadProducts(_ products: [CartProduct]) {
        productsData = products
        mainView.tableView.reloadSections(IndexSet(arrayLiteral: 0), with: .automatic)
    }
    
    private func bindDiscounts() {
        viewModel.output.discounts
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] discounts in
                self?.reloadDiscounts(discounts)
            }).disposed(by: disposeBag)
    }
    
    private func reloadDiscounts(_ discounts: [Discount]) {
        discountsData = discounts
        mainView.tableView.reloadSections(IndexSet(arrayLiteral: 1), with: .automatic)
    }
}

extension CartViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return productsData.count
        case 1:
            return discountsData.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemCellView.cellIdentifier, for: indexPath) as? ItemCellView
        
        switch indexPath.section {
        case 0:
            configureProductCell(indexRow: indexPath.row, cell: cell!)
        case 1:
            configureDiscountCell(indexRow: indexPath.row, cell: cell!)
        default:
            break
        }
        return cell!
    }
    
    private func configureProductCell(indexRow: Int, cell: ItemCellView) {
        let data = productsData[indexRow]
        let amount = Double(data.quantity) * data.product.price.amount
        
        cell.titleLabel.text = data.product.name
        cell.quantityLabel.text = "\(data.quantity)"
        cell.amountLabel.text = "\(amount)"
    }
    
    private func configureDiscountCell(indexRow: Int, cell: ItemCellView) {
        let data = discountsData[indexRow]
        
        cell.titleLabel.text = data.name
        cell.amountLabel.text = "\(data.price.amount)"
    }
}

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //viewModel.selectCard(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 && productsData.count == 0 {
            return nil
        }
        if section == 1 && discountsData.count == 0 {
            return nil
        }
        
        let leftText = section == 0 ? "ITEMS" : "DISCOUNTS"
        let rightText = section == 0 ? "PRICE" : ""
        let quantityText = section == 0 ? "UNIT" : ""
        
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 42)
        let headerView = HeaderView(frame: frame)
        headerView.leftText = leftText
        headerView.rightText = rightText
        headerView.quantityText = quantityText
        
        return headerView
    }
}
