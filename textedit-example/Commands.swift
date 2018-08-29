//
//  Commands.swift
//  textedit-example
//
//  Created by Aleksandr Zhuravlev on 28/08/2018.
//  Copyright © 2018 Aleksandr Zhuravlev. All rights reserved.
//

import Foundation
import UIKit

protocol Command {
    func execute()
    func undo()
}

class TraitsToggleCommand: Command {
    weak var textView: UITextView?
    let traits: UIFontDescriptorSymbolicTraits
    init(receiver: UITextView?, traits: UIFontDescriptorSymbolicTraits) {
        textView = receiver
        self.traits = traits
    }
    
    func execute() {
        guard let textView = textView else {
            return
        }
        textView.font = textView.font?.copyWithToggled(traits: traits)
    }
    
    func undo() {
        execute()
    }
    
}
