import UIKit


public enum ButtonStyle: String {
    case standard
    case confirm
}

final public class PVButton: UIButton {

    private var height: CGFloat = .zero
    private let style: ButtonStyle
    private var hasIcon: Bool = false
    public var touchAction: (() -> Void)?
    private var icon: UIImage?

    public init(style: ButtonStyle, icon: UIImage? = nil) {
        self.style = style
        super.init(frame: .zero)
    }

    public func setImage(_ icon: UIImage?) {
        hasIcon = icon != nil
        self.icon = icon

        let iconImage = icon?.withRenderingMode(.alwaysTemplate)
        super.setImage(iconImage, for: .normal)
        super.setImage(iconImage, for: .highlighted)
        super.setImage(iconImage, for: .disabled)
    }

    public override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { return nil}

    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        switch  style {
        case .standard:
            setupStandardButton()
            layer.cornerRadius = 14
        case .confirm: setupConfirmButton()
        }

        guard let superview = superview else { return }

        setupConstraints(superview)

        addTarget(self, action: #selector(btnActionUp(_:)), for: .touchUpInside)
        addTarget(self, action: #selector(btnActionUp(_:)), for: .touchDragExit)
    }

    private func setupStandardButton() {
        titleLabel?.font = PVFont.font(fontType: .arial25)
        height = 50
        setupStyle(style)
    }

    private func setupConfirmButton() {
        setImage(UIImage(named: "next")?.withRenderingMode(.alwaysTemplate), for: .normal)
        setTitle("", for: .normal)
        imageView?.tintColor = PVColor.white.uiColor
    }

    private func setupConstraints(_ superview: UIView) {
        switch style {
        case .standard:
            NSLayoutConstraint.activate([
                self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 16),
                self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -16),
                self.heightAnchor.constraint(equalToConstant: height)
            ])
        case .confirm:
            NSLayoutConstraint.activate([
                self.heightAnchor.constraint(equalToConstant: height),
                self.centerXAnchor.constraint(equalTo: superview.centerXAnchor),
                self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 16)
            ])
        }
    }

    private func setupColors(background: UIColor, title: UIColor, icon: UIColor) {
        backgroundColor = background
        setTitleColor(title, for: .normal)
        imageView?.tintColor = icon
    }

    public override var isEnabled: Bool {
        didSet {
            super.isEnabled = isEnabled

            if !isEnabled {
                switch style {
                case .standard:
                    setTitleColor(.pvColor(.gray2), for: .normal)
                    layer.borderColor = .pvColor(.clear)
                    backgroundColor = .pvColor(.gray5)
                case .confirm:
                    layer.borderColor = .pvColor(.clear)
                    imageView?.tintColor = .pvColor(.gray5)
                }
            } else {
                switch style {
                case .standard:
                    setStandardColor()
                case .confirm:
                    setConfirmColor()
                }
            }
        }
    }
    
    private func setStandardColor() {
        setupColors(background: .pvColor(.buttonColor), title: .pvColor(.white), icon: .pvColor(.white))
    }
    
    private func setConfirmColor() {
        setupColors(background: .pvColor(.clear), title: .pvColor(.white), icon: .pvColor(.white))
    }
    
    private func setupStyle(_ style: ButtonStyle) {
        
        switch style {
        case .standard:
            setStandardColor()
        case .confirm:
            setConfirmColor()
        }
    }

    @IBAction func btnActionUp(_ sender: UIButton) {
        switch style {
        case .standard:
            setStandardColor()
        case .confirm:
            setConfirmColor()
        }

        touchAction?()
    }
}

