//
//  PVInitialProtocol.swift
//
//  Created by Matheus Bondan on 09/02/23.
//  Copyright (c) 2023 Realize. All rights reserved.

import UIKit

protocol PVInitialViewModel: AnyObject {
    func setBackgroundImage(_ image: PVImageType)
    func setPokemonLogoImage(_ image: PVImageType)
    func setFinderImage(_ image: PVImageType)
    func setPikachuImage(_ image: PVImageType)
    func setButtonTitle(_ title: String)
}

protocol PVInitialPresenterInterface: AnyObject {
    var coordinator: PVInitialCoordinatorInterface { get }
    var viewModel: PVInitialViewModel? { get }
    func setViewModel(_ viewModel: PVInitialViewModel)
    func goToMeet()
}

protocol PVInitialCoordinatorInterface: AnyObject {
    var navigator: UINavigationController? { get }
    func start()
    func goToMeet()
}
