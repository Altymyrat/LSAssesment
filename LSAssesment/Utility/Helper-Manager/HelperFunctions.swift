//
//  HelperFunctions.swift
//  LSAssesment
//
//  Created by M.J. on 23.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

func delay(_ time: Double, _ completion: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
        completion()
    }
}

var deviceHasTopNotch: Bool {
    return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
}
