//
//  UIViewController++.swift
//  Memo
//
//  Created by 곽다은 on 2/25/25.
//

import UIKit

extension UIViewController {
    func createTextFieldAlert(
        title: String,
        placeholder: String,
        confirmActionTitle: String,
        cancelActionTitle: String = AlertConstants.cancelActionTitle,
        confirmHandler: @escaping (String) -> ()
    ) -> UIAlertController {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addTextField { $0.placeholder = placeholder }
        
        let confirmAction = UIAlertAction(title: confirmActionTitle,  style: .default) { _ in
            guard let content = alert.textFields?.first?.text, !content.isEmpty else { return }
            confirmHandler(content)
        }
        let cancelAction = UIAlertAction(title: cancelActionTitle, style: .cancel)
        
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        return alert
    }
}
