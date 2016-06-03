//
//  UIView+Extension.swift
//  Utils
//
//  Created by Mykola Denysyuk on 6/3/16.
//  Copyright © 2016 Mykola Denysyuk. All rights reserved.
//

import UIKit

/** Load nib */
extension UIView {
    
    public class func loadFromNib(nibName:String?=nil) -> Self {
        let aNibName:String = nibName == nil ? String(self) : nibName!
        return _instance(aNibName)
    }
    
    private class func _instance<T>(nibName:String) -> T {
        let bundle = resourcesBundle()
        if let view = bundle.loadNibNamed(nibName, owner: nil, options: nil).first {
            return view as! T
        }
        fatalError("There is no view with nib name \(nibName) inside PeopleComponent")
    }
}