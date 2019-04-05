//
//  UIStoryboard+Extension.swift
//  GithubStars
//
//  Created by Jaafar Barek on 4/5/19.
//  Copyright © 2019 Jaafar Barek. All rights reserved.
//

import UIKit

public enum Storyboard: String {
    case Main
    
    public func instantiate<VC: UIViewController>(_ viewController: VC.Type, storyboardIdentifier: String? = nil) -> VC {
        guard
            let vc = UIStoryboard(name: self.rawValue, bundle: nil)
                .instantiateViewController(withIdentifier: storyboardIdentifier ?? VC.storyboardIdentifier) as? VC
            else { fatalError("Couldn't instantiate \(VC.storyboardIdentifier) from \(self.rawValue)") }
        
        return vc
    }
    
    public func instantiateInitialVC() -> UIViewController {
        
        guard let vc = UIStoryboard(name: self.rawValue, bundle: nil).instantiateInitialViewController() else {
            fatalError("Couldn't instantiate initial viewcontroller from \(self.rawValue)")
        }
        
        return vc
    }
}

extension UIStoryboard {
    
    public convenience init(name: String? = nil) {
        self.init(name: name ?? "Main", bundle: nil)
    }
}

extension UIViewController {
    
    class func instantiate(storyboard: Storyboard = .Main, storyboardIdentifier: String? = nil) -> Self {
        return storyboard.instantiate(self, storyboardIdentifier: storyboardIdentifier)
    }
    
    public static var defaultNib: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }
    
    public static var storyboardIdentifier: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }
}

