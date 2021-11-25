//
//  APIService.swift
//  WeAniList
//
//  Created by Carlos Silva on 15/11/21.
//

import RxSwift
import RxCocoa
import RxAlamofire

final class APIService {
    static var shared = APIService()
    static let BaseURL = "https://kitsu.io/api/edge/anime?%@"
    
    func request(requestType: APIRequestType) -> Observable<Response> {
        return RxAlamofire.requestString(.get, String(format: APIService.BaseURL, arguments: [requestType.apiRequest])).flatMap { result -> Observable<Response> in
            if result.0.statusCode == 200 {
                if let data = result.1.data(using: .utf8) {
                    guard let response = try? JSONDecoder().decode(Response.self, from: data) else { return .error(NSError(domain: "Parser Error", code: APIRequestErroCode.parserDataError.rawValue, userInfo: nil)) }
                    return .just(response)
                } else {
                    return .error(NSError(domain: "Data error", code: APIRequestErroCode.dataError.rawValue, userInfo: nil))
                }
            } else {
                return .error(NSError(domain: "Request error", code: result.0.statusCode, userInfo: nil))
            }
        }
    }
    
    func loadImage(with: String) -> Observable<Data> {
        return RxAlamofire.requestData(.get, with).map { res, data -> (Data) in
            return data
        }
    }
}

enum APIRequestType {
    case paginate(year: Int, limit: Int = 16, offset: Int = 0)
    
    var apiRequest: String {
        switch self {
        case .paginate(let year, let limit, let offset):
            return String.init(format: "filter[seasonYear]=%d&page[limit]=%d&page[offset]=%d", arguments: [year, limit, offset])
        }
    }
}

enum APIRequestErroCode: Int {
    case dataError = -1000
    case parserDataError = -1001
}
