
import SwiftUI
import UI


struct ArtworksList<Service: IService>: View {
    
    @StateObject var artworkListVM: ArtworkListViewModel<Service>
    
    var body: some View {
        
        scrollView
            .onAppear{
                artworkListVM.fetch()
            }
            .ignoresSafeArea()
    }
    
    @ViewBuilder
    var scrollView: some View {
        ScrollView {
            LazyVStack(spacing: 0) {
                ForEach(artworkListVM.artworks) { artwork in
                    
                    ArtworkListCell(artwork: artwork){
                        withAnimation {
                            artworkListVM.delete(artwork: artwork)
                        }
                    }
                    .navigationPushLink(destination: ArtworkScreen(artwork: artwork))
                    .onAppear{
                        if artworkListVM.artworks.isLastElement(artwork) {
                            artworkListVM.fetch()
                        }
                    }
                    .transition(.moveToBottom)
                }
                if artworkListVM.isLoading {
                    ProgressView()
                }
            }
        }
        
    }
}

struct ArtworskList_Previews: PreviewProvider {
    static var previews: some View {
        ArtworksList(artworkListVM: ArtworkListViewModel(service: ArtInstituteChicagoNetworkService.self))
    }
}
