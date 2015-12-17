//
//  ModalVCPresenter.swift
//  gif maker
//
//  Created by James An on 11/30/15.
//  Copyright © 2015 Jamesan. All rights reserved.
//

import UIKit

public extension UIViewController {
 
    public func presentAnimtedViewController(presented:UIViewController,frame:CGRect,style:AnimationStyle ) -> ModalVCPresenter {
    
          let vcPresenter = ModalVCPresenter(presenting: self, presented: presented, containerFrame: frame)
          vcPresenter.state = .presenting
          vcPresenter.style = style
          vcPresenter.present()
        
         return vcPresenter
    }
}

public class ModalVCPresenter: NSObject {

    
    deinit{
        print("modal presenter deallocated")
    }
    
    public enum PresentationState{
        case presenting
        case dismissing
    }
    
    public var state = PresentationState.presenting
    public var style = AnimationStyle.standard
    private weak var presentingVC : UIViewController?
    private weak var presentedVC : UIViewController?
    private lazy var presentationController : CustomPresentationController? = {
        guard let _ = self.presentingVC, _ = self.presentedVC else{
            return nil
        }
        let customPresenter = CustomPresentationController(presentedViewController: self.presentedVC!, presentingViewController: self.presentingVC!)
        return customPresenter
    
    }()
    init(presenting:UIViewController,presented:UIViewController,containerFrame:CGRect){
        super.init()
        self.presentedVC = presented
        self.presentingVC = presenting
        self.presentationController?.framesOfPresentedView = containerFrame
        
    }
    
    public func present(){
    
        guard let _ = presentingVC, _ = presentedVC, _ = presentationController else{
             return
        }
        presentedVC!.modalPresentationStyle = .Custom
        presentedVC!.transitioningDelegate = self
        presentingVC!.presentViewController(presentedVC!, animated: true, completion: nil)
        
    }
}

extension ModalVCPresenter : UIViewControllerAnimatedTransitioning {

    
    
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1
    }
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning)  {
        
        switch state{
        case .presenting :
            presentTransition(transitionContext)
        case .dismissing :
            dismissTransition(transitionContext)
        }
        
    }
    
    private func presentTransition(transitionContext: UIViewControllerContextTransitioning){
        
        guard let presentedController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey),presentedControllerView = transitionContext.viewForKey(UITransitionContextToViewKey),containerView = transitionContext.containerView()
            else {
                return
        }
        presentedControllerView.frame = transitionContext.finalFrameForViewController(presentedController)
         containerView.addSubview(presentedControllerView)
          let animation = self.style.getPresentationAnimation()
            animation(presentedController.view){(completed: Bool) -> Void in
            transitionContext.completeTransition(completed)
        }
        
        
    }
    
    private func dismissTransition(transitionContext: UIViewControllerContextTransitioning){
    
        guard let presentedController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) else{
           return
        }
        
        let animation = self.style.getDismissalAnimation()
        
        animation(presentedController.view){(completed: Bool) -> Void in
            presentedController.view.removeFromSuperview()
            transitionContext.completeTransition(completed)
        }
    }
}

extension ModalVCPresenter : UIViewControllerTransitioningDelegate{

    public func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        return presentationController
    }
    
    public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        state = .presenting
        return self
        
    }
    
    public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        state = .dismissing
        return self
    
    }

}

private class CustomPresentationController : UIPresentationController {
 
    var transparencyView : UIVisualEffectView?
    var framesOfPresentedView = CGRect()
    convenience init(presentedViewController: UIViewController, presentingViewController: UIViewController, FrameOfPresentedView:CGRect) {
        
        self.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
        framesOfPresentedView = FrameOfPresentedView
    }
    
    override func presentationTransitionWillBegin() {
        
        transparencyView = UIVisualEffectView(frame: self.containerView!.frame)
        transparencyView?.effect = UIBlurEffect(style:.Light)
        super.presentationTransitionWillBegin()
        guard let _ = presentedView() else{
           return
        }
        if let _ = transparencyView{
            self.presentingViewController.view.addSubview(transparencyView!)
    
        }
        
    }
    
    override func presentationTransitionDidEnd(completed: Bool)  {
        if !completed {
            self.transparencyView?.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin()  {
        if let transitionCoordinator = self.presentingViewController.transitionCoordinator() {
            transitionCoordinator.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
                self.transparencyView?.alpha  = 0.0
                }, completion:nil)
        }
    }
    
    override func dismissalTransitionDidEnd(completed: Bool) {
        if completed {
            self.transparencyView?.removeFromSuperview()
        }
    }
    
    
    private override func frameOfPresentedViewInContainerView() -> CGRect {
        
        return framesOfPresentedView
        
    }
    
}

