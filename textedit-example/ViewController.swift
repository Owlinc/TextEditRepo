//
//  ViewController.swift
//  textedit-example
//
//  Created by Aleksandr Zhuravlev on 28/08/2018.
//  Copyright © 2018 Aleksandr Zhuravlev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44.0))
        toolbar.items = [
            UIBarButtonItem(image: UIImage(named: "bold"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(toggleBold)),
            UIBarButtonItem(image: UIImage(named: "italic"), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(toggleItalic)),
        
        ]
        textView?.inputAccessoryView = toolbar
    }
    
    @objc func toggleItalic() {
        textView?.font = textView?.font?.copyWithToggled(traits: .traitItalic)
    }
    
    @objc func toggleBold() {
        textView?.font = textView?.font?.copyWithToggled(traits: .traitBold)
    }
    
}
