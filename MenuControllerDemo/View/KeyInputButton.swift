//
//  KeyInputButton.swift
//  MenuControllerDemo
//
//  Created by Kaibo Lu on 2017/5/5.
//  Copyright © 2017年 Kaibo Lu. All rights reserved.
//

import UIKit

protocol KeyInputButtonDelegate: class {
    func keyInputButtonHasText(_ button: KeyInputButton) -> Bool
    func keyInputButton(_ button: KeyInputButton, didInsertText text: String)
    func keyInputButtonDidDeleteBackward(_ button: KeyInputButton)
}

class KeyInputButton: UIButton, UIKeyInput {

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
    
    // MARK: - UIKeyInput
    
    weak var delegate: KeyInputButtonDelegate?
    
    var hasText: Bool {
        if let d = delegate {
            return d.keyInputButtonHasText(self)
        }
        return false
    }
    
    // SOGOU, system English, system emoji input method work
    // System Chinese input method typing some characters dose not call this method (but some characters call, e.g "\n" and " ")
    func insertText(_ text: String) {
        delegate?.keyInputButton(self, didInsertText: text)
    }
    
    func deleteBackward() {
        delegate?.keyInputButtonDidDeleteBackward(self)
    }

}
