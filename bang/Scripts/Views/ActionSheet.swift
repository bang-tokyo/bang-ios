//
//  ActionSheet.swift
//  bang
//
//  Created by Yoshikazu Oda on 2015/08/28.
//  Copyright (c) 2015年 Yoshikazu Oda. All rights reserved.
//

import Foundation
import Bolts

struct ActionSheet {
    typealias Handler = (Void) -> (Void)

    struct Action {
        let title: String
        let style: UIAlertActionStyle
        let handler: Handler?
    }

    class Builder {
        private(set) var actions: [Action] = []

        func show() -> BFTask {
            return ActionSheet.show(actions)
        }

        func defaultStyle(title: String, _ handler: Handler?) -> Builder {
            return build(title, .Default, handler)
        }

        func cancelStyle(title: String, _ handler: Handler?) -> Builder {
            return build(title, .Cancel, handler)
        }

        func destructiveStyle(title: String, _ handler: Handler?) -> Builder {
            return build(title, .Destructive, handler)
        }

        private func build(title: String, _ style: UIAlertActionStyle, _ handler: Handler?) -> Builder {
            actions.append(Action(title: title, style: style, handler: handler))
            return self
        }
    }

    static func show(actions: [Action]) -> BFTask {
        ProgressHUD.hide()

        let completionSource = BFTaskCompletionSource()

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)

        for action in actions {
            let alertAction = UIAlertAction(title: action.title, style: action.style, handler: { _ in
                action.handler?()
                completionSource.setResult(true)
            })
            alertController.addAction(alertAction)
        }

        if let top = currentTopViewController() {
            top.presentViewController(alertController, animated: true, completion: nil)
        } else {
            BFTask(error: Error.create())
        }

        return completionSource.task
    }
}
