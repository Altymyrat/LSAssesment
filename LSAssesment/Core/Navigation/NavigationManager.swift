//
//  NavigationManager.swift
//  LSAssesment
//
//  Created by M.J. on 23.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

typealias CompletionBlock = () -> Void

/// - Handling  navigation controller through project
/// - present, navigate, dismiss, close, get top viewController and etc.
class NavigationManager {

    static let shared = NavigationManager()
    
    private var dictControllers: [ControllerKey: AnyClass] = [ControllerKey: AnyClass]()
    
    private init() {
        for item in Array(kControllerMap.keys) {
            dictControllers[item] = kControllerMap[item]!.classType
        }
    }
    
    // MARK: - Functions
    /// - Register viewController for use with navigaton controller
    func registerViewController(_ controllerClass: AnyClass, controllerKey: ControllerKey) {
        dictControllers[controllerKey] = controllerClass
    }

    /// - Return all registered viewControllers as a Dictionary
    func registeredViewConrollers() -> NSDictionary {
        return NSDictionary(dictionary: dictControllers)
    }

    /// - Return a viewController which is displaying top of viewController in window
    func topViewController() -> UIViewController? {
        guard let rootController = (UIApplication.shared.windows.first?.rootViewController) else { return nil }
        return topViewController(rootController)
    }
    
    /// - Closing top viewController according to display method
    func closeTopController(_ animated: Bool, completion: CompletionBlock? = nil) {
        let topViewController = self.topViewController()
        if topViewController?.presentingViewController != nil {
            topViewController?.dismiss(animated: animated, completion: {
                completion?()
            })
        } else if let navigationController = topViewController?.navigationController {
            navigationController.popViewController(animated: true) {
                completion?()
            }
        }
    }

    /// - Dismiss top viewController
    func dismissTopController() {
        let topViewController = self.topViewController()
        if topViewController?.presentingViewController == nil {
            return
        }
        topViewController?.dismiss(animated: false, completion: nil)
    }

    /// - Pop  viewController
    func popViewController () {
        let topVC = NavigationManager.shared.topViewController()
        topVC?.navigationController?.popViewController(animated: true)
    }
    
    /// - Navigate viewController according to memner of controller class type
    func navigateToController(_ controllerKey: ControllerKey, animated: Bool) {
        let topViewController = self.topViewController()
        guard let controllerClass = self.dictControllers[controllerKey] else {
            return
        }
        
        if let tabBarController = topViewController?.tabBarController {
            let isNavigate = navigateFromTabController(controllerClass, tabBarController: tabBarController)
            if isNavigate {
                return
            }
        }
        
        if let navigationController = topViewController?.navigationController {
            let isNavigate = navigateFromNavigationController(controllerClass, navigationController: navigationController,
                                                              controllerKey: controllerKey, animated: animated)
            if isNavigate {
                return
            }
        }
        
        if let topController = topViewController {
            _ = navigateFromPresentedController(controllerClass, topViewController: topController,
                                                controllerKey: controllerKey,animated: animated)
        }
    }
    
    /// - Present viewController
    func presentController(_ controllerKey: ControllerKey, modalPresentationStyle: UIModalPresentationStyle = .fullScreen) {
        let topViewController = self.topViewController()
        if let controller = ControllerFactory.viewController(controllerKey) {
            let navController = ControllerFactory.navigationController(controller)
            navController.modalPresentationStyle = modalPresentationStyle
            topViewController?.present(navController, animated: true, completion: nil)
            return
        }
    }

    // MARK: - Private functions:
    private func topViewController(_ rootViewController: UIViewController) -> UIViewController {
        if rootViewController is UITabBarController {
            let tabBarController = (rootViewController as? UITabBarController)!
            return self.topViewController(tabBarController.selectedViewController!)
        } else if rootViewController is UINavigationController {
            let navigationController = (rootViewController as? UINavigationController)!
            if let viewController = navigationController.visibleViewController {
                return self.topViewController(viewController)
            } else {
                return rootViewController
            }
        } else if rootViewController is UIPageViewController {
            let pageViewController = (rootViewController as? UIPageViewController)!
            return self.topViewController((pageViewController.viewControllers?.last!)!)
        } else if rootViewController.presentedViewController != nil {
            return self.topViewController(rootViewController.presentedViewController!)
        } else {
            return rootViewController
        }
    }
    
    private func closeTopVC(_ viewController: UIViewController, completion: CompletionBlock? = nil) {
        if viewController.presentingViewController != nil {
            viewController.dismiss(animated: true) {
                if let topVC = self.topViewController() {
                    self.closeTopVC(topVC, completion: completion)
                }
            }
            return
        } else if viewController.navigationController != nil && viewController.navigationController?.viewControllers.count ?? 1 > 1 {
            CATransaction.begin()
            CATransaction.setCompletionBlock {
                if let topVC = self.topViewController() {
                    self.closeTopVC(topVC, completion: completion)
                }
            }
            viewController.navigationController?.popToRootViewController(animated: true)
            CATransaction.commit()
            return
        }
        completion?()
    }

    private func navigatePopFromNavigationController(_ controllerClass: AnyClass,
                                                     navigationController: UINavigationController,
                                                     controllerKey: ControllerKey,
                                                     animated: Bool) -> Bool {
        for childCont in navigationController.viewControllers {
            if childCont.isMember(of: controllerClass) {
                if let navTopController = navigationController.topViewController {
                    let topContClass: AnyClass? = navTopController.classForCoder
                    let sameClass = (topContClass?.isSubclass(of: childCont.classForCoder))!
                    let currentIndex = navigationController.viewControllers.firstIndex(of: childCont)
                    if sameClass &&
                        (currentIndex == navigationController.viewControllers.count - 2 ||
                            currentIndex == navigationController.viewControllers.count - 1) {
                        continue
                    }
                    childCont.forcedByNavigationManager = true
                    navigationController.popToViewController(childCont, animated: animated)
                    return true
                }
            }
        }
        return false
    }

    private func navigateFromNavigationController(_ controllerClass: AnyClass, navigationController: UINavigationController,
                                                  controllerKey: ControllerKey, animated: Bool) -> Bool {

        if navigatePopFromNavigationController(controllerClass, navigationController: navigationController,
                                               controllerKey: controllerKey,animated: animated) {
            return true
        }

        if let navContParent = navigationController.navigationController {
            if navigatePopFromNavigationController(controllerClass, navigationController: navContParent,
                                                   controllerKey: controllerKey, animated: animated) {
                return true
            }
        }
        
        if let controller = ControllerFactory.viewController(controllerKey) {
            if controller is TabBarController {
                navigationController.navigationBar.isHidden = true
                navigationController.setViewControllers([controller], animated: true)
            } else {
                navigationController.pushViewController(controller, animated: animated)
            }
            return true
        }
        return false
    }
    
    private func navigateFromTabController(_ controllerClass: AnyClass,
                                           tabBarController: UITabBarController) -> Bool {
        for childViewController in tabBarController.viewControllers! {
            if childViewController.isMember(of: controllerClass) {
                let index = tabBarController.viewControllers?.firstIndex(of: childViewController)
                if index != tabBarController.selectedIndex {
                    childViewController.forcedByNavigationManager = true
                    tabBarController.selectedIndex = index!
                    return true
                }
            }
        }
        return false
    }
    
    private func navigateFromPresentedController(_ controllerClass: AnyClass, topViewController: UIViewController,
                                                 controllerKey: ControllerKey, animated: Bool) -> Bool {
        var control = false
        if let presentingController = topViewController.presentingViewController {
            if presentingController.isMember(of: controllerClass) {
                control = true
            }
        }
        if control {
            self.closeTopController(animated)
        } else {
            if let controller = ControllerFactory.viewController(controllerKey) {
                controller.forcedByNavigationManager = true
                topViewController.present(controller, animated: animated, completion: nil)
                return true
            }
        }
        return false
    }
}
