//
//  States.swift
//  textedit-example
//
//  Created by Aleksandr Zhuravlev on 28/08/2018.
//  Copyright © 2018 Aleksandr Zhuravlev. All rights reserved.
//

import Foundation
import UIKit

protocol ViewControllerState {
    func toggleItalic()
    func toggleBold()
    func handleShake()
}


class ViewControllerStatePremium: ViewControllerState {
    weak var viewController: ViewController?
    init(viewController: ViewController?) {
        self.viewController = viewController
    }
    
    func toggleItalic() {
        guard let viewController = viewController else {
            return
        }
        viewController.execute(command: TraitsToggleCommand(receiver: viewController.textView, traits: .traitItalic))
    }
    
    func toggleBold() {
        guard let viewController = viewController else {
            return
        }
        viewController.execute(command: TraitsToggleCommand(receiver: viewController.textView, traits: .traitBold))
    }
    
    func handleShake() {
        guard let viewController = viewController else {
            return
        }
        viewController.undoLastCommand()
    }
    
    
}

class ViewControllerStateCommon: ViewControllerState {
    
    weak var viewController: ViewController?
    init(viewController: ViewController?) {
        self.viewController = viewController
    }
    
    func toggleItalic() {
        showPayAlert()
    }
    
    func toggleBold() {
        showPayAlert()
    }
    
    func handleShake() {}
    
    func showPayAlert() {
        let alert = UIAlertController(title: "Только для премиум пользователей", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Оплатить", style: .default, handler: {[weak self] _ in
            guard let viewController = self?.viewController else {
                return
            }
            viewController.state = ViewControllerStatePremium(viewController: viewController)
        }))
        viewController?.present(alert, animated: true, completion: nil)
    }
}
