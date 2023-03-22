//
//  PVTextField.swift
//  PokeVip
//
//  Created by Matheus Bondan on 14/02/23.
//
import UIKit

public protocol PVTextFieldViewDelegate: AnyObject {
    func didBeginEditing()
    func didEndEditing()
    func shouldChangeCharactersIn(_ textField: UITextField,
                                  shouldChangeCharactersIn range: NSRange,
                                  replacementString string: String)
}

public extension PVTextFieldViewDelegate {
    func didBeginEditing() { }
    func didEndEditing() { }
    func shouldChangeCharactersIn(_ textField: UITextField,
                                  shouldChangeCharactersIn range: NSRange,
                                  replacementString string: String) { }
}

public class PVTextFieldView: UIView {
    let textField = UITextField()
    let labelTopPlaceholder = PVLabel(.arial16, textColor: .white)
    let containerView = UIView()
    let lineView = UIView()
    public var placeholder: String = "" {
        didSet {
            labelTopPlaceholder.text = placeholder
            textField.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: [NSAttributedString.Key.foregroundColor: PVColor.white.uiColor]
            )
        }
    }
    public var maxLength: Int = 50
    public weak var delegate: PVTextFieldViewDelegate?
    private var textFieldCenterAnchor: NSLayoutConstraint?
    private var textFieldBottomAnchor: NSLayoutConstraint?
    public var text: String {
        get {
            return textField.text ?? ""
        }
        set {
            textField.text = newValue
            if !newValue.isEmpty {
                adjustTopPlaceHolderVisibilityAnimated()
            }
        }
    }
    
    var customPlaceholder:String
    
    public init(
        topPlaceHolder: String = ""
    ) {
        customPlaceholder = topPlaceHolder
        self.labelTopPlaceholder.text = topPlaceHolder
        self.placeholder = topPlaceHolder
        self.textField.font = PVFont.arial(size: 16)
        self.textField.textColor = PVColor.white.uiColor
        self.textField.tintColor = PVColor.white.uiColor
        self.textField.placeholder = topPlaceHolder
        
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { return nil }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupLayout()
    }
    
    private func setupLayout() {
        guard let superview else {return}
        setupAppearance()
        
        textField.delegate = self
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 56),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 16),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -16)
        ])
        
        addSubview(containerView, constraints: true)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        containerView.addSubviews([labelTopPlaceholder,
                                   lineView,
                                   textField,], constraints: true)
        
        textFieldBottomAnchor = textField.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,
                                                                  constant: -8)
        textFieldBottomAnchor?.isActive = true
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            labelTopPlaceholder.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            labelTopPlaceholder.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
        ])
        
        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            lineView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setupAppearance() {
        labelTopPlaceholder.alpha = 0
        containerView.backgroundColor = PVColor.clear.uiColor
        lineView.backgroundColor = PVColor.white.uiColor
    }
    
    internal func adjustTopPlaceHolderVisibilityAnimated() {
        
        if textField.isFirstResponder || !text.isEmpty {
            self.textFieldBottomAnchor?.isActive = true
        }
        
        if !placeholder.isEmpty {
            let visible = textField.text!.isEmpty && !textField.isFirstResponder
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                self.labelTopPlaceholder.alpha = visible ? 0 : 1
            })
        }
    }
    
    internal func formatValue(from textField: UITextField, range: NSRange, string: String) -> String {
        var currentText = textField.text ?? ""

        guard let newRange = Range(range, in: currentText) else { return currentText }

        currentText.replaceSubrange(newRange, with: string)

        let formattedText = checkMaxLength(text: currentText)
        
        return formattedText
    }
    
    private func checkMaxLength(text: String) -> String {
        let willSurpassMaxLength = text.count > maxLength
        if maxLength <= 0 || !willSurpassMaxLength {
            return text
        }
        return textField.text ?? ""
    }
}

extension PVTextFieldView: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.didBeginEditing()
        adjustTopPlaceHolderVisibilityAnimated()
        textField.placeholder = ""
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didEndEditing()
        textField.placeholder = customPlaceholder
        adjustTopPlaceHolderVisibilityAnimated()
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {

        delegate?.shouldChangeCharactersIn(textField, shouldChangeCharactersIn: range, replacementString: string)
        let newString = formatValue(from: textField, range: range, string: string)
        if textField.text != newString {
            textField.text = newString
        }
        return false
    }
}
