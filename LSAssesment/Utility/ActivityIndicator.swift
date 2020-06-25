//
//  ActivityIndicator.swift
//  LSAssesment
//
//  Created by M.J. on 24.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

class ActivityIndicator {
    static let shared = ActivityIndicator()
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private var topVCView = NavigationManager.shared.topViewController()?.view
    
    func showIndicator() {
        configureIndicatorView()
        activityIndicator.startAnimating()
    }
    
    func stopIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
    
    private func configureIndicatorView() {
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
        activityIndicator.center = topVCView?.center ?? CGPoint(x: 0.0, y: 0.0)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .whiteLarge
        activityIndicator.color = .gray
        topVCView?.addSubview(activityIndicator)
    }
}
