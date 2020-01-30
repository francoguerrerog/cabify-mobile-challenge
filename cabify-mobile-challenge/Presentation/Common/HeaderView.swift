import UIKit

class HeaderView: UIView {
    
    private let leftLabel = UILabel()
    private let rightLabel = UILabel()
    private let quantityLabel = UILabel()
    
    var leftText: String? {
        didSet{
            leftLabel.text = leftText
        }
    }
    
    var rightText: String? {
        didSet{
            rightLabel.text = rightText
        }
    }
    
    var quantityText: String? {
        didSet{
            quantityLabel.text = quantityText
        }
    }
    
    private func setupLeftLabel() {
        self.addSubview(leftLabel)
        leftLabel.textColor = .black
        leftLabel.font = UIFont.systemFont(ofSize: 12.0)
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        leftLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        leftLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        leftLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
    }
    
    private func setupRightLabel() {
        self.addSubview(rightLabel)
        rightLabel.textColor = .black
        rightLabel.font = UIFont.systemFont(ofSize: 12.0)
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
        rightLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        rightLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        rightLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
    }
    
    private func setupQuantityLabel() {
        self.addSubview(quantityLabel)
        quantityLabel.textColor = .black
        quantityLabel.font = UIFont.systemFont(ofSize: 12.0)
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        quantityLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        quantityLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        quantityLabel.trailingAnchor.constraint(equalTo: rightLabel.leadingAnchor, constant: -30).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        
        setupLeftLabel()
        setupRightLabel()
        setupQuantityLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
