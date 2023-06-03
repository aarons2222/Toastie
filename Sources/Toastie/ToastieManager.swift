//
//  UnifiedToastManager.swift
//
//  Created by Aaron Strickland on 22/02/2023.
//

import Foundation
import UIKit
import SwiftUI

@available(iOS 15.0, *)
public class ToastieManager {

    static var toastieViewController: UIHostingController<ToastieView>?

    public static func showToastie(type: ToastieStyle, title: String, message: String, in viewController: UIViewController) {
        
        DispatchQueue.main.async {
            
            
        let toastView = ToastieView(type: type, title: title, message: message)
        let shouldAnimate = toastieViewController == nil

        if toastieViewController == nil {
            toastieViewController = UIHostingController(rootView: toastView)
            toastieViewController!.view.backgroundColor = UIColor.clear
            toastieViewController!.view.translatesAutoresizingMaskIntoConstraints = false

            viewController.addChild(toastieViewController!)
            viewController.view.addSubview(toastieViewController!.view)
        } else {
            toastieViewController!.rootView = toastView
        }

  
            if shouldAnimate {
                // Calculate the required height of the toast view based on the size of the text
                let font = UIFont.systemFont(ofSize: 14)
                let contentWidth = viewController.view.frame.width - 32 // Subtracting padding on both sides
                let titleHeight = title.boundingRect(with: CGSize(width: contentWidth, height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil).height
                let messageHeight = message.boundingRect(with: CGSize(width: contentWidth, height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil).height
                let requiredHeight = titleHeight + messageHeight + 32 // Add some extra padding

                // Set up constraints for the toast view
                NSLayoutConstraint.activate([
                    toastieViewController!.view.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
                    toastieViewController!.view.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
                    toastieViewController!.view.heightAnchor.constraint(equalToConstant: requiredHeight),
                ])

                // Add the top constraint after the top layout guide has been set up
                let topConstraint = toastieViewController!.view.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor, constant: -requiredHeight)
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
                        topConstraint.constant = -requiredHeight
                        UIView.animate(withDuration: 1.0, animations: {
                        }) { _ in
                            toastieViewController!.willMove(toParent: nil)
                            toastieViewController!.view.removeFromSuperview()
                            toastieViewController!.removeFromParent()
                            toastieViewController = nil
                        }
                    }
                }
            }
        }
    }
}
