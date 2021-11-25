//
//  ViewController.swift
//  WeAniList
//
//  Created by Carlos Silva on 15/11/21.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftUI

class HomeViewController: BaseViewController {
    private let disposeBagUI = DisposeBag()
    private let homeViewModel: HomeViewModel
    
    private lazy var animesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.allowsSelection = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(AnimeCollectionViewCell.self, forCellWithReuseIdentifier: AnimeCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init() {
        self.homeViewModel = HomeViewModel()
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Animes".uppercased()
    }
    
    override func setupUI() {
        super.setupUI()
        
        self.view.addSubview(animesCollectionView)
        
        self.animesCollectionView.anchor(
            top: (self.view.topAnchor, .zero),
            left: (self.view.leftAnchor, .zero),
            right: (self.view.rightAnchor, .zero),
            bottom: (self.view.safeAreaLayoutGuide.bottomAnchor, .zero)
        )
    }
    
    override func bindUI() {
        super.bindUI()
        self.homeViewModel.isLoading
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { loading in
                guard loading else { Loading.shared.remove() ; return }
                Loading.shared.add()
            }).disposed(by: self.disposeBagUI)
        
        self.homeViewModel.animes
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] animes in
                guard let self = self else { return }
                
                self.animesCollectionView.reloadItems(at: (self.homeViewModel.oldOffset.value..<self.homeViewModel.paginateOffset.value).map { index -> IndexPath in
                    return IndexPath(row: index, section: .zero)
                })
            }).disposed(by: self.disposeBagUI)
        
        self.homeViewModel.isLoading.accept(true)
    }
    
    @objc func clickWindow(sender: UIWindow) {
        Loading.shared.remove()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.homeViewModel.animes.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: AnimeCollectionViewCell.identifier, for: indexPath) as? AnimeCollectionViewCell else {
            return AnimeCollectionViewCell(frame: .zero)
        }
        
        let data = self.homeViewModel.animes.value[indexPath.row]
        
        collectionCell.loadImage(with: data.attributes.posterImage.medium)
        return collectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.homeViewModel.animes.value.count - 1 {
            self.homeViewModel.loadMore()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3.4, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 20, left: 12, bottom: .zero, right: 12)
    }
}
