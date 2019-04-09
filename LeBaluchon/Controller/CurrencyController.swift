//
//  CurrencyController.swift
//  LeBaluchon
//
//  Created by XenoX on 06/04/2019.
//  Copyright © 2019 XenoX. All rights reserved.
//

import UIKit

class CurrencyController: UIViewController {
    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet weak var valueTextField: UITextField!

    private var currencyRate: Float = 1.2
    private var lastValue: Float = 0.0

    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardObserver()

        CurrencyService.shared.getCurrency { (success, currency) in
            guard success, let currency = currency, currency.rates["USD"] != nil else {
                return self.presentAPIErrorAlert()
            }

            self.currencyRate = currency.rates["USD"]!
        }
    }

    @IBAction func didEndEditValue() {
        updateResultTextView()
    }

    private func updateResultTextView() {
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
}
