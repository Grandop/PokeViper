//
//  PVMeetViewController.swift
//
//  Created by Matheus Bondan on 09/02/23.
//  Copyright (c) 2023 Realize. All rights reserved.

import UIKit
//import OrbiDesign

final class PVMeetViewController: PVBaseViewController {
    
    // MARK: Properties
    private let backgroundImage = PVImageView()
    private let titleLabel = PVLabel(.arial25)
    private let subtitleLabel = PVLabel(.arial20)
    private let textFieldView = PVTextFieldView(topPlaceHolder: "Nome")
    private let nextButton = PVButton(style: .standard)
    
    private let presenter: PVMeetPresenterInterface

    // MARK: Initializer
    
    init(presenter: PVMeetPresenterInterface) {
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
                          textFieldView,
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
            
            textFieldView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 50),
            textFieldView.leadingAnchor.constraint(equalTo: subtitleLabel.leadingAnchor),
            textFieldView.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor),
            
            nextButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -25),
        ])
        
        textFieldView.delegate = self
        nextButton.isEnabled = false
        nextButton.touchAction = { [weak self] in
            self?.presenter.goToChooseType(self?.textFieldView.text ?? "")
        }
    }
}

// MARK: - FeatureView

extension PVMeetViewController: PVMeetViewModel {
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
}

extension PVMeetViewController: PVTextFieldViewDelegate {
    func shouldChangeCharactersIn(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) {
        guard let text = textField.text else { return }
        nextButton.isEnabled = !(text.count <= 1 && string.isEmpty)
    
    }
}

