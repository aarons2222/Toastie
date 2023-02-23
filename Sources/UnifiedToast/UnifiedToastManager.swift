//
//  File.swift
//  
//
//  Created by Aaron Strickland on 23/02/2023.
//


import Foundation
import UIKit
import SwiftUI

@available(iOS 15.0, *)
public class UnifiedToastManager {
    
   public static func showUnifiedToast(type: UnifiedToastStyle, title: String, message: String, in viewController: UIViewController) {
        let toastView = UnifiedToastView(type: type, title: title, message: message)
        let toastViewController = UIHostingController(rootView: toastView)
        toastViewController.view.backgroundColor = UIColor.clear
        toastViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        viewController.addChild(toastViewController)
        viewController.view.addSubview(toastViewController.view)
        
        // Set up constraints for the toast view
        NSLayoutConstraint.activate([
            toastViewController.view.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            toastViewController.view.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            toastViewController.view.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        // Add the top constraint after the top layout guide has been set up
        let topConstraint = toastViewController.view.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor, constant: -80)
        NSLayoutConstraint.activate([topConstraint])
        
        // Layout the view hierarchy before animating the toast view
        viewController.view.layoutIfNeeded()
        
        // Animate the toast view sliding up
        UIView.animate(withDuration: 0.5, animations: {
            topConstraint.constant = 0
            viewController.view.layoutIfNeeded()
        }) { _ in
            // Use a DispatchQueue to introduce a delay before animating the toast view sliding down
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                // Animate the toast view sliding down
                topConstraint.constant = -80
                UIView.animate(withDuration: 1.0, animations: {
                }) { _ in
                    toastViewController.willMove(toParent: nil)
                    toastViewController.view.removeFromSuperview()
                    toastViewController.removeFromParent()
                }
            }
        }
    }
}

