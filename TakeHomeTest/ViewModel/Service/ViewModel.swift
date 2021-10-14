//
//  ViewModel.swift
//  TakeHomeTest
//
//  Created by MICHAEL ADU DARKO on 10/12/21.
//

import Foundation

struct ViewModel {
    let service: SearchServiceProviding
    
    init(service: SearchServiceProviding = SearchClient()) {
        self.service = service
    }
    
    func search(with term: String, completion: @escaping SearchResponseCompletion) {
        let searchTerm = term.replacingOccurrences(of: " ", with: "+")
        service.search(searchTerm, completion: completion)
    }
}

