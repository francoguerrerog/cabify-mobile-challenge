import UIKit
import RxSwift
import RxCocoa

class ProductsViewController: UIViewController {
    
    private let viewModel: ProductsViewModel
    private lazy var mainView = ProductsView.initFromNib()
    
    private let disposeBag = DisposeBag()

    init(viewModel: ProductsViewModel) {
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
        setupButton()
        bindViewModel()
        viewModel.viewDidLoad()
    }
    
    private func setupTitle() {
        self.title = "Products"
    }
    
    private func setupTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.register(UINib(nibName: ProductCellView.cellIdentifier, bundle: Bundle(for: type(of: self))), forCellReuseIdentifier: ProductCellView.cellIdentifier)
    }
    
    private func setupButton() {
        mainView.continueButton.addTarget(self, action: #selector(continueButtonSelected(sender:)), for: .touchUpInside)
    }

    private func bindViewModel() {
        bindLoading()
        bindTableView()
        bindShowAddedProductAlert()
    }
    
    private func bindLoading() {
        viewModel.output.loading
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] (loading) in
                self?.mainView.loadingView.isHidden = !loading
            }).disposed(by: disposeBag)
    }
    
    private func bindTableView() {
        viewModel.output.products
            .observeOn(MainScheduler.instance)
            .bind(to: mainView.tableView.rx.items(cellIdentifier: ProductCellView.cellIdentifier, cellType: ProductCellView.self)) { [weak self] row, element, cell in
                self?.configureCell(cell, with: element)
            }
            .disposed(by: disposeBag)
    }
    
    private func bindShowAddedProductAlert() {
        viewModel.output.showAddedToCartAlert
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.showAddedProductAlert()
            }).disposed(by: disposeBag)
    }
    
    private func configureCell(_ cell: ProductCellView, with item: Product) {
        cell.titleLabel.text = item.name
        cell.priceLabel.text = "\(item.price.amount) €"
    }
    
    private func openAlertAmount(indexItem: Int) {
        let alert = UIAlertController(title: "Enter quantity", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.keyboardType = .numberPad
            textField.returnKeyType = .send
        }

        let addToCartAction = UIAlertAction(title: "Add to cart", style: .default) { [unowned alert] _ in
            let answer = alert.textFields![0]
            
            guard let quantityText = answer.text,
                let quantity = Int(quantityText),
                quantity > 0 else { return }
            
            self.viewModel.selectProduct(indexItem, quantity)
        }

        alert.addAction(addToCartAction)

        present(alert, animated: true)
    }
    
    @objc
    private func continueButtonSelected(sender: UIButton) {
        viewModel.selectContinueButton()
    }
    
    private func showAddedProductAlert() {
        let ac = UIAlertController(title: "Product added to cart", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)

        ac.addAction(action)

        present(ac, animated: true)
    }
}

extension ProductsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        openAlertAmount(indexItem: indexPath.row)
    }
}
