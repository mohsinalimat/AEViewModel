import UIKit

// MARK: - TableViewModelCell

public protocol TableViewModelCell: class {
    var action: (_ sender: Any) -> Void { get set }
    func customize()
    func update(with item: Item)
}

public extension TableViewModelCell where Self: UITableViewCell {}

// MARK: - TableCell

public enum TableCell {
    case basic
    case subtitle
    case leftDetail
    case rightDetail
    case button
    case toggle
    case textInput
    case customClass(type: TableViewModelCell.Type)
    case customNib(nib: UINib?)
}

// MARK: - System Cells

extension TableCell {
    
    open class Basic: UITableViewCell, TableViewModelCell {
        public var action: (Any) -> Void = { sender in }
        
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            customize()
        }
        open override func awakeFromNib() {
            super.awakeFromNib()
            customize()
        }
        
        open func customize() {}
        open func update(with item: Item) {
            if let data = item.data {
                textLabel?.text = data.title
                detailTextLabel?.text = data.detail
                if let imageName = data.image {
                    imageView?.image = UIImage(named: imageName)
                }
            }
            configureAutomaticDisclosureIndicator(with: item)
        }
        open func configureAutomaticDisclosureIndicator(with item: Item) {
            if let table = item.child as? Table, table.sections.count > 0 {
                accessoryType = .disclosureIndicator
            }
        }
        
        @objc public func callAction(sender: Any) {
            action(sender)
        }
    }
    
    open class Subtitle: Basic {
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        }
    }
    
    open class LeftDetail: Basic {
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: .value2, reuseIdentifier: reuseIdentifier)
        }
    }
    
    open class RightDetail: Basic {
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        }
    }
    
}

// MARK: - Custom Cells

extension TableCell {
    
    open class Toggle: Basic {
        public let toggle = UISwitch()

        open override func customize() {
            selectionStyle = .none
            accessoryView = toggle
            toggle.addTarget(self, action: #selector(callAction), for: .valueChanged)
        }
    }
    
    open class TextInput: Basic, UITextFieldDelegate {
        public let textField = UITextField()
        
        open override func customize() {
            selectionStyle = .none
            configureTextField()
        }
        private func configureTextField() {
            contentView.addSubview(textField)
            textField.translatesAutoresizingMaskIntoConstraints = false
            
            let margins = contentView.layoutMarginsGuide
            textField.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
            textField.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
            textField.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
            textField.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
            
            textField.delegate = self
        }
        open override func update(with item: Item) {
            textField.placeholder = item.data?.title
        }
        open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            callAction(sender: textField)
            return false
        }
    }
    
    open class Button: Basic {
        public let button = UIButton(type: .system)
        
        open override func customize() {
            selectionStyle = .none
            configureButton()
            button.addTarget(self, action: #selector(callAction), for: .touchUpInside)
        }
        private func configureButton() {
            contentView.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
            button.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        }
        open override func update(with item: Item) {
            button.setTitle(item.data?.title, for: .normal)
        }
    }
    
}
