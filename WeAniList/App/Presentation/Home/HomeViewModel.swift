//
//  HomeViewModel.swift
//  WeAniList
//
//  Created by Carlos Silva on 20/11/21.
//

import RxSwift
import RxRelay

class HomeViewModel {
    private let disposeBag = DisposeBag()
    private let homeModel: HomeModel
    
    let isLoading: PublishRelay<Bool> = PublishRelay()
    let paginateOffset: BehaviorRelay<Int> = BehaviorRelay(value: .zero)
    let animes: BehaviorRelay<[AnimeResponse]> = BehaviorRelay(value: [])
    let oldOffset: BehaviorRelay<Int> = BehaviorRelay(value: .zero)
    
    init() {
        self.homeModel = HomeModel(repository: AnimeRepository())
        self.setupBehaviors()
    }
    
    private func setupBehaviors() {
        paginateOffset
            .flatMap { [weak self] offset -> Observable<Response> in
                guard let self = self else { return .error(NSError()) }
                return self.homeModel.paginate(requestType: .paginate(year: 2021, offset: offset))
            }.map { result -> [AnimeResponse] in
                return result.data
            }.bind(onNext: { [weak self] animes in
                guard let self = self else { return }
                
                self.isLoading.accept(false)
                let oldAnimes = self.animes.value
                let moreAnimes = oldAnimes + animes
                self.animes.accept(moreAnimes)
            }).disposed(by: self.disposeBag)
    }
    
    func loadMore() {
        self.isLoading.accept(true)
        oldOffset.accept(paginateOffset.value)
        let newOffset = oldOffset.value + 16
        
        paginateOffset.accept(newOffset)
    }
}
