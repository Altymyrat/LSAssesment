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
    
    // MARK: - Private parameters:
    private var favouriteVM: [ResultVM] = [] {
        didSet{
            updateUI()
            favouriteCount = favouriteVM.count
        }
    }
    
    private var favouriteCount: Int = 0 {
        didSet {
            if favouriteCount != 0, favouriteCount > 0 {
                pageTitle = AppString.favouritesVCTitle + "(\(favouriteCount))"
            } else {
                pageTitle = AppString.favouritesVCTitle
            }
        }
    }
    
    // MARK: - Override func:
    override var isNavigationBarHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.favouriteVM = DataManager.shared.getFavouriteGames()
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
        if !favouriteVM.isEmpty {
            tableView.isHidden = false
            labelDesc.isHidden = true
            tableView.reloadData()
        } else {
            tableView.isHidden = true
            labelDesc.isHidden = false
            labelDesc.text = AppString.notFoundFavourite
        }
    }
}

// MARK: - TableViewDelegate, TableViewDataSource
extension FavouritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameCustomCell.identifier, for: indexPath) as! GameCustomCell
        cell.resultVM = self.favouriteVM[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            let alert = UIAlertController(title: AppString.alertTitle, message: AppString.alertDesc, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: AppString.alerYesButton, style: UIAlertAction.Style.default, handler: { action in
                DataManager.shared.deleteGameFromFavourite(with: indexPath.row)
                self.favouriteVM = DataManager.shared.getFavouriteGames()
            }))
            alert.addAction(UIAlertAction(title: AppString.alertCancelButton, style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
