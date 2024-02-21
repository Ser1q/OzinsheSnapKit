//
//  TextFieldWithPadding.swift
//  ozinsheSnapKit
//
//  Created by Nuradil Serik on 20.02.2024.
//

import UIKit

class TextFieldWithPadding: UITextField, UITextFieldDelegate{
    
    var padding = UIEdgeInsets(top: 0, left: 42, bottom: 0, right: 16)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
}
