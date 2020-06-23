//
//  UIViewController.swift
//  LSAssesment
//
//  Created by M.J. on 23.06.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

private var controllerKeyAssociationKey: UInt8 = 0
private var forcedByNavigationManagerAssociationKey: UInt8 = 2

extension UIViewController {
    var controllerKey: ControllerKey? {
        get {
            return objc_getAssociatedObject(self, &controllerKeyAssociationKey) as? ControllerKey
        }
        set(newValue) {
            objc_setAssociatedObject(self, &controllerKeyAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }

    var forcedByNavigationManager: Bool {
        get {
            let value = objc_getAssociatedObject(self, &forcedByNavigationManagerAssociationKey) as? NSNumber

            return (value?.boolValue)!
        }
        set(newValue) {
            objc_setAssociatedObject(self, &forcedByNavigationManagerAssociationKey,
                                     NSNumber(value: newValue as Bool), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}

