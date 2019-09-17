//
//  UIViewController+showError.swift
//  StudyBook
//
//  Created by Евгений Сивицкий on 17/09/2019.
//  Copyright © 2019 Евгений Сивицкий. All rights reserved.
//

import UIKit

extension UIViewController {
    func showError(errorDescription: String) {
        let alertController = UIAlertController(title: "Ошибка", message: errorDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
