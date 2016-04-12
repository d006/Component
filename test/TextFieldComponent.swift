//
//  TextFieldComponent.swift
//  test
//
//  Created by doriswu on 2016/4/2.
//  Copyright © 2016年 doriswu. All rights reserved.
//

import Foundation

import UIKit

class TextFieldComponent: UITextField, UITextFieldDelegate {
    
    let space = 2.0
    var bgcolor: UIColor = UIColor(red: 237/255, green: 244/255, blue: 250/255, alpha: 1)
    var textcolor: UIColor = UIColor(red: 92/255, green: 158/255, blue: 206/255, alpha: 1)
    var count: Int = 0
    var isHideText: Bool = true
    var editIdx1: Int = 0
    var editIdx2: Int = 0
    var lbarr: [UILabel] = []
    
    @IBInspectable var wordsCount: Int = 0 {
        
        didSet {
            
            count = wordsCount
        }
    }
    @IBInspectable var isPassword: Bool = true {
        
        didSet {
            
            isHideText = isPassword
        }
    }
    
    override func drawRect(rect: CGRect) {
        
        self.textColor = UIColor(white: 1, alpha: 0.0)
        
        let width = (Double(self.frame.width) - Double(count) * space) / Double(count)
        
        let squareWidth = Double(self.frame.size.height) > width ? width : Double(self.frame.size.height)
        
        // adjust to center
        let startX = (Double(self.frame.size.width)
            - Double(count) * squareWidth
            - (Double(count) - 1) * space)
            / 2

        for i in 0..<count {
            
            let x = startX + Double(i) * (space + squareWidth)
            
            let label = UILabel(frame: CGRect(x: x, y: 0, width:squareWidth , height:squareWidth))
            let line = UILabel(frame: CGRect(x: 0, y: squareWidth, width:squareWidth , height:2))
            line.backgroundColor = textcolor
            label.backgroundColor = bgcolor
            label.textColor = textcolor
            label.textAlignment = .Center
            label.numberOfLines = 0
            label.minimumScaleFactor = 0.1
            label.font = UIFont.systemFontOfSize(100)
            label.adjustsFontSizeToFitWidth = true
            label.addSubview(line)
            self.addSubview(label)
            lbarr.append(label)
        }
    }
    
    override func caretRectForPosition(position: UITextPosition) -> CGRect {
        return CGRectZero
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
        self.addTarget(self, action: #selector(TextFieldComponent.textFieldDidChangeEditing), forControlEvents: .EditingChanged)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= count
    }
    
    func textFieldDidChangeEditing() {
        
        guard (self.text != nil) else { return }
        
        let str = self.text! as NSString
        
        // according to text length to change symbol
        
        var symbol = "✻"
        
        for i in 0..<count {
            
            let lb = lbarr[i]
            
            if i < self.text?.characters.count {
                
                
                if !isHideText {
                    
                    symbol = str.substringWithRange(NSRange(location: i, length: 1))
                }
                
                print("str:\(str), loc:\(i), symbol:\(symbol)")
                
            } else {
                symbol = ""
            }
            
            lb.text = symbol
        }
    }
}
