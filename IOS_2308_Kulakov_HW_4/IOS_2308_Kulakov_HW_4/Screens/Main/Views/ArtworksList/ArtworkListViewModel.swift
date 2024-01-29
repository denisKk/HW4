
import Foundation

final class ArtworkListViewModel<Service: NetworkingService>: ObservableObject {
    internal init(service: Service.Type) {
        self.networkService = service
    }
    
   @Published var artworks: [ArtworkModel] = .init()
   @Published var isLoading: Bool = false
    var page: Int = 1
    let limit: Int = 10
    let networkService: Service.Type
    
    func fetchData() {
        
        guard isLoading == false else { return }
        
        
        Task { [weak self, page, limit] in
            
            guard let self else { return }
            
            await self.showLoading(true)
            
            let networkData = await self.networkService.service.fetch(page: page, limit: limit)
            
            guard networkData.isEmpty else {
                print("Load from NETWORK")
                self.page += 1
                
                await MainActor.run {
                    self.artworks.append(contentsOf: networkData)
                    self.showLoading(false)
                }
                
                return
            }
            
            await self.showLoading(false)
        }
    }
    
    @MainActor
    func showLoading(_ show: Bool) {
        isLoading = show
    }
    
    
    func delete(artwork: ArtworkModel) {
        artworks.removeAll(where: {$0.id == artwork.id})
    }
}
