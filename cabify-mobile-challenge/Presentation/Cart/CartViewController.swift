import UIKit
import RxSwift

class CartViewController: UIViewController {
    
    private let viewModel: CartViewModel
    private lazy var mainView = CartView.initFromNib()
    
    private let disposeBag = DisposeBag()
    
    private var productsData: [CartProduct] = []
    private var discountsData: [Discount] = []
    private var totalsData: [Total] = []

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
        bindTotals()
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
    
    private func bindTotals() {
        viewModel.output.totals
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] totals in
                self?.reloadTotals(totals)
            }).disposed(by: disposeBag)
    }
    
    private func reloadTotals(_ totals: [Total]) {
        totalsData = totals
        mainView.tableView.reloadSections(IndexSet(arrayLiteral: 2), with: .automatic)
    }
}

extension CartViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return productsData.count
        case 1:
            return discountsData.count
        case 2:
            return totalsData.count
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
        case 2:
            configureTotalCell(indexRow: indexPath.row, cell: cell!)
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
    
    private func configureTotalCell(indexRow: Int, cell: ItemCellView) {
        let data = totalsData[indexRow]
        
        cell.titleLabel.text = data.name
        cell.amountLabel.text = "\(data.amount.amount)"
        cell.itemImage.image = nil
    }
    
    private func ShowConfirmationProductDelete(index: Int) {
        let ac = UIAlertController(title: "Delete?", message: "Do you want to delete this product?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let delete = UIAlertAction(title: "Delete", style: .default) { _ in
            self.viewModel.deleteProduct(index)
        }

        ac.addAction(cancel)
        ac.addAction(delete)

        present(ac, animated: true)
    }
}

extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 2:
            return 40.0
        default:
            return 70.0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            ShowConfirmationProductDelete(index: indexPath.row)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        var leftText = ""
        var rightText = ""
        var quantityText = ""
        
        switch section {
        case 0:
            if productsData.count == 0 { return nil }
            leftText = "ITEMS"
            rightText = "PRICE"
            quantityText = "UNIT"
        case 1:
            if discountsData.count == 0 { return nil }
            leftText = "DISCOUNTS"
            rightText = ""
            quantityText = ""
        case 2:
            if totalsData.count == 0 { return nil }
            leftText = "TOTALS"
            rightText = ""
            quantityText = ""
        default:
            break
        }
        
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 42)
        let headerView = HeaderView(frame: frame)
        headerView.leftText = leftText
        headerView.rightText = rightText
        headerView.quantityText = quantityText
        
        return headerView
    }
}
