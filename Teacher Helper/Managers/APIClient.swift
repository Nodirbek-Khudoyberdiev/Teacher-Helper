//
//  APIClient.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 04/12/23.
//

import RxSwift
import RxCocoa

protocol APIClientProtocol {
    
    static var networkEnviroment: NetworkEnvironment { get }
    func request<T: Codable>(type: T.Type, endpoint: Endpoint) -> Observable<BaseResponse<T>>
}

final class APIClient: APIClientProtocol {
    
    static let networkEnviroment: NetworkEnvironment = .production
    
    func request<T: Codable>(type: T.Type, endpoint: Endpoint) -> Observable<BaseResponse<T>> {
        return URLSession.shared.rx.data(request: endpoint.makeURLRequest())
            .flatMap({ data -> Observable<BaseResponse<T>> in
                do {
                    let decodedModel: BaseResponse<T> = try BaseResponse<T>.decode(data)
                    return Observable.just(decodedModel)
                } catch {
                    let baseResponse = BaseResponse<T>(message: "Decoding error", data: nil, code: nil)
                    return Observable.just(baseResponse)
                }
            })
            .catch { error in
                if let error = error as? RxCocoaURLError {
                    switch error {
                    case .httpRequestFailed(let response, let data):
                        if response.statusCode == 401 {
                            // return to HomePage
                            return Observable.empty()
                        } else {
                            if let data, let decodedModel: BaseResponse<T> = try? BaseResponse<T>.decode(data) {
                                return Observable.just(decodedModel)
                            } else {
                                return Observable.empty()
                            }
                        }
                    default:
                        return self.returnDefaultError(type: type, error: error)
                    }
                }
                return self.returnDefaultError(type: type, error: error)
            }
            .retry(3, delay: .exponential(initial: 3, multiplier: 1, maxDelay: 16))
    }
    
    private func returnDefaultError<T: Codable>(type: T.Type, error: Error) -> Observable<BaseResponse<T>>{
        let baseResponse = BaseResponse<T>(message: error.localizedDescription, data: nil, code: nil)
        return Observable.just(baseResponse)
    }
    
    
}
