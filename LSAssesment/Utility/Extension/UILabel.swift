//
//  UILabel.swift
//  LSAssesment
//
//  Created by M.J. on 24.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

extension UILabel {
    func arrangeLabelAttributes(_ alignment: NSTextAlignment = .center, font: UIFont, textColor: UIColor = .black, _ numberOfLines: Int = 0, _ text: String? = "") {
        self.textAlignment = alignment
        self.font = font
        self.textColor = textColor
        self.numberOfLines = numberOfLines
        self.text = text
    }
}
