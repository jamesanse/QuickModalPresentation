//
//  ModalAnimationEnum.swift
//  modalTransitionTest
//
//  Created by James An on 12/17/15.
//  Copyright © 2015 Jamesan. All rights reserved.
//

import Foundation
import UIKit 

public enum AnimationStyle{
    
    typealias animation = (UIView,((Bool) -> Void)?)->Void
    
    case standard
    case fade
    case shrink
    case rotate
    
    
    internal func getPresentationAnimation() -> animation{
        
        switch self{
        case .standard:
            
            return standardPresentationAnimation
            
        case .fade:
            return fadePresentationAnimation
            
        case .shrink:
            return shrinkPresentationAnimation
            
        case .rotate:
            return rotatePresentationAnimation
            
        }
    }
    
    
    
    internal func getDismissalAnimation()-> animation{
        
        switch self{
        case .standard:
            
            return standardDismissalAnimation
            
        case .fade:
            return fadeDismissalAnimation
            
        case .shrink:
            return shrinkDismissalAnimation
            
        case .rotate:
            return rotateDismissalAnimation
            
        }
        
    }
    
    
    private func standardPresentationAnimation(view:UIView,completion: ((Bool) -> Void)?){
        
        view.layer.position.x = UIScreen.getScreenWidth()/2
        view.layer.position.y = -UIScreen.getScreenHeight()
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .AllowUserInteraction, animations: {

            view.layer.position.y = UIScreen.getScreenHeight()/2
            view.layer.position.x = UIScreen.getScreenWidth()/2
            
            }, completion: completion)
        
        
        
    }
    
    
    private func fadePresentationAnimation(view:UIView,completion: ((Bool) -> Void)?){
        
        view.layer.position.y = UIScreen.getScreenHeight()/2
        view.layer.position.x = UIScreen.getScreenWidth()/2
        view.alpha = 0
        
        UIView.animateWithDuration(1, animations: {
            
            view.alpha = 1
            
            }, completion: completion)
        
        
        
    }
    
    private func rotatePresentationAnimation(view:UIView,completion: ((Bool) -> Void)?){
        
        view.layer.position.y = UIScreen.getScreenHeight()/2
        view.layer.position.x = -UIScreen.getScreenWidth()/2
        view.layer.transform = CATransform3DRotate(view.layer.transform, CGFloat(M_PI), 0, 0, 1)
        UIView.animateWithDuration(1.5, delay: 0, usingSpringWithDamping: 0.25, initialSpringVelocity: 0, options: .AllowUserInteraction, animations: {
            
            view.layer.transform = CATransform3DRotate(view.layer.transform, CGFloat(5*M_PI), 0, 0, 1)
            view.layer.position.x = UIScreen.getScreenWidth()/2
            
            }, completion: completion)
        
        
        
    }
    
    private func shrinkPresentationAnimation(view:UIView,completion: ((Bool) -> Void)?){
        
        
        view.layer.position.y = UIScreen.getScreenHeight()/2
        view.layer.position.x = UIScreen.getScreenWidth()/2
        view.layer.transform = CATransform3DMakeScale(0, 0, 0)
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.45, initialSpringVelocity: 0, options: .AllowUserInteraction, animations: {
            
            view.layer.transform = CATransform3DIdentity
            
            }, completion: completion)
    }
    
    
    
    private func standardDismissalAnimation(view:UIView,completion: ((Bool) -> Void)?){
        
        UIView.animateWithDuration(1, animations: {
            
            view.layer.position.y += UIScreen.getScreenHeight()
            
            }, completion: completion)

        
    }
    private func fadeDismissalAnimation(view:UIView,completion: ((Bool) -> Void)?){
        
        UIView.animateWithDuration(1, animations: {
            
            view.alpha = 0
            
            }, completion: completion)
        
    }
    private func shrinkDismissalAnimation(view:UIView,completion: ((Bool) -> Void)?){
        
        view.layer.transform = CATransform3DIdentity
        UIView.animateWithDuration(1, animations: {
            
            view.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0)
            
            }, completion: completion)
        
    }
    private func rotateDismissalAnimation(view:UIView,completion: ((Bool) -> Void)?){
        
        
        
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 0.45, initialSpringVelocity: 0, options: .AllowUserInteraction, animations: {
            
            view.layer.position.x += UIScreen.getScreenWidth()
            view.layer.transform = CATransform3DRotate(view.layer.transform, CGFloat(M_PI), 0, 0, 1)
            
            }, completion: completion)

        
    }
}

extension UIScreen {
  
    class func getScreenSize() -> CGRect {
        
        return UIScreen.mainScreen().bounds
        
    }

    class func getScreenHeight() -> CGFloat {
        
        let bound = getScreenSize()
        return bound.size.height
        
    }
    
    class func getScreenWidth() -> CGFloat {
        
        let bound = getScreenSize()
        return bound.size.width
        
    }
    
}

