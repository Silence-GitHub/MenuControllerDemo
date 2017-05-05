//
//  ShowMenuButton.swift
//  MenuControllerDemo
//
//  Created by Kaibo Lu on 2017/5/5.
//  Copyright © 2017年 Kaibo Lu. All rights reserved.
//

import UIKit

class ShowMenuButton: UIButton {

    // Return true so that menu controller can display
    override var canBecomeFirstResponder: Bool { return true }
    
    // Return true to show menu for given action
    // Action is in UIResponderStandardEditActions
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return action == #selector(copy(_:))
    }
    
    override func copy(_ sender: Any?) {
        print(#function)
    }

}
