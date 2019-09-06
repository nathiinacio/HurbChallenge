//
//  Extentions.swift
//  HurbChallenge
//
//  Created by Nathalia Inacio on 01/09/19.
//  Copyright © 2019 Nathalia Inacio. All rights reserved.

import UIKit

extension UIColor {
    static let paletteBlue = UIColor(red:62.0/255.0, green: 102.0/255.0, blue: 228.0/255.0, alpha: 1.0)
    static let palettePink = UIColor(red:255.0/255.0, green: 98.0/255.0, blue: 98.0/255.0, alpha: 1.0)
    static let paletteYellow = UIColor(red:225.0/255.0, green: 193.0/255.0, blue: 28.0/255.0, alpha: 1.0)
    static let paletteGreen = UIColor(red:187.0/255.0, green: 196.0/255.0, blue: 66.0/255.0, alpha: 1.0)
    static let paletteLightGray = UIColor(red:224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1.0)
    static let paletteDarkGray = UIColor(red:59.0/255.0, green: 61.0/255.0, blue: 66.0/255.0, alpha: 1.0)

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
