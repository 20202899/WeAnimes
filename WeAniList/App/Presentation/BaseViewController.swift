//
//  BaseViewController.swift
//  WeAniList
//
//  Created by Carlos Silva on 20/11/21.
//

import UIKit
import Lottie

class BaseViewController: UIViewController {
    lazy var rightBarButton: UIBarButtonItem = {
        let view = AnimationView(name: "close")
        view.frame = .init(x: .zero, y: .zero, width: 24, height: 24)
        view.play(toProgress: .zero)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rightOnClick)))
        let barButton = UIBarButtonItem(customView: view)
        return barButton
    }()
    
    var rightBarButtonOnClick: (() -> Void)?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupHeader()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = rightBarButton
        self.setupUI()
        self.bindUI()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHeader() {
        self.view.backgroundColor = .black
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.shadowImage = UIColor.imageFromColor(.clear)
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.monospacedSystemFont(ofSize: 14, weight: UIFont.Weight.bold)
        ]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.monospacedSystemFont(ofSize: 35, weight: UIFont.Weight.bold)
        ]
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    open func setupUI() {
    }
    
    open func bindUI() {
    }
    
    open func menuAnimateBy(progress: AnimationProgressTime) {
        if let animatedView = rightBarButton.customView as? AnimationView {
            animatedView.play(toProgress: progress)
        }
    }
    
    open func menuAnimateBy(frame: AnimationFrameTime) {
        if let animatedView = rightBarButton.customView as? AnimationView {
            animatedView.play(toFrame: frame)
        }
    }
    
    @objc private func rightOnClick(sender: AnimationView) {
        if let anim = rightBarButton.customView as? AnimationView {
            anim.play(toProgress: 0.031)
            rightBarButtonOnClick?()
        }
    }
}
