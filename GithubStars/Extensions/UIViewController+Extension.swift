//
//  UIViewController+Extension.swift
//  GithubStars
//
//  Created by Jaafar Barek on 4/5/19.
//  Copyright © 2019 Jaafar Barek. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {
    
    static func topMostController() -> UIViewController {
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        var topController: UIViewController = delegate!.window!.rootViewController!
        for _ in 0..<2 {
            while topController.presentedViewController != nil && topController.presentedViewController?.isKind(of: UIAlertController.self) == false {
                topController = topController.presentedViewController!
            }
            if (topController.isKind(of: UITabBarController.self)) {
                topController = ((topController as! UITabBarController)).selectedViewController!
            }
            if (topController.isKind(of: UINavigationController.self)) {
                topController = ((topController as! UINavigationController)).topViewController!
            }
        }
        return topController
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func closeTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    func show(viewController: UIViewController, completion: (() -> Void)? = nil) {
        if let nc = navigationController {
            nc.pushViewController(viewController, animated: true)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.31) {
                completion?()
            }
        } else {
            viewController.addCloseButton()
            let nc = UINavigationController(rootViewController: viewController)
            present(nc, animated: true, completion: completion)
        }
    }
    
    func presentModally(viewController: UIViewController, completion: (() -> Void)? = nil) {
        viewController.addCloseButton()
        let nc = UINavigationController(rootViewController: viewController)
        present(nc, animated: true, completion: completion)
    }
    
    func dismiss() {
        if let nc = navigationController {
            nc.popViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func dismissToRoot() {
        if let nc = navigationController {
            nc.popToRootViewController(animated: true)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    func addCloseButton() {
        let closeButtonItem = UIBarButtonItem(image: UIImage(named: "icon-delete"), style: .plain, target: self, action: #selector(UIViewController.closeTapped))
        navigationItem.leftBarButtonItem = closeButtonItem
    }
    
    func showSafariVC(url: URL, completion: (() -> Void)? = nil) -> SFSafariViewController {
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: completion)
        return safariVC
    }
}

