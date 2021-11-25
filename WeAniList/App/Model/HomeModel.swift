//
//  HomeModel.swift
//  WeAniList
//
//  Created by Carlos Silva on 20/11/21.
//

import RxAlamofire
import RxSwift

protocol HomePaginateAnimesProtocol {
    func paginate(requestType: APIRequestType) -> Observable<Response>
}

class HomeModel: HomePaginateAnimesProtocol{
    private let repository: HomePaginateAnimesProtocol
    
    init (repository: HomePaginateAnimesProtocol) {
        self.repository = repository
    }
}

extension HomeModel {
    func paginate(requestType: APIRequestType) -> Observable<Response> {
        self.repository.paginate(requestType: requestType)
    }
}
