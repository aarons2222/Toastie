//
//  UnifiedToastManager.swift
//
//  Created by Aaron Strickland on 22/02/2023.
//

import Foundation
import UIKit
import SwiftUI

@available(iOS 15.0, *)
public class UnifiedToastManager {

    static var toastViewController: UIHostingController<UnifiedToastView>?

    public static func showUnifiedToast(type: UnifiedToastStyle, title: String, message: String, in viewController: UIViewController) {
        
        DispatchQueue.main.async {
            
            
        let toastView = UnifiedToastView(type: type, title: title, message: message)
        let shouldAnimate = toastViewController == nil

        if toastViewController == nil {
            toastViewController = UIHostingController(rootView: toastView)
            toastViewController!.view.backgroundColor = UIColor.clear
            toastViewController!.view.translatesAutoresizingMaskIntoConstraints = false

            viewController.addChild(toastViewController!)
            viewController.view.addSubview(toastViewController!.view)
        } else {
            toastViewController!.rootView = toastView
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
                    toastViewController!.view.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
                    toastViewController!.view.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
                    toastViewController!.view.heightAnchor.constraint(equalToConstant: requiredHeight),
                ])

                // Add the top constraint after the top layout guide has been set up
                let topConstraint = toastViewController!.view.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor, constant: -requiredHeight)
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
                            toastViewController!.willMove(toParent: nil)
                            toastViewController!.view.removeFromSuperview()
                            toastViewController!.removeFromParent()
                            toastViewController = nil
                        }
                    }
                }
            }
        }
    }
}
