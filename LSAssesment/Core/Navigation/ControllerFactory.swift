//
//  ControllerFactory.swift
//  LSAssesment
//
//  Created by M.J. on 23.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit
/// This class responsible for factoring tabbar and viewController
class ControllerFactory {
    
    /// - Factoring tabbar according to given controllerKeys
    /// - Return tabbar
    static func tabBarController(_ controllerKeys: [ControllerKey]) -> UITabBarController {
        let tabBarController: TabBarController = TabBarController()
        var viewControllers = [UINavigationController]()

        for controllerKey in controllerKeys {
            if let controller = ControllerFactory.viewController(controllerKey) {
                let navController = navigationController(controller, popGestureEnabled: true)
                viewControllers.append(navController)
            }
        }

        if viewControllers.count > 0 {
            tabBarController.setViewControllers(viewControllers, animated: false)
            let tabBarTitleOffset = UIOffset(horizontal: 0, vertical: 50)
            for controller in viewControllers {
                controller.tabBarItem.titlePositionAdjustment = tabBarTitleOffset
            }
        }

        return tabBarController
    }
    
    /// - Factoring navigationController according to given viewController
    /// - Return navigationController
    static func navigationController(_ root: UIViewController,
                                     popGestureEnabled: Bool = false) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: root)
        navigationController.navigationBar.tintColor = UIColor.white
        navigationController.navigationBar.barTintColor = UIColor.white
        navigationController.navigationBar.isOpaque = false
        navigationController.navigationBar.isTranslucent = false
        navigationController.interactivePopGestureRecognizer?.isEnabled = popGestureEnabled
        return navigationController
    }
    
    /// - Factoring viewController according to given controllerKey
    /// - Return viewController
    static func viewController(_ controllerKey: ControllerKey) -> UIViewController? {
        if controllerKey == ControllerKeys.tabbar.rawValue {
            return ControllerFactory.mainController()
        }
        
        if let nClass = kControllerMap[controllerKey]?.classType {
            let controller = nClass.init()
            controller.controllerKey = controllerKey
            var hideTabBarControl: Bool = false
            for contKey in kControllerTreeKeys where contKey == controllerKey {
                hideTabBarControl = true
            }
            controller.hidesBottomBarWhenPushed = !hideTabBarControl
            
            return controller
        }
        
        return nil
    }
    
    static func mainController() -> UITabBarController {
        let tabController = ControllerFactory.tabBarController(kControllerTreeKeys)
        return tabController
    }
}
