//
//  LikeAnimator.swift
//  Laith Bayyari
//
//  Created by user169368 on 5/7/20.
//  Copyright © 2020 Laith Bayyari. All rights reserved.
//

import UIKit

class LikeAnimator {
    let container: UIView
    let layoutConstraint: NSLayoutConstraint
    
    init(container: UIView, layoutConstraint: NSLayoutConstraint) {
        self.container = container
        self.layoutConstraint = layoutConstraint
    }
    
    func animate(completion: @escaping () -> Void) {
        layoutConstraint.constant = 100
        print("Woah There Nelly")
        
        UIView.animate(withDuration: 0.7,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 2,
                       options: .curveLinear,
                       animations: { [weak self] in
                self?.container.layoutIfNeeded()
            
        }) { [weak self] (_) in
            self?.layoutConstraint.constant = 0
            
            UIView.animate(withDuration: 0.3) {
                self?.container.layoutIfNeeded()
                completion()
            }
            
            
        }
    }
}
