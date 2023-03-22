//
//  PVPokemonListCell.swift
//  PokeVip
//
//  Created by Matheus Bondan on 14/02/23.
//

import UIKit

final class PVPokemonListCell: UITableViewCell {
    static var height: CGFloat = 445
    static var reuseIdentifier: String { String(describing: self) }
    private let viewBackground: UIView = UIView()
    private let informationView: UIView = UIView()
    private let labelName = PVLabel(.arial22)
    private let labelNumber = PVLabel(.arial16)
    private let imagePokemon = PVImageView()
    private let firstType = PVTypeView()
    private let secondType = PVTypeView()

    func setupRow(_ dataSource: PVPokemonListDataSource) {

        viewBackground.backgroundColor = .white
        viewBackground.layer.cornerRadius = 12
        informationView.backgroundColor = .gray
        informationView.layer.cornerRadius = 12
        
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(viewBackground, constraints: true)
        viewBackground.addSubviews([imagePokemon, informationView], constraints: true)
        informationView.addSubviews([labelName,
                                     labelNumber,
                                     firstType], constraints: true)
        
        
        NSLayoutConstraint.activate([
            viewBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            viewBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            viewBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            viewBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            informationView.bottomAnchor.constraint(equalTo: viewBackground.bottomAnchor, constant: -8),
            informationView.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: 8),
            informationView.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant: -8),
            informationView.heightAnchor.constraint(equalToConstant: 113),

            imagePokemon.topAnchor.constraint(equalTo: viewBackground.topAnchor, constant: 8),
            imagePokemon.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: 8),
            imagePokemon.trailingAnchor.constraint(equalTo: viewBackground.trailingAnchor, constant: -8),
            imagePokemon.bottomAnchor.constraint(equalTo: informationView.topAnchor, constant: -8),
            imagePokemon.heightAnchor.constraint(equalToConstant: 300),
            imagePokemon.heightAnchor.constraint(equalToConstant: 300),

            labelName.topAnchor.constraint(equalTo: informationView.topAnchor, constant: 8),
            labelName.leadingAnchor.constraint(equalTo: informationView.leadingAnchor, constant: 8),

            firstType.bottomAnchor.constraint(equalTo: informationView.bottomAnchor, constant: -8),
            firstType.leadingAnchor.constraint(equalTo: informationView.leadingAnchor, constant: 8),

            labelNumber.bottomAnchor.constraint(equalTo: firstType.topAnchor, constant: -4),
            labelNumber.leadingAnchor.constraint(equalTo: firstType.leadingAnchor),
            labelNumber.trailingAnchor.constraint(equalTo: informationView.trailingAnchor, constant: -8),
        ])
        
        imagePokemon.load(from: dataSource.pokemonImage)
        labelName.text = dataSource.name
        labelNumber.text = dataSource.number
        
        if let type = dataSource.types.first {
            firstType.setType(type: type)
        }
        
        if dataSource.types.count > 1 {
            informationView.addSubview(secondType, constraints: true)
            NSLayoutConstraint.activate([
                secondType.bottomAnchor.constraint(equalTo: firstType.bottomAnchor),
                secondType.leadingAnchor.constraint(equalTo: firstType.trailingAnchor, constant: 8)
            ])
            
            if let type = dataSource.types.last {
                secondType.setType(type: type)
            }
        }
    }
    
    override func prepareForReuse() {
        contentView.subviews.forEach { $0.removeFromSuperview() }
        informationView.subviews.forEach { $0.removeFromSuperview() }
        super.prepareForReuse()
    }
}

public struct PVPokemonListDataSource {
    let pokemonImage: String
    let name: String
    let types: [Types]
    let number: String

    public init(
        pokemonImage: String,
        name: String,
        types: [Types],
        number: String
    ) {
        self.pokemonImage = pokemonImage
        self.name = name
        self.types = types
        self.number = number
    }
}

