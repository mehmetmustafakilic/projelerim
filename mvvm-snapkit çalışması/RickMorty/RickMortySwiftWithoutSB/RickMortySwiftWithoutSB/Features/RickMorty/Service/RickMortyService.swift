//
//  RickMortyService.swift
//  RickMortySwiftWithoutSB
//
//  Created by Mehmet Mustafa Kılıç on 24.11.2022.
//

import Alamofire

enum RickMortyServiceEndPoint: String {
    case BASE_URL = "https://rickandmortyapi.com/api"
    case PATH = "/character"
    
    static func characterPath() -> String {
        return "\(BASE_URL.rawValue)\(PATH.rawValue )"
    }
}

protocol IRickMortyService {
    func fechAllDatas(response: @escaping ([Result]?) -> Void)
}

struct RickMortyService:IRickMortyService {
    func fechAllDatas(response: @escaping ([Result]?) -> Void) {
        AF.request(RickMortyServiceEndPoint.characterPath()).responseDecodable(of: PostModel.self) { (model) in
            guard let data = model.value else {
                response(nil)
                return
            }
            response(data.results)
        }
    }
}
