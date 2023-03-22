//
//  PVBottomSheetViewController.swift
//  PokeVip
//
//  Created by Matheus Bondan on 15/02/23.
//

import UIKit

open class PVBottomSheetViewController: PVBaseViewController {
    let contentView = UIView(frame: .zero)
    let closeButton = UIButton()
    var closeButtonAction: (() -> Void)?
    var topAnchor: NSLayoutConstraint?
    var bottomAnchor: NSLayoutConstraint?
    
    public override init() {
        super.init()
        modalPresentationStyle = .overFullScreen
    }

    public override func viewDidLoad() {
        view.backgroundColor = .clear
        closeButton.contentVerticalAlignment = .bottom
        contentView.backgroundColor = PVColor.white.uiColor
        view.addSubviews([contentView, closeButton], constraints: true)

        let contentViewHeight = contentView.frame.height
        bottomAnchor = contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -contentViewHeight)
        
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            closeButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -contentViewHeight)
        ])
        
        topAnchor = contentView.topAnchor.constraint(equalTo: view.bottomAnchor)
        
        closeButton.setImage(PVImageType.close.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        closeButton.tintColor = PVColor.black.uiColor

        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 30
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        closeButton.addTarget(self, action: #selector(touchAction), for: .touchUpInside)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let contentViewHeight = contentView.frame.height
        bottomAnchor = contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -contentViewHeight)
        
        topAnchor?.isActive = false
        self.bottomAnchor?.constant = 0
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0,
            options: [.curveEaseInOut]
        ) {
            self.view.backgroundColor = PVColor.opacityBlack60.uiColor
        }
        UIView.animate(
            withDuration: 0.3,
            delay: 0.3,
            options: [.curveEaseInOut]
        ) {
            self.contentView.superview?.layoutIfNeeded()
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.backgroundColor = .clear
    }
    
    @objc func touchAction() {
        dismiss(animated: true, completion: nil)
        closeButtonAction?()
    }
}
