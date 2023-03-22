//
//  PVTypeView.swift
//  PokeVip
//
//  Created by Matheus Bondan on 15/02/23.
//

import UIKit

final public class PVTypeView: UIView {
    private let labelName = PVLabel(.arial20)
    private let contentView = UIView()
    private var dataSource: PVTypeViewDataSource?
    private var type: Types?
    
    public init(dataSource: PVTypeViewDataSource? = nil) {
        self.dataSource = dataSource
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { return nil }
    
    public override func didMoveToSuperview() {
        

        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 40)
        ])
        layer.masksToBounds = true
        layer.cornerRadius = 12
        clipsToBounds = true
        
        
        addSubview(contentView, constraints: true)
        contentView.addSubview(labelName, constraints: true)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            labelName.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            labelName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            labelName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            labelName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
    }
    
    private func setupView() {
        guard let type else {return}
        labelName.text = type.rawValue.uppercased()
        
        switch type {
        case .bug:
            backgroundColor = PVColor.bug.uiColor
        case .normal:
            backgroundColor = PVColor.normal.uiColor
        case .fighting:
            backgroundColor = PVColor.fighting.uiColor
        case .flying:
            backgroundColor = PVColor.flying.uiColor
        case .poison:
            backgroundColor = PVColor.poison.uiColor
        case .ground:
            backgroundColor = PVColor.ground.uiColor
        case .rock:
            backgroundColor = PVColor.rock.uiColor
        case .steel:
            backgroundColor = PVColor.steel.uiColor
        case .fire:
            backgroundColor = PVColor.fire.uiColor
        case .water:
            backgroundColor = PVColor.water.uiColor
        case .grass:
            backgroundColor = PVColor.grass.uiColor
        case .electric:
            backgroundColor = PVColor.electric.uiColor
        case .psychic:
            backgroundColor = PVColor.psychic.uiColor
        case .ice:
            backgroundColor = PVColor.ice.uiColor
        case .dragon:
            backgroundColor = PVColor.dragon.uiColor
        case .dark:
            backgroundColor = PVColor.dark.uiColor
        case .fairy:
            backgroundColor = PVColor.fairy.uiColor
        case .ghost:
            backgroundColor = PVColor.ghost.uiColor
        }
    }
    
    func setDataSource(dataSource: PVTypeViewDataSource) {
        self.dataSource = dataSource
        setupView()
    }
    
    func setType(type: Types) {
        self.type = type
        setupView()
    }
}

public struct PVTypeViewDataSource {
    let color: PVColor
    let name: String

    public init(name: String, color: PVColor) {
        self.color = color
        self.name = name
    }
}
