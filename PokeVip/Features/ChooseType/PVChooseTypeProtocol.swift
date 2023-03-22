//
//  PVChooseTypeProtocol.swift
//
//  Created by Matheus Bondan on 09/02/23.
//  Copyright (c) 2023 Realize. All rights reserved.

import UIKit
//import OrbiCore

protocol PVChooseTypeViewModel: AnyObject {
    func setBackgroundImage(_ image: PVImageType)
    func setTitle(_ title: String)
    func setSubtitle(_ subtitle: String)
    func setButtonTitle(_ title: String)
    func setupDropdown(dataSource: PVDropdownListDataSource)
    func setDropdownSelected(value: String)
}

protocol PVChooseTypePresenterInterface: AnyObject {
    var coordinator: PVChooseTypeCoordinatorInterface { get }
    var interactor: PVChooseTypeInteractorInput { get }
    var viewModel: PVChooseTypeViewModel? { get }
    func setViewModel(_ viewModel: PVChooseTypeViewModel)
    func goToPokeList()
    func dropDownSelected(index: Int)
}

protocol PVChooseTypeInteractorOutput: AnyObject {
    func fetchTypesSucceeded(output: ListTypesOutput)
    func fetchTypesFailed()
}

protocol PVChooseTypeInteractorInput: AnyObject {
    var api: ApiProtocol? { get set }
    var output: PVChooseTypeInteractorOutput? { get set }
    func fetchTypes()
}

protocol PVChooseTypeCoordinatorInterface: AnyObject {
    var navigator: UINavigationController? { get }
    func start(_ name: String)
    func goToPokeList(types: [TypesOutput])
}
