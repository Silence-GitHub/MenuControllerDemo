//
//  NextResponderVC.swift
//  MenuControllerDemo
//
//  Created by Kaibo Lu on 2017/5/5.
//  Copyright © 2017年 Kaibo Lu. All rights reserved.
//

import UIKit

class NextResponderVC: UIViewController {

    var textView: CustomResponderTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        
        view.backgroundColor = .groupTableViewBackground
        
        let button = ShowMenuButton(frame: CGRect(x: 10, y: 64, width: 100, height: 50))
        button.backgroundColor = .green
        button.setTitle("Show menu", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(showMenuButtonClicked(_:)), for: .touchUpInside)
        view.addSubview(button)
        
        textView = CustomResponderTextView(frame: CGRect(x: 10, y: 200, width: 300, height: 300))
        textView.text = "Text view"
        view.addSubview(textView)
    }
    
    @objc private func showMenuButtonClicked(_ button: UIButton) {
        if textView.isFirstResponder {
            textView.overrideNext = button
            // Observe "will hide" to do some cleanup
            // Do not use "did hide" which is not fast enough
            NotificationCenter.default.addObserver(self, selector: #selector(menuControllerWillHide), name: Notification.Name.UIMenuControllerWillHideMenu, object: nil)
        } else {
            button.becomeFirstResponder()
        }
        let menu = UIMenuController.shared
        let customItem = UIMenuItem(title: "Custom item", action: #selector(customItemDidSelect))
        menu.menuItems = [customItem]
        menu.setTargetRect(button.frame, in: view)
        menu.setMenuVisible(true, animated: true)
    }
    
    func customItemDidSelect() {
        print(#function)
    }
    
    @objc private func keyboardWillShow() {
        // Prevent custom menu item displaying in text view
        UIMenuController.shared.menuItems = nil
    }
    
    @objc private func menuControllerWillHide() {
        textView.overrideNext = nil
        UIMenuController.shared.menuItems = nil // Prevent custom menu items displaying in text view
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIMenuControllerWillHideMenu, object: nil)
    }

}
