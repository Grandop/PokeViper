//
//  PVDropDownViewController.swift
//  PokeVip
//
//  Created by Matheus Bondan on 15/02/23.
//

import UIKit

public protocol PVDropdownListViewDelegate: AnyObject {
    func indexSelected(_ index: Int)
}
final public class PVDropdownListViewController: PVBottomSheetViewController {

    private let tableView = UITableView()
    private let labeTitle = PVLabel(.arial25)
    private let dataSource: PVDropdownListDataSource
    private var filteredItems: [(item: PVDropDownListItemType, index: Int)] = []
    public weak var delegate: PVDropdownListViewDelegate?

    public init(dataSource: PVDropdownListDataSource) {
        self.dataSource = dataSource

        super.init()
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        dataSource.items.enumerated().forEach { [weak self] in
            self?.filteredItems.append((item: $0.element, index: $0.offset))
        }

        view.addSubview(labeTitle, constraints: true)
        labeTitle.text = dataSource.title
        labeTitle.textColor = PVColor.black.uiColor
        
        NSLayoutConstraint.activate([
            labeTitle.centerYAnchor.constraint(equalTo: closeButton.centerYAnchor, constant: 2),
            labeTitle.leadingAnchor.constraint(equalTo: closeButton.trailingAnchor, constant: 12)
        ])

        setupTableView()
    }

    private func setupTableView() {
        
        tableView.rowHeight = PVDropdownListItemCell.height
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PVDropdownListItemCell.self, forCellReuseIdentifier: PVDropdownListItemCell.reuseIdentifier)
        contentView.addSubview(tableView, constraints: true)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 72),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.heightAnchor.constraint(equalToConstant: getTableHeight())
        ])
    }

    private func getTableHeight() -> CGFloat {
        let tableHeight = CGFloat(dataSource.items.count) * PVDropdownListItemCell.height
        let screenHeight = UIScreen.main.bounds.height - 148

        return tableHeight >= screenHeight ? screenHeight : (tableHeight + 32)
    }
}

extension PVDropdownListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PVDropdownListItemCell.reuseIdentifier,
            for: indexPath
        ) as? PVDropdownListItemCell else { return UITableViewCell() }
        cell.setupRow(filteredItems[indexPath.row].item)
        return cell
    }
}

extension PVDropdownListViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.indexSelected(filteredItems[indexPath.row].index)
        dismiss(animated: true)
    }
}

public struct PVDropdownListDataSource {
    let title: String
    let items: [PVDropDownListItemType]

    public init(title: String, items: [PVDropDownListItemType]) {
        self.title = title
        self.items = items
    }
}
