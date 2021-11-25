//
//  Loading.swift
//  WeAniList
//
//  Created by Carlos Silva on 24/11/21.
//

import Lottie

final class Loading {
    static let shared = Loading()
    
    private let tagView = 10
    
    func add() {
        let view = AnimationView(name: "loading")
        let bounds = UIScreen.main.bounds
        view.backgroundColor = .black
        view.loopMode = .loop
        view.play()
        view.alpha = 0.97
        
        view.frame = bounds
        view.tag = self.tagView
        
        UIApplication.shared.windows.first?.addSubview(view)
    }
    
    func addWithTimeout() {
        
    }
    
    func remove() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.removeView()
        }
    }
    
    private func removeView() {
        guard let view = UIApplication.shared.windows.first?.viewWithTag(tagView) else {
            return
        }
        
        view.frame = .zero
        view.removeFromSuperview()
    }
}
