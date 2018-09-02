
import Foundation
import UIKit

protocol ViewControllerState {
    func toggleItalic()
    func toggleBold()
    func increaseFontSize()
    func decreaseFontSize()
    func handleShake()
}

enum TypeOfCommandMethod {
    
    case toggleItalic
    case toggleBold
    case decreaseFontSize
    case increaseFontSize
}

class ViewControllerStatePremium: ViewControllerState {
    
    weak var viewController: ViewController?
    init(viewController: ViewController?) {
        self.viewController = viewController
    }
    let valueToChangeFont: CGFloat = 2
    
    
    // Необходим рефакторинг
    func toggleItalic() {
        guard let viewController = viewController else {
            return
        }
        viewController.execute(
            command: TraitsToggleCommand(
                receiver: viewController.textView,
                traits: .traitItalic))
    }
    
    func toggleBold() {
        guard let viewController = viewController else {
            return
        }
        viewController.execute(
            command: TraitsToggleCommand(
                receiver: viewController.textView,
                traits: .traitBold))
    }
    
    func increaseFontSize() {
        guard let viewController = viewController else {
            return
        }
        viewController.execute(
            command: FontSizeCommand(
                receiver: viewController.textView,
                size: valueToChangeFont))
    }
    
    func decreaseFontSize() {
        guard let viewController = viewController else {
            return
        }
        viewController.execute(
            command: FontSizeCommand(
                receiver: viewController.textView,
                size: -valueToChangeFont))
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
    
    func increaseFontSize() {
        showPayAlert(.increaseFontSize)
    }
    
    func decreaseFontSize() {
        showPayAlert(.decreaseFontSize)
    }
    
    func toggleItalic() {
        showPayAlert(.toggleItalic)
    }
    
    func toggleBold() {
        showPayAlert(.toggleBold)
    }
    
    func handleShake() {}
    
    func showPayAlert(_ method: TypeOfCommandMethod) {
        
        let alert = UIAlertController(
            title: "Только для премиум пользователей",
            message: nil,
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(
            title: "Отмена",
            style: .cancel,
            handler: nil))
        
        alert.addAction(UIAlertAction(
            title: "Оплатить",
            style: .default,
            handler: { [weak self] _ in
                
            guard let viewController = self?.viewController else {
                return
            }
                
                viewController.state = ViewControllerStatePremium(viewController: viewController)
                
                switch method {
                case .toggleItalic:
                    viewController.state.toggleItalic()
                case .toggleBold:
                    viewController.state.toggleBold()
                case .decreaseFontSize:
                    viewController.state.decreaseFontSize()
                case .increaseFontSize:
                    viewController.state.increaseFontSize()
                }
        }))
        
        viewController?.present(alert, animated: true, completion: nil)
    }
}


