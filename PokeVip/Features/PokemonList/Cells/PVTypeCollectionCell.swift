//
//  PVTypeCollectionCell.swift
//  PokeVip
//
//  Created by Matheus Bondan on 15/02/23.
//

import UIKit

class PVTypeCollectionViewCell: UICollectionViewCell {
    static var reuseIdentifier: String { String(describing: self) }
    private let containerView: UIView = UIView()
    private let labelName = PVLabel(.arial16, textColor: .black, alignment: .center)
    private let imageType = PVImageView()
    
    
    func setup(_ dataSource: PVTypeCollectionDataSource) {
        
        labelName.text = dataSource.name
        imageType.load(from: dataSource.image)
        
        
        
        containerView.backgroundColor = PVColor.white.uiColor
        containerView.layer.cornerRadius = 8
        addSubview(containerView, constraints: true)
        
        if let selected = dataSource.selectedIndex, selected {
            containerView.backgroundColor = PVColor.gray2.uiColor
        }

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 100),
            containerView.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        containerView.addSubviews([labelName, imageType], constraints: true)
        
        NSLayoutConstraint.activate([
            imageType.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 4),
            imageType.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4),
            imageType.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),
            
            labelName.topAnchor.constraint(equalTo: imageType.bottomAnchor, constant: 4),
            labelName.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 4),
            labelName.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -4),
            labelName.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -4),
        ])
    }
}

public struct PVTypeCollectionDataSource {
    let name: String
    let image: String
    let selectedIndex: Bool?

    public init(name: String, image: String, selectedIndex: Bool = false) {
        self.name = name
        self.image = image
        self.selectedIndex = selectedIndex
    }
}
