import Foundation

protocol Networking {
    func request<T: Decodable>(
        endpoint: APIEndpoint,
        responseType: T.Type
    ) async throws -> T
}
