

import Foundation
import ClevelandMuseumNetworking


final class ClevelandMuseumNetworkService: IService {

    class var service: ClevelandMuseumNetworkService {
        if let service: ClevelandMuseumNetworkService = ServiceLocator.service() {
            return service
        }
        
        let service = ClevelandMuseumNetworkService()
        ServiceLocator.addService(service)
        return service
    }
    
    func fetch(page: Int, limit: Int, completion: @escaping ([ArtworkModel]) -> ()) {
 
        ArtworksAPI.everythingGet(skip: page*limit, limit: limit, hasImage: 1) { result, error in
            
            guard error == nil else {
                print(error as Any)
                return
            }

            let modelsArray = result?.data?.compactMap {
                ArtworkModel(
                    id: $0.id ?? 0,
                    title: $0.title ?? "",
                    descrittion: $0.description?.htmlToString ?? "",
                    imageURL: URL(string: ($0.images?.web?.url)!)!,
                    imageFullScreenURL:   URL(string: ($0.images?.print?.url)!)!,
                    materials: $0.technique ?? "",
                    author: $0.creators?.first?.description ?? "",
                    date: $0.creationDate ?? ""
                )
            }
            completion(modelsArray!)
        }
    }
}
