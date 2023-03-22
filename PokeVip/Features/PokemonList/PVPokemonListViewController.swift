//
//  PVPokemonListViewController.swift
//
//  Created by Matheus Bondan on 09/02/23.
//  Copyright (c) 2023 Realize. All rights reserved.

import UIKit

final class PVPokemonListViewController: PVBaseViewController {
    
    // MARK: Properties
    private let backgroundImage = PVImageView()
    private let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let tableView: UITableView = UITableView()
    private var pokemonList: [PokemonOutput] = []
    private var typeList: [TypesOutput] = []
    private var selectedIndex: Int?
    
    private let presenter: PVPokemonListPresenterInterface

    // MARK: Initializer
    
    init(presenter: PVPokemonListPresenterInterface) {
        self.presenter = presenter
        
        super.init()
    }


    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokemon finder"
        setupView()
        presenter.setViewModel(self)
    }
    
    private func setupView() {
        view.addSubviews([backgroundImage,
                          collectionView,
                          tableView])
        
        NSLayoutConstraint.activate([
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            collectionView.heightAnchor.constraint(equalToConstant: 115),
            
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        setupCollectionView()
        setupTableView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(PVTypeCollectionViewCell.self, forCellWithReuseIdentifier: PVTypeCollectionViewCell.reuseIdentifier)
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 1
        collectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    private func setupTableView() {
        tableView.rowHeight = PVPokemonListCell.height
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PVPokemonListCell.self, forCellReuseIdentifier: PVPokemonListCell.reuseIdentifier)
    }
}

// MARK: - FeatureView

extension PVPokemonListViewController: PVPokemonListViewModel {
    func setBackgroundImage(_ image: PVImageType) {
        backgroundImage.setImage(image, contentMode: .scaleAspectFill)
    }
    
    func setPokemonList(pokemonList: [PokemonOutput]) {
        self.pokemonList = pokemonList
        tableView.reloadData()
    }
    
    func setTypeList(typeList: [TypesOutput]) {
        self.typeList = typeList
        collectionView.reloadData()
    }
}

extension PVPokemonListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PVPokemonListCell.reuseIdentifier,
            for: indexPath
        ) as? PVPokemonListCell else { return UITableViewCell() }
        let pokemon = pokemonList[indexPath.row]
        cell.setupRow(PVPokemonListDataSource(
            pokemonImage: pokemon.thumbnailImage,
            name: pokemon.name,
            types: pokemon.type,
            number: pokemon.number))
        return cell
    }
}

extension PVPokemonListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension PVPokemonListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return typeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PVTypeCollectionViewCell.reuseIdentifier, for: indexPath) as? PVTypeCollectionViewCell else {return UICollectionViewCell()}
        
        let type = typeList[indexPath.row]
        cell.setup(PVTypeCollectionDataSource(name: type.name, image: type.thumbnailImage, selectedIndex: indexPath.row == selectedIndex))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        presenter.filterByType(type: typeList[indexPath.row])
    }
}
