//
//  UILabel+Message.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 04/14/2018.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

extension UILabel {
    var attributes: EKProperty.Label {
        set {
            font = newValue.font
            textColor = newValue.color
        }
        get {
            return EKProperty.Label(font: font, color: textColor)
        }
    }
    
    var labelContent: EKProperty.LabelContent {
        set {
            text = newValue.text
            font = newValue.style.font
            textColor = newValue.style.color
        }
        get {
            return EKProperty.LabelContent(text: text ?? "", style: EKProperty.Label(font: font, color: textColor))
        }
    }
}

extension UIButton {
    var buttonContent: EKProperty.ButtonContent {
        set {
            setTitle(newValue.label.text, for: .normal)
            setTitleColor(newValue.label.style.color, for: .normal)
            titleLabel?.font = newValue.label.style.font
            backgroundColor = newValue.backgroundColor
        }
        get {
            let text = title(for: .normal)
            let color = titleColor(for: .normal)!
            return EKProperty.ButtonContent(label: EKProperty.LabelContent(text: text!, style: EKProperty.Label(font: titleLabel!.font, color: color)), backgroundColor: backgroundColor!)
        }
    }
}
