//
//  BarButtonActionAnimatable.swift
//  WeAniList
//
//  Created by Carlos Silva on 28/11/21.
//


import Lottie
import UIKit

typealias BarButtonActionAnimableType = (from: AnimationProgressTime , to: AnimationProgressTime)

protocol BarButtonActionAnimatable {
    func barButtonMenuAnimAction(barButtonAnimableType: BarButtonActionAnimableType, action: (() -> Void)?)
}

extension BarButtonActionAnimatable where Self: UIViewController {
    func barButtonMenuAnimAction(barButtonAnimableType: BarButtonActionAnimableType, action: (() -> Void)? = nil) {
        if let animationView = self.navigationItem.leftBarButtonItem?.customView as? AnimationView {
            animationView.play(fromProgress: barButtonAnimableType.from, toProgress: barButtonAnimableType.to, loopMode: .none) {_ in 
                action?()
            }
        }
    }
}
