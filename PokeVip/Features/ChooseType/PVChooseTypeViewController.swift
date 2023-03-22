//
//  PVChooseTypeViewController.swift
//
//  Created by Matheus Bondan on 09/02/23.
//  Copyright (c) 2023 Realize. All rights reserved.

import UIKit

final class PVChooseTypeViewController: PVBaseViewController {
    
    // MARK: Properties
    
    private let backgroundImage = PVImageView()
    private let titleLabel = PVLabel(.arial25)
    private let subtitleLabel = PVLabel(.arial20)
    private let dropDown = PVDropdownFieldView(dataSource: PVDropDownFieldDataSource(placeHolderTitle: "Escolha o tipo"))
    private let nextButton = PVButton(style: .standard)
    
    private let presenter: PVChooseTypePresenterInterface

    // MARK: Initializer
    
    init(presenter: PVChooseTypePresenterInterface) {
        self.presenter = presenter
        
        super.init()
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.setViewModel(self)
    }
    
    private func setupView() {
        view.addSubviews([backgroundImage,
                          titleLabel,
                          subtitleLabel,
                          dropDown,
                          nextButton], constraints: true)
        
        NSLayoutConstraint.activate([
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            dropDown.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 50),
            dropDown.leadingAnchor.constraint(equalTo: subtitleLabel.leadingAnchor),
            dropDown.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor),
            
            nextButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -25),
        ])
        nextButton.isEnabled = false
        nextButton.touchAction = { [weak self] in
            self?.presenter.goToPokeList()
        }
    }
}

// MARK: - FeatureView

extension PVChooseTypeViewController: PVChooseTypeViewModel {
    func setupDropdown(dataSource: PVDropdownListDataSource) {
        let vc = PVDropdownListViewController(dataSource: dataSource)
        vc.delegate = self
        dropDown.touchAction = {
            print("asdjkdjsad")
            self.present(vc, animated: true)
        }
        
    }
    
    func setBackgroundImage(_ image: PVImageType) {
        backgroundImage.setImage(image, contentMode: .scaleAspectFill)
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setSubtitle(_ subtitle: String) {
        subtitleLabel.text = subtitle
    }
    
    func setButtonTitle(_ title: String) {
        nextButton.setTitle(title, for: .normal)
    }
    
    func setDropdownSelected(value: String) {
        nextButton.isEnabled = true
        dropDown.setSelected(value: value)
    }
}

extension PVChooseTypeViewController: PVDropdownListViewDelegate {
    func indexSelected(_ index: Int) {
        
        presenter.dropDownSelected(index: index)
    }
}
