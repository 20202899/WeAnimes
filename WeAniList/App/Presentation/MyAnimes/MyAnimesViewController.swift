//
//  MyAnimesViewController.swift
//  WeAniList
//
//  Created by Carlos Alberto Barbosa da Silva on 25/11/21.
//

import UIKit
import Lottie

class MyAnimesViewController: BaseViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        menuAnimateBy(frame: 10)
        menuAnimateBy(progress: 1)
    }
}
