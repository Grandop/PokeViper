//
//  PVDropDown.swift
//  PokeVip
//
//  Created by Matheus Bondan on 15/02/23.
//

import UIKit

public struct PVDropDownFieldDataSource {
    let placeHolderTitle: String

    public init(placeHolderTitle: String) {
        self.placeHolderTitle = placeHolderTitle
    }
}

public final class PVDropdownFieldView: UIView {

    private let iconView = PVImageView(image: .arrowDown)
    private let labelTitle = PVLabel(.arial20)
    private let labelTopPlaceholderTitle = PVLabel(.arial16)
    private let lineView = UIView()
    private let contentView = UIControl()
    private let dataSource: PVDropDownFieldDataSource
    private var isSelected = false {
        didSet {
            labelTopPlaceholderTitle.isHidden = !isSelected
            labelTitle.textColor = isSelected ? PVColor.white.uiColor : PVColor.gray2.uiColor
            labelTitleCenterYConstraint?.isActive = !isSelected
            labelTitleBottomConstraint?.isActive = isSelected
        }
    }

    public var isEnabled = true {
        didSet {
            labelTitle.textColor = PVColor.white.uiColor
            contentView.isUserInteractionEnabled = isEnabled
        }
    }

    private var labelTitleCenterYConstraint: NSLayoutConstraint?
    private var labelTitleBottomConstraint: NSLayoutConstraint?
    public var touchAction: (() -> Void)?

    public init(dataSource: PVDropDownFieldDataSource) {
        self.dataSource = dataSource
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { return nil }

    public override func didMoveToSuperview() {
        guard let superview else {return}
        labelTitle.text = dataSource.placeHolderTitle
        labelTopPlaceholderTitle.text = dataSource.placeHolderTitle
        labelTopPlaceholderTitle.isHidden = true

        iconView.color = PVColor.white.uiColor
        contentView.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)

        addSubviews([contentView], constraints: true)
        contentView.addSubviews([labelTitle, labelTopPlaceholderTitle, iconView, lineView], constraints: true)
        lineView.backgroundColor = PVColor.white.uiColor
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 76),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        NSLayoutConstraint.activate([
            iconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            labelTopPlaceholderTitle.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            labelTopPlaceholderTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            labelTitle.leadingAnchor.constraint(equalTo: labelTopPlaceholderTitle.leadingAnchor),
            labelTitle.trailingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: -16)
        ])

        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            lineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        labelTitleCenterYConstraint = labelTitle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        labelTitleBottomConstraint = labelTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                                        constant: -8)

        labelTitleCenterYConstraint?.isActive = false
        labelTitleBottomConstraint?.isActive = true
    }

    public func setSelected(value: String) {
        labelTitle.text = value
        isSelected = true
    }

    public func clear() {
        labelTitle.text = dataSource.placeHolderTitle
        isSelected = false
    }

    @objc private func touchUpInside() {
        touchAction?()
    }
}
