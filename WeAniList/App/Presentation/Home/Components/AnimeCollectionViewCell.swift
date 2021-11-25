//
//  AnimeCollectionViewCell.swift
//  WeAniList
//
//  Created by Carlos Silva on 20/11/21.
//

import UIKit
import RxSwift
import RxCocoa

class AnimeCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: self)
    
    private let dispose = DisposeBag()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(image)
        
        image.anchor(
            top: (contentView.topAnchor, .zero),
            left: (contentView.leftAnchor, .zero),
            right: (contentView.rightAnchor, .zero),
            bottom: (contentView.bottomAnchor, .zero)
        )
        
        image.contentMode = .scaleAspectFill
    }
    
    func loadImage(with url: String) {
        APIService.shared.loadImage(with: url).subscribe(onNext: { [weak self] data in
            guard let self = self else { return }
            
            self.image.image = UIImage(data: data)
        }).disposed(by: self.dispose)
    }
}
