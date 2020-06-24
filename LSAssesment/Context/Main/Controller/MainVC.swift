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
    
    // MARK: - Override func
    override var isNavigationBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func configureUI() {
        super.configureUI()
        pageTitle = AppString.gameVCTitle
        topConstraintSearchBar.constant =  deviceHasTopNotch ? 130 : 100
        
        searchBar.delegate = self
        
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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameCustomCell.identifier, for: indexPath) as! GameCustomCell
        return cell
    }
}

// MARK: - SearchBarDelegate
extension MainVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
