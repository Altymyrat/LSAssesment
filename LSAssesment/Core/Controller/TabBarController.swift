//
//  TabBarController.swift
//  LSAssesment
//
//  Created by M.J. on 23.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    // MARK: - Private parameters
    private let buttonWidth = UIScreen.main.bounds.size.width / CGFloat(kControllerTreeKeys.count)
    private var buttons: [UIButton] = []
    
    // MARK: - Parameters
    static var tabBarHeight: CGFloat = deviceHasTopNotch ? 85.0 : 60.0
    static let selectedTextFont: UIFont = UIFont.systemFont(ofSize: 10)
    static let normalTextFont: UIFont = UIFont.systemFont(ofSize: 10)
    static let selectedTextColor: UIColor = #colorLiteral(red: 0.001387050026, green: 0.4792679548, blue: 1, alpha: 1)
    static let normalTextColor: UIColor = UIColor.black
       
    var selectedItemIndex: Int = 0 {
        didSet {
            selectedIndex = selectedItemIndex
            for button in buttons {
                button.isSelected = button.tag == selectedItemIndex
                button.tintColor = button.isSelected ? TabBarController.selectedTextColor : TabBarController.normalTextColor
            }
        }
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        configureUI()
        reloadButtons()
        selectedItemIndex = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let items = tabBar.items, items.count > 0 {
            for index in 0...items.count-1 {
                let item = items[index]
                item.isAccessibilityElement = false
                item.accessibilityLabel = buttons[index].titleLabel?.text
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 13.0, *) {
            var tabFrame = tabBar.frame
            tabFrame.size.height = TabBarController.tabBarHeight
            tabFrame.origin.y = view.frame.size.height - TabBarController.tabBarHeight
            tabBar.frame = tabFrame
        }
    }
    
    // MARK: - Functions
    func configureUI() {
        tabBar.barTintColor = .white
        tabBar.isOpaque = false
        tabBar.isHidden = false
        tabBar.barStyle = .black
        tabBar.layer.insertSublayer(tabBarHairline, at: 0)
        tabBar.isAccessibilityElement = false
    }
    
    // MARK: - Private Functions
    private var tabBarHairline: CALayer = {
        let layer = CALayer()
        layer.frame = CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 1.0 / UIScreen.main.scale)
        layer.backgroundColor = UIColor.gray.cgColor
        return layer
    }()
}

extension TabBarController {
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let didSelectIndex = tabBar.items?.firstIndex(of: item) ?? 0
        selectedItemIndex = didSelectIndex
    }
    
    private func reloadButtons() {
        if buttons.isEmpty {
            for key in kControllerTreeKeys {
                let tag: Int = kControllerTree[key]!.index
                let button = createButton(key)
                button.translatesAutoresizingMaskIntoConstraints = false
                tabBar.addSubview(button)
                button.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: 13).isActive = true
                button.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor, constant: CGFloat(tag) * buttonWidth).isActive = true
                button.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
                buttons.append(button)
            }
        }
    }
    
    private func createButton(_ key: ControllerKey) -> UIButton {
        let tag: Int = kControllerTree[key]!.index
        let iconName: String = kControllerTree[key]!.iconName
        let title: String = kControllerMap[key]!.title
        let selected: Bool = tag == tabBar.items?.firstIndex(of: tabBar.selectedItem!) ?? 0
        let font = TabBarController.selectedTextFont
        let button = UIButton(frame: CGRect.zero)
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        button.tag = tag
        button.isSelected = selected
        button.titleLabel?.font = font
        button.titleLabel?.textColor = selected ? TabBarController.selectedTextColor : TabBarController.normalTextColor
        button.setTitleColor(TabBarController.normalTextColor, for: .normal)
        button.setTitleColor(TabBarController.selectedTextColor, for: .selected)
        button.setTitle(title, for: .normal)
        
        let normalAttributes = [
            NSAttributedString.Key.foregroundColor: TabBarController.normalTextColor,
            NSAttributedString.Key.font: TabBarController.normalTextFont
        ]
        let selectedAttributes = [
            NSAttributedString.Key.foregroundColor: TabBarController.selectedTextColor,
            NSAttributedString.Key.font: TabBarController.selectedTextFont
        ]
        let normalAttributed: NSAttributedString = NSAttributedString(string: title, attributes: normalAttributes)
        let selectedAttributed: NSAttributedString = NSAttributedString(string: title, attributes: selectedAttributes)
        
        button.setAttributedTitle(normalAttributed, for: .normal)
        button.setAttributedTitle(selectedAttributed, for: .selected)
        button.imageView?.contentMode = .scaleAspectFit
        button.accessibilityLabel = title
        button.accessibilityHint = ""
        button.isAccessibilityElement = false
        let buttonImage = UIImage(named: iconName)
        button.setImage(buttonImage?.withRenderingMode(.alwaysTemplate), for: .normal)
        let imageViewSize: CGSize = UIImage(named: iconName)!.size
        let fixedHeight: CGFloat = 44
        let padding: CGFloat = 2
        button.backgroundColor = .clear
        let titleSize: CGSize = title.size(withAttributes: [NSAttributedString.Key.font: font])
        button.titleEdgeInsets = UIEdgeInsets(top: fixedHeight + padding, left: -imageViewSize.width, bottom: 0, right: 0)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -titleSize.width)
        return button
    }
    
    @objc private func buttonAction(_ button: UIButton) {
        selectedItemIndex = button.tag
    }
}

extension UITabBar {
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = TabBarController.tabBarHeight
        return sizeThatFits
    }
}

