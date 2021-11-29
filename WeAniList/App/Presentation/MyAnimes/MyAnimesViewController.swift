//
//  MyAnimesViewController.swift
//  WeAniList
//
//  Created by Carlos Alberto Barbosa da Silva on 25/11/21.
//

import UIKit
import Lottie

class MyAnimesViewController: BaseViewController, BarButtonActionAnimatable {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        barButtonMenuAnimAction(barButtonAnimableType: (from: 0.3 , to: 1))
    }
    
    override func bindUI() {
        super.bindUI()

        self.navigationItem.leftBarButtonItem?.customView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(leftbarButtonClick)))
    }
    
    @objc private func leftbarButtonClick(sender: UITapGestureRecognizer) {
        barButtonMenuAnimAction(barButtonAnimableType: (from: 1 , to: 0.3)) {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
