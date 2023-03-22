//
//  PVDropdownListItemCell.swift
//  PokeVip
//
//  Created by Matheus Bondan on 15/02/23.
//

import UIKit

final class PVDropdownListItemCell: UITableViewCell {
    static var height: CGFloat = 51
    static var reuseIdentifier: String { String(describing: self) }
    private let labelTitle = PVLabel(.arial20)
    var stackView: UIStackView = UIStackView()

    func setupRow(_ dataSource: PVDropDownListItemType) {

        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 12

        selectionStyle = .none
        addSubviews([stackView], constraints: true)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 24),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        switch dataSource {
        case .type(let type): setupTypeView(type)
        }
    }

    private func setupTypeView(_ type: PVDropDownListTypeDataSource) {
        if let imageType = type.imageType {
            let imageView = PVImageView()
            imageView.load(from: imageType)
            imageView.layer.cornerRadius = 20
            stackView.addArrangedSubview(imageView)
            
            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 8),
                imageView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -8),
                imageView.heightAnchor.constraint(equalToConstant: 35),
                imageView.widthAnchor.constraint(equalToConstant: 35),
            ])
        }

        labelTitle.text = type.title
        labelTitle.textColor = PVColor.black.uiColor
        stackView.addArrangedSubview(labelTitle)
        NSLayoutConstraint.activate([
            labelTitle.centerYAnchor.constraint(equalTo: stackView.centerYAnchor)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        self.stackView.subviews.forEach { $0.removeFromSuperview() }
    }
}

public struct PVDropDownListTypeDataSource {
    let imageType: String?
    public let title: String

    public init(
        imageType: String? = nil,
        title: String
    ) {
        self.imageType = imageType
        self.title = title
    }
}

public enum PVDropDownListItemType {
    case type(PVDropDownListTypeDataSource)

    public var title: String {
        switch self {
        case .type(let type):
            return type.title
        }
    }
}
