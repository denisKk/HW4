

import Foundation
import HarvardArtMuseumsNetworking

extension Artwork {
    
    enum ImageSize {
        case small, full
    }
    
    func getURLFromId(size: ImageSize) -> URL {
        let sizeSTR = size == .small ? ",300" : "full"
        
        guard let id = self.images?.first?.idsid else {
            return URL(string: self.primaryimageurl ?? "")!
        }
        
        return URL(string: "https://ids.lib.harvard.edu/ids/iiif/\(id)/full/\(sizeSTR)/0/default.jpg")!
    }
}


final class HarvardArtMuseumsNetworkService: IService {

    class var service: HarvardArtMuseumsNetworkService {
        if let service: HarvardArtMuseumsNetworkService = ServiceLocator.service() {
            return service
        }
        
        let service = HarvardArtMuseumsNetworkService()
        ServiceLocator.addService(service)
        return service
    }

    func fetch(page: Int, limit: Int, completion: @escaping ([ArtworkModel]) -> ()) {
   
        
        ArtworksAPI.everythingGet(apikey: "e49f1eac-bb98-456f-ac51-f7c9a8cdc116", hasimage: 1, page: page + 500, size: limit) { result, error in

            guard error == nil else {
                print(error as Any)
                return
            }
            
            if let array = result?.records?.filter({ items in
                items.primaryimageurl != nil || items.images?.first != nil
                
            }) {
                let modelsArray = array.map {
                    ArtworkModel(
                        id: $0.id ?? 0,
                        title: $0.title ?? "",
                        descrittion: $0.description?.htmlToString ?? "",
                        imageURL: $0.getURLFromId(size: .small),
                        imageFullScreenURL:   $0.getURLFromId(size: .full),
                        materials: $0.technique ?? "",
                        author: $0.people?.first?.displayname ?? "",
                        date: $0.dated ?? ""
                    )
                }
                
                completion(modelsArray)
            }
        }
    }
}
