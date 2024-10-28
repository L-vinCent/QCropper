//
//  CropImageDismissAnimatedTransition.swift
//  QCropper
//
//  Created by admin on 2024/10/28.
//

import Foundation
import UIKit

// 定义协议
public protocol CropImageDismissTransitionHandler: UIViewController {
    var originalImageFrame: CGRect { get }
    func finishClipDismissAnimation()
}


class CropImageDismissAnimatedTransition: NSObject, UIViewControllerAnimatedTransitioning {
    let clipTransTime:TimeInterval = 0.25

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return clipTransTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVC = transitionContext.viewController(forKey: .from) as? CropperViewController else {
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            return
        }
        // 检查 toViewController 是否是 UINavigationController
        let toVC: CropImageDismissTransitionHandler?
        if let navController = transitionContext.viewController(forKey: .to) as? UINavigationController {
            toVC = navController.topViewController as? CropImageDismissTransitionHandler
        } else {
            toVC = transitionContext.viewController(forKey: .to) as? CropImageDismissTransitionHandler
        }
        
        
        guard let destinationVC = toVC else {
            
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            return
        }
        
        let containerView = transitionContext.containerView
        
        guard let toView = transitionContext.view(forKey: .to) else {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            return
        }
        
        fromVC.view.alpha = 0
        containerView.addSubview(toView)
        
        
        let imageView = UIImageView(frame: fromVC.dismissAnimateFromRect)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = fromVC.dismissAnimateImage
        containerView.addSubview(imageView)
        
        
        
        UIView.animate(withDuration: clipTransTime, animations: {
            imageView.frame = destinationVC.originalImageFrame
            
        }) { _ in
            destinationVC.finishClipDismissAnimation()
            imageView.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

