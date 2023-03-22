//
//  PVChooseTypeInteractor.swift
//
//  Created by Matheus Bondan on 09/02/23.
//  Copyright (c) 2023 Realize. All rights reserved.

final class PVChooseTypeInteractor: PVChooseTypeInteractorInput {
    
    var api: ApiProtocol?
    var output: PVChooseTypeInteractorOutput?
    
    init(api: ApiProtocol = ApiWorker.shared) {
        self.api = api
    }
    
    func fetchTypes() {
        api?.requestObject(
            endpoint: Endpoint.types.url,
            method: .get,
            headers: nil,
            type: ListTypesOutput.self,
            encoder: .json
        )
        { [weak self] result in
            switch result {
            case .success(let output):
                self?.output?.fetchTypesSucceeded(output: output)
            case .failure:
                self?.output?.fetchTypesFailed()
                
            }
        }
    }
}

struct ListTypesOutput: Decodable {
    let results: [TypesOutput]
}

struct TypesOutput: Decodable {
    let thumbnailImage: String
    let name: String
}
