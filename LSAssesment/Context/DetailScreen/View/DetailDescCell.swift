//
//  DetailDescCell.swift
//  LSAssesment
//
//  Created by M.J. on 26.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit
protocol DetailReadMoreDelegate: class {
    func expandCell(isExpanded: Bool)
}

class DetailDescCell: UITableViewCell {

    // MARK: - IBOutlets:
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var labelDescription: UILabel!
    @IBOutlet private weak var buttonReadMore: UIButton!
    @IBOutlet private weak var seperatorView: UIView!
    
    // MARK: - Parameters
    static let identifier = "DetailDescCell"
    weak var delegate: DetailReadMoreDelegate?
    var gameDesc: String = "" {
        didSet{
            labelDescription.text = gameDesc
        }
    }
    // MARK: - Private parameters
    private var isFullText: Bool = false {
        didSet {
            labelDescription.numberOfLines = isFullText ? 0 : 4
            buttonReadMore.setTitle(isFullText ? AppString.contractButton : AppString.readMoreButton, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    // MARK: - Private func
    private func configureUI() {
        labelTitle.arrangeLabelAttributes(.left, font: .systemFont(ofSize: 17), textColor: AppColor.detailCellColor, 1, AppString.gameDesc)
        labelDescription.arrangeLabelAttributes(.left, font: .systemFont(ofSize: 10), textColor: AppColor.detailCellColor, 4, "")
        buttonReadMore.setTitle(AppString.readMoreButton, for: .normal)
        buttonReadMore.tintColor = AppColor.detailCellColor
        seperatorView.backgroundColor = AppColor.headerBackground
    }
    
    
    @IBAction private func buttonReadMoreTapped(_ sender: UIButton) {
        isFullText = !isFullText
        delegate?.expandCell(isExpanded: isFullText)
    }
}
