//
//  AnimeRepository.swift
//  WeAniList
//
//  Created by Carlos Silva on 20/11/21.
//

import RxSwift

class AnimeRepository: HomePaginateAnimesProtocol {
    func paginate(requestType: APIRequestType) -> Observable<Response> {
        return APIService.shared.request(requestType: requestType)
    }
}
