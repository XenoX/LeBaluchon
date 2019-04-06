//
//  CurrencyController.swift
//  LeBaluchon
//
//  Created by XenoX on 06/04/2019.
//  Copyright © 2019 XenoX. All rights reserved.
//

import Foundation
import UIKit

class CurrencyController: UIViewController {
    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet weak var valueTextField: UITextField!

    private var currencyRate: Float = 1.2
    private var lastValue: Float = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        CurrencyService.shared.getCurrency { (success, currency) in
            guard success, let currency = currency, currency.rates["USD"] != nil else {
                return self.presentAlert()
            }

            self.currencyRate = currency.rates["USD"]!
        }
    }

    @IBAction func didEndEditValue() {
        updateResultTextField()
    }

    private func updateResultTextField() {
        guard valueTextField.text!.isEmpty == false, let value = Float(valueTextField.text!), value != lastValue else {
            return
        }

        resultTextView.text = "\(resultTextView.text!)\(Int(value)) € = \(value * currencyRate) $\n"
        lastValue = value
    }
}

// MARK: - Keyboard
extension CurrencyController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        valueTextField.resignFirstResponder()
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height - (self.tabBarController?.tabBar.frame.size.height)!
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

// MARK: - Alert
extension CurrencyController {
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "An error occured, please retry.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
