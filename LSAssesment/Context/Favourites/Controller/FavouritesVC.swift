//
//  FavouritesVC.swift
//  LSAssesment
//
//  Created by M.J. on 23.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

class FavouritesVC: BaseVC {
    // MARK: - IBOutlets:
    @IBOutlet private weak var labelDesc: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var topConstraintTableview: NSLayoutConstraint!
    @IBOutlet private weak var topConstraintLabel: NSLayoutConstraint!
    
    // MARK: - Override func:
    override var isNavigationBarHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }

    override func configureUI() {
        super.configureUI()
        pageTitle = AppString.favouritesVCTitle
        topConstraintLabel.constant = deviceHasTopNotch ? 160 : 130
        topConstraintTableview.constant =  deviceHasTopNotch ? 130 : 100
        
        labelDesc.arrangeLabelAttributes(.center, font: .systemFont(ofSize: 18),
                                         textColor: .black, 0, AppString.notFoundFavourite)
        labelDesc.isHidden = true
        tableView.isHidden = true
    }
    
    // MARK: - Private func:
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
    
    private func updateUI() {
        
    }
}

// MARK: - TableViewDelegate, TableViewDataSource
extension FavouritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
