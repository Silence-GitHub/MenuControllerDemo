//
//  KeyInputVC.swift
//  MenuControllerDemo
//
//  Created by Kaibo Lu on 2017/5/5.
//  Copyright © 2017年 Kaibo Lu. All rights reserved.
//

import UIKit

class KeyInputVC: UIViewController, KeyInputButtonDelegate {

    var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .groupTableViewBackground
        
        let button = KeyInputButton(frame: CGRect(x: 10, y: 64, width: 100, height: 50))
        button.delegate = self
        button.backgroundColor = .green
        button.setTitle("Show menu", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(showMenuButtonClicked(_:)), for: .touchUpInside)
        view.addSubview(button)
        
        textView = UITextView(frame: CGRect(x: 10, y: 200, width: 300, height: 300))
        textView.text = "Text view"
        view.addSubview(textView)
    }
    
    @objc private func showMenuButtonClicked(_ button: UIButton) {
        button.becomeFirstResponder()
        
        NotificationCenter.default.addObserver(self, selector: #selector(menuControllerWillHide), name: Notification.Name.UIMenuControllerWillHideMenu, object: nil)
        
        let menu = UIMenuController.shared
        let customItem = UIMenuItem(title: "Custom item", action: #selector(customItemDidSelect))
        menu.menuItems = [customItem]
        menu.setTargetRect(button.frame, in: view)
        // Display immediately may disappear soon, so display after a little time
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { 
            menu.setMenuVisible(true, animated: true)
        }
    }
    
    func customItemDidSelect() {
        print(#function)
    }
    
    @objc private func menuControllerWillHide() {
        UIMenuController.shared.menuItems = nil // Prevent custom menu items displaying in text view
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIMenuControllerWillHideMenu, object: nil)
    }
    
    // MARK: - KeyInputButtonDelegate
    
    func keyInputButtonHasText(_ button: KeyInputButton) -> Bool {
        return textView.hasText
    }
    
    func keyInputButton(_ button: KeyInputButton, didInsertText text: String) {
        textView.insertText(text)
    }
    
    func keyInputButtonDidDeleteBackward(_ button: KeyInputButton) {
        textView.deleteBackward()
    }

}
