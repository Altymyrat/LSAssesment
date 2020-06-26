//
//  MainVC.swift
//  LSAssesment
//
//  Created by M.J. on 23.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

class MainVC: BaseVC {
    // MARK: - IBOutlets:
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var topConstraintSearchBar: NSLayoutConstraint!
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var topConstraintLabel: NSLayoutConstraint!
    
    // MARK: - Private parameters:
    private var viewModel: GameVM = GameVM()
    
    // MARK: - Override func
    override var isNavigationBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        viewModel.fetchGame(with: "")
    }
    
    override func configureUI() {
        super.configureUI()
        pageTitle = AppString.gameVCTitle
        topConstraintSearchBar.constant =  deviceHasTopNotch ? 130 : 100
        topConstraintLabel.constant = deviceHasTopNotch ? 150 : 120
        viewModel.delegate = self
        searchBar.delegate = self
        searchBar.placeholder = AppString.searchPlaceHolder
        labelDesc.arrangeLabelAttributes(.center, font: .systemFont(ofSize: 18), textColor: .black, 0, AppString.notGameSearched)
        labelDesc.isHidden = true
    }
    
    // MARK: - Private func
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(UINib(nibName: GameCustomCell.identifier, bundle: nil),
                           forCellReuseIdentifier:  GameCustomCell.identifier)
        tableView.rowHeight = 130
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
}

// MARK: - UITableViewDelegate, UITableViewDatasource
extension MainVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.resultCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameCustomCell.identifier, for: indexPath) as! GameCustomCell
        cell.resultVM = viewModel.getResult(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let id = viewModel.getResult(at: indexPath.row)?.id {
            DataManager.shared.gameID = id
            DataManager.shared.currentGamesData = viewModel.getResultModel(at: indexPath.row)
            Coordinator.shared.requestNavigation(.detailScreen)
        }
    }
}

// MARK: - SearchBarDelegate
extension MainVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        labelDesc.isHidden = true
        tableView.isHidden = false
        let searchString = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard searchString.count > 3 else { return }
        viewModel.fetchGame(with: searchString)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.showsCancelButton = false
        labelDesc.isHidden = false
        tableView.isHidden = true
    }
}

// MARK: - ViewModel Delegate
extension MainVC: ViewModelDelegate {
    func failWith(error: String) {
        print("error", error)
    }
    
    func succes() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
