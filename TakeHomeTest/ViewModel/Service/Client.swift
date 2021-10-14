//
//  Client.swift
//  TakeHomeTest
//
//  Created by MICHAEL ADU DARKO on 10/12/21.
//

import UIKit

public enum SearchResponseError: Error{
    case invalidURL
    case missingData
    case error(String)
}

public typealias SearchResponse = Result<[SearchItem], SearchResponseError>
public typealias SearchResponseCompletion = (SearchResponse) -> Void

public protocol SearchServiceProviding{
    func search(_ term: String, completion: @escaping SearchResponseCompletion)
}

public struct SearchClient: SearchServiceProviding{

    private let parser = Parser()
    private let session = URLSession.shared

    private var urlComponent: URLComponents {
        var component = URLComponents()
        component.scheme = "https"
        component.host = "itunes.apple.com"
        component.path = "/search"
        return component
    }

    public func search(_ term: String, completion: @escaping SearchResponseCompletion){
        guard let url = makeURL(with: ["term": term, "entity": "album"]) else {
            completion(.failure(.invalidURL))
            return
        }
        print(url.absoluteURL)

        session.dataTask(with: url) { (data, _, error) in
            if let err = error {
                completion(.failure(.error(err.localizedDescription)))
                return
            }

            guard let data = data else { completion(.failure(.missingData)); return }

            let result = parser.parse(data: data)
            completion(result)

        }.resume()
    }

    private func makeURL(with params: [String: String]) -> URL?{
        var _urlComponent = urlComponent
        var queryItems = [URLQueryItem]()
        for param in params {
            let item = URLQueryItem(name: param.key, value: param.value)
            queryItems.append(item)
        }

        print(_urlComponent)
        _urlComponent.queryItems = queryItems
        return _urlComponent.url
    }
}

public class Parser{
    struct RequestResult: Codable{
        let results: [SearchItem]
    }

    public func parse(data: Data) -> SearchResponse{
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            print(json)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decoded = try decoder.decode(RequestResult.self, from: data)

            return .success(decoded.results)
        } catch let error {
            return .failure(.error(error.localizedDescription))
        }
    }
}
