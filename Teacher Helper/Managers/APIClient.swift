//
//  APIClient.swift
//  Teacher Helper
//
//  Created by Nodirbek Khudoyberdiev on 04/12/23.
//

import RxSwift
import RxCocoa

enum NetworkResult<T: Codable> {
    case success(BaseResponse<T>)
    case error(BaseError)
}

protocol APIClientProtocol {
    static var networkEnviroment: NetworkEnvironment { get }
    func request<T: Codable>(type: T.Type, endpoint: Endpoint) -> Observable<NetworkResult<T>>
}

final class APIClient: APIClientProtocol {
    
    static let networkEnviroment: NetworkEnvironment = .production
    
    func request<T: Codable>(type: T.Type, endpoint: Endpoint) -> Observable<NetworkResult<T>> {
        return URLSession.shared.rx.data(request: endpoint.makeURLRequest())
            .flatMap({ data -> Observable<NetworkResult<T>> in
                do {
                    let decodedModel: BaseResponse<T> = try BaseResponse<T>.decode(data)
                    return Observable.just(.success(decodedModel))
                } catch {
                    let baseError = BaseError(status: nil, message: error.localizedDescription, code: nil)
                    return Observable.just(.error(baseError))
                }
            })
            .catch { error in
                if let error = error as? RxCocoaURLError {
                    switch error {
                    case .httpRequestFailed(let response, let data):
                        if response.statusCode == 401 {
                            // return to HomePage
                            return Observable.just(.error(.init(status: false, message: nil, code: 401)))
                        } else {
                            if let data {
                                if let backendError = self.parseBackendError(data: data) {
                                    return Observable.just(.error(backendError))
                                }
                            }
                        }
                    default:
                        break
                    }
                }
                
                let defaultError = self.returnDefaultError(error: error)
                return Observable.just(.error(defaultError))
            }
            .compactMap({$0})
//            .retry(3, delay: .exponential(initial: 3, multiplier: 1, maxDelay: 16))
    }
    
    private func returnDefaultError(error: Error) -> BaseError {
        let baseResponse = BaseError(status: nil, message: error.localizedDescription, code: nil)
        return baseResponse
    }
    
    private func parseBackendError(data: Data) -> BaseError? {
        do {
            let decodedModel: BaseError = try BaseError.decode(data)
            return decodedModel
        } catch {
            return nil
        }
    }
    
    
}
