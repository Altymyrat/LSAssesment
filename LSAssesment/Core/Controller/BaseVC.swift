//
//  BaseVC.swift
//  LSAssesment
//
//  Created by M.J. on 23.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

enum NavigationBarButtonType: Int {
    case favourite = 1
    case back = 2
}

class BaseVC: UIViewController {
    
    // MARK: Preferred Status Bar Style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    // MARK: Preferred View Controller Styles
    var isNavigationBarHidden: Bool {
        return false
    }
    
    var pageTitle: String? {
        didSet {
            labelPageTitle.text = self.pageTitle
        }
    }
    
    private lazy var backgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = AppColor.headerBackground
        return view
    }()
    
    private lazy var labelPageTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .boldSystemFont(ofSize: 34)
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = AppColor.headerBackground
        return label
    }()
    
    // MARK: Base Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNeedsStatusBarAppearanceUpdate()
        self.configureNavigationBar()
    }
    
    func configureUI() {
        configureNavigationBar()
    }
    
    func rightBarButtonItems() -> [UIBarButtonItem] {
        var array: [UIBarButtonItem] = []
        array.append(self.createBarButtonItem(.favourite))
        return array
    }
    
    func leftBarButtonItems() -> [UIBarButtonItem] {
        var array: [UIBarButtonItem] = []
        if self.navigationController?.viewControllers.first != self {
            array.append(self.createBarButtonItem(.back))
        }
        return array
    }
    
    @objc private func barButtonAction(_ button: UIButton) {
        if button.tag == NavigationBarButtonType.favourite.rawValue {
            favouriteButtonAction()
        } else if button.tag == NavigationBarButtonType.back.rawValue {
            backButtonAction()
        }
    }
    
    func favouriteButtonAction() {
        
    }
    
    func backButtonAction() {
        navigationController?.popViewController(animated: true)
    }
    
    func createBarButtonItem(_ type: NavigationBarButtonType) -> UIBarButtonItem {
        let buttonName = barButtonName(type)
        let button: UIButton = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: navigationController?.navigationBar.frame.height ?? 50)
        button.setTitle(buttonName, for: .normal)
        button.addTarget(self, action: #selector(self.barButtonAction(_:)), for: .touchUpInside)
        button.contentHorizontalAlignment = .center
        button.contentMode = .left
        button.tag = type.rawValue
        let barButtonItem = UIBarButtonItem(customView: button)
        barButtonItem.tag = type.rawValue
        return barButtonItem
    }
    
    func barButtonName(_ type: NavigationBarButtonType) -> String {
        switch type {
        case .back:
            return "< \(Coordinator.shared.previousVCTitle ?? "")"
        case .favourite:
            return "Favourite"
        }
    }
    
    func configureNavigationBar() {
        if !isNavigationBarHidden {
            self.navigationItem.titleView = nil
            self.navigationItem.leftBarButtonItems = self.leftBarButtonItems()
            self.navigationItem.rightBarButtonItems = self.rightBarButtonItems()
        } else if !self.isKind(of: SplashVC.self){
            configureHeaderView()
        }
        navigationController?.isNavigationBarHidden = isNavigationBarHidden
    }
    
    private func configureHeaderView() {
        self.view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        backgroundView.heightAnchor.constraint(equalToConstant: deviceHasTopNotch ? 130 : 100).isActive = true
        
        backgroundView.addSubview(labelPageTitle)
        labelPageTitle.translatesAutoresizingMaskIntoConstraints = false
        labelPageTitle.bottomAnchor.constraint(equalTo: self.backgroundView.bottomAnchor).isActive = true
        labelPageTitle.leadingAnchor.constraint(equalTo: self.backgroundView.leadingAnchor, constant: 16).isActive = true
    }
}
