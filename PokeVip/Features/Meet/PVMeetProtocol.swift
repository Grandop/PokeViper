//
//  PVMeetProtocol.swift
//
//  Created by Matheus Bondan on 09/02/23.
//  Copyright (c) 2023 Realize. All rights reserved.

import UIKit

protocol PVMeetViewModel: AnyObject {
    func setBackgroundImage(_ image: PVImageType)
    func setTitle(_ title: String)
    func setSubtitle(_ subtitle: String)
    func setButtonTitle(_ title: String)
}

protocol PVMeetPresenterInterface: AnyObject {
    var coordinator: PVMeetCoordinatorInterface { get }
    var viewModel: PVMeetViewModel? { get }
    func setViewModel(_ viewModel: PVMeetViewModel)
    func goToChooseType(_ name: String)
}

protocol PVMeetCoordinatorInterface: AnyObject {
    var navigator: UINavigationController? { get }
    func start()
    func goToChooseType(_ name: String)
}
