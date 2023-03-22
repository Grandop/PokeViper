//
//  PVInitialViewController.swift
//
//  Created by Matheus Bondan on 09/02/23.
//  Copyright (c) 2023 Realize. All rights reserved.

import UIKit

final class PVInitialViewController: PVBaseViewController {
    
    // MARK: Properties
    private let backgroundImage = PVImageView()
    private let pokemonLogoImage = PVImageView()
    private let finderImage = PVImageView()
    private let letsGoButton = PVButton(style: .standard)
    private let pikachuImage = PVImageView()
    
    private let presenter: PVInitialPresenterInterface

    // MARK: Initializer
    
    init(presenter: PVInitialPresenterInterface) {
        self.presenter = presenter
        
        super.init()
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.setViewModel(self)
        self.navigationController!.navigationBar.backgroundColor = UIColor.clear
    }
    
    private func setupView() {
        view.addSubviews([backgroundImage,
                          pokemonLogoImage,
                          finderImage,
                          letsGoButton,
                          pikachuImage], constraints: true)
        
        NSLayoutConstraint.activate([
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            pokemonLogoImage.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 27),
            pokemonLogoImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            pokemonLogoImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            finderImage.topAnchor.constraint(equalTo: pokemonLogoImage.bottomAnchor),
            finderImage.leadingAnchor.constraint(equalTo: pokemonLogoImage.leadingAnchor),
            finderImage.trailingAnchor.constraint(equalTo: pokemonLogoImage.trailingAnchor),
            
            letsGoButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            pikachuImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pikachuImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        letsGoButton.touchAction = { [weak self] in
            self?.presenter.goToMeet()
        }
    }
}

// MARK: - FeatureView

extension PVInitialViewController: PVInitialViewModel {
    func setPikachuImage(_ image: PVImageType) {
        pikachuImage.setImage(image)
    }
    
    func setButtonTitle(_ title: String) {
        letsGoButton.setTitle(title, for: .normal)
    }
    
    func setBackgroundImage(_ image: PVImageType) {
        backgroundImage.setImage(image, contentMode: .scaleAspectFill)
    }
    
    func setPokemonLogoImage(_ image: PVImageType) {
        pokemonLogoImage.setImage(image)
    }
    
    func setFinderImage(_ image: PVImageType) {
        finderImage.setImage(image)
    }
}
