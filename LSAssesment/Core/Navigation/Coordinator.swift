//
//  Coordinator.swift
//  LSAssesment
//
//  Created by M.J. on 23.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

enum ControllerFlowType {
    case navigation
    case present
}

/// - Coordinate viewController using
class Coordinator {
    
    static let shared: Coordinator = Coordinator()
    
    private(set) var previousControllerKey: ControllerKey?
    private(set) var currentControllerKey: ControllerKey? {
        willSet {
            previousControllerKey = NavigationManager.shared.topViewController()?.controllerKey
        }
    }
    
    private init() {}
    
    /// - Display viewController by navigation
    func requestNavigation(_ controllerKey: ControllerKeys, animated: Bool = true) {
        requestNavigation(controllerKey.rawValue, animated: animated)
    }

    /// - Display viewController by present
    func requestPresent(_ controllerKey: ControllerKeys, animated: Bool = true,
                        modalPresentationStyle: UIModalPresentationStyle = .fullScreen) {
        requestPresent(controllerKey.rawValue, animated: animated, modalPresentationStyle: modalPresentationStyle)
    }
    
    /// Initilize application with determined(SplashVC) viewController
    func initializeApp() {
        if let subviews = UIApplication.shared.keyWindow?.subviews {
            for subview in subviews {
                subview.isHidden = true
            }
        }
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let controller = ControllerFactory.viewController(ControllerKeys.splash.rawValue)
            let navController = ControllerFactory.navigationController(controller!)
            appDelegate.window?.rootViewController?.dismiss(animated: false, completion: nil)
            appDelegate.window?.rootViewController = navController
            appDelegate.window?.makeKeyAndVisible()
            UIApplication.shared.beginIgnoringInteractionEvents()
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    /// - Suspend and  exit application
    func applicationSuspend() {
        UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
        Thread.sleep(forTimeInterval: 2.0)
        exit(0)
    }
    
    /// - Get previous viewController title
    var previousVCTitle: String? {
        if let controllerKey = previousControllerKey {
            return kControllerMap[controllerKey]?.title
        }
        return nil
    }
    
    // MARK: - Private functions:
    private func requestPresent(_ controllerKey: ControllerKey, animated: Bool = true,
                                modalPresentationStyle: UIModalPresentationStyle = .fullScreen) {
        self.currentControllerKey = controllerKey
        NavigationManager.shared.presentController(controllerKey, modalPresentationStyle: modalPresentationStyle)
    }
    
    private func requestNavigation(_ controllerKey: ControllerKey, animated: Bool = true) {
        self.currentControllerKey = controllerKey
        NavigationManager.shared.navigateToController(controllerKey, animated: animated)
    }
    
    private func removeControllersFromArray(_ keys: [ControllerKey], controllers: [UIViewController]) -> [UIViewController] {
        var controllersMutable: [UIViewController] = Array(controllers)
        for controller in controllers {
            for key in keys where controller.controllerKey == key {
                if let index = controllers.firstIndex(of: controller) {
                    controllersMutable.remove(at: index)
                }
            }
        }
        return controllersMutable
    }
}

