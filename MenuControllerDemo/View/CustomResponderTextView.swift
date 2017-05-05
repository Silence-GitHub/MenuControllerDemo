//
//  CustomResponderTextView.swift
//  MenuControllerDemo
//
//  Created by Kaibo Lu on 2017/5/5.
//  Copyright © 2017年 Kaibo Lu. All rights reserved.
//

import UIKit

class CustomResponderTextView: UITextView {

    weak var overrideNext: UIResponder?
    
    override var next: UIResponder? {
        if let responder = overrideNext { return responder }
        return super.next
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if overrideNext != nil { return false }
        return super.canPerformAction(action, withSender: sender)
    }

}
