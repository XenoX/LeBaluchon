//
//  TranslateController.swift
//  LeBaluchon
//
//  Created by XenoX on 07/04/2019.
//  Copyright © 2019 XenoX. All rights reserved.
//

import UIKit

class TranslateController: UIViewController {
    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet weak var valueTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardObserver()
    }

    @IBAction func didTapTranslateButton() {
        TranslateService.shared.getTranslation(for: valueTextView.text!, callback: { (success, translate) in
            guard success, let translate = translate else {
                return self.presentAPIErrorAlert()
            }

            self.updateResultTextView(with: translate.data.translations[0].translatedText)
        })
    }

    private func updateResultTextView(with result: String) {
        guard valueTextView.text!.isEmpty == false, let value = valueTextView.text else {
            return
        }

        resultTextView.text = "\(resultTextView.text!)🇫🇷\(value)\n🇬🇧\(result)\n\n"
        valueTextView.text = ""
    }
}

// MARK: - Keyboard
extension TranslateController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        valueTextView.resignFirstResponder()
    }
}
