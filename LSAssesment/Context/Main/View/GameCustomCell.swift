//
//  GameCustomCell.swift
//  LSAssesment
//
//  Created by M.J. on 24.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

class GameCustomCell: UITableViewCell {
    // MARK: - IBOutlets:
    @IBOutlet private weak var imageViewCell: UIImageView!
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var labelMetacritic: UILabel!
    @IBOutlet private weak var labelMetacriticValue: UILabel!
    @IBOutlet private weak var labelGenre: UILabel!
    
    // MARK: - Parameters
    static let identifier = "GameCustomCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    // MARK: - Private func:
    private func configureUI() {
        labelTitle.arrangeLabelAttributes(.left, font: .boldSystemFont(ofSize: 20), textColor: .black, 0, "")
        labelMetacritic.arrangeLabelAttributes(.left, font: .systemFont(ofSize: 14), textColor: .black, 1, "metacritic: ")
        labelMetacriticValue.arrangeLabelAttributes(.center, font: .systemFont(ofSize: 18), textColor: AppColor.metacriticColor, 1, "")
        labelGenre.arrangeLabelAttributes(.left, font: .systemFont(ofSize: 13), textColor: AppColor.genreColor, 0, "")
        imageView?.contentMode = .scaleAspectFill
    }
    
    private func updateUI() {
        labelTitle.text = ""
        labelMetacriticValue.text = ""
        labelGenre.text = ""
        
    }
}
