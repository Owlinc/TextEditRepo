//
//  ViewController.swift
//  textedit-example
//
//  Created by Aleksandr Zhuravlev on 28/08/2018.
//  Copyright © 2018 Aleksandr Zhuravlev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var executedCommands:[Command] = []
    @IBOutlet weak var textView: UITextView?
    
    var state: ViewControllerState!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        state = ViewControllerStateCommon(viewController: self)
        
        let toolbar = UIToolbar(
            frame: CGRect(
                x: 0,
                y: 0,
                width: UIScreen.main.bounds.width,
                height: 44.0))
        
        toolbar.items = [
            UIBarButtonItem(
                image: UIImage(named: "bold"),
                landscapeImagePhone: nil, style: .plain,
                target: self,
                action: #selector(toggleBold)),
            UIBarButtonItem(
                image: UIImage(named: "italic"),
                landscapeImagePhone: nil,
                style: .plain, target: self,
                action: #selector(toggleItalic)),
            UIBarButtonItem(
                image: UIImage(named: "plusIcon"),
                landscapeImagePhone: nil, style: .plain,
                target: self,
                action: #selector(increaseFontSize)),
            UIBarButtonItem(
                image: UIImage(named: "minusIcon"),
                landscapeImagePhone: nil,
                style: .plain, target: self,
                action: #selector(increaseFont))]
        
        textView?.inputAccessoryView = toolbar
        
        self.becomeFirstResponder()
    }
   
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        guard event?.subtype == .motionShake else {
            return
        }
        self.undoLastCommand()
    }
    
    
    func execute(command: Command) {
        executedCommands.append(command)
        command.execute()
    }
    
    func undoLastCommand() {
        let c = executedCommands.popLast()
        c?.undo()
    }
    
    @objc func toggleItalic() {
        state.toggleItalic()
    }
    
    @objc func toggleBold() {
        state.toggleBold()
    }
    
    @objc func plusFontSize() {
        state.increaseFontSize()
    }
    
    @objc func minusFontSize() {
        state.increaseFont()
    }
    
    
}
