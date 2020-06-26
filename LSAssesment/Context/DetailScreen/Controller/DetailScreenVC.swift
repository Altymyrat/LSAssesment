//
//  DetailScreenVC.swift
//  LSAssesment
//
//  Created by M.J. on 24.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

class DetailScreenVC: BaseVC {
    // MARK: - IBOutlets:
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Private parameter
    private var cellHeight: CGFloat = 150
    private var detailVM = DetailVM()
    
    // MARK: - Override Func
    override func favouriteButtonAction() {
        DataManager.shared.saveGameToFavourite()
        isFavourite = !DataManager.shared.isAddedToFavourite()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        detailVM.delegate = self
        detailVM.fetchDetail(by: DataManager.shared.gameID)
    }
    
    override func configureUI() {
        super.configureUI()
        isFavourite = !DataManager.shared.isAddedToFavourite()
        imageView.contentMode = .scaleAspectFill
        labelTitle.arrangeLabelAttributes(.right, font: .boldSystemFont(ofSize: 36),
                                          textColor: .white, 0, "")
    }
    
    // MARK: - Private func
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(UINib(nibName: DetailDescCell.identifier, bundle: nil),
                           forCellReuseIdentifier:  DetailDescCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    private func updateUI() {
        self.labelTitle.text = self.detailVM.name
        self.imageView.setImage(from: self.detailVM.imageString)
    }
}
// MARK: - UITableViewDelegate, UITableViewDataSource
extension DetailScreenVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailDescCell.identifier, for: indexPath) as! DetailDescCell
            cell.gameDesc = detailVM.desc
            cell.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            switch indexPath.row {
            case 1:
                cell.textLabel?.text = AppString.visitReddit
            case 2:
                cell.textLabel?.text = AppString.visitWebsite
            default:
                break
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            guard let url = detailVM.redditUrl else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        case 2:
            guard let url = detailVM.websiteUrl else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return cellHeight
        } else {
            return 44
        }
    }
}

// MARK: - DetailReadMoreDelegate
extension DetailScreenVC: DetailReadMoreDelegate {
    func expandCell(isExpanded: Bool) {
        cellHeight = isExpanded ? 300 : 150
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

// MARK: - ViewModelDelegate
extension DetailScreenVC: ViewModelDelegate {
    func failWith(error: String) {
        print(error)
    }
    
    func succes() {
        DispatchQueue.main.async {
            self.updateUI()
            self.tableView.reloadData()
        }
    }
}
