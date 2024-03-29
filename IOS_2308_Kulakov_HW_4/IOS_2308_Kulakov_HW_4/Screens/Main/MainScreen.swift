
import SwiftUI

struct MainScreen: View {

    @State private var selectedTab: HeaderList.Headers = .cma
    
    var body: some View {
        GeometryReader {proxy in
            
            let width = proxy.size.width
            let height = proxy.size.height
            let isVertical = width < height
            let layout: AnyLayout = isVertical ? AnyLayout(VStackLayout()) : AnyLayout(HStackLayout())
            
            layout {
                HeaderList(selectedTab: $selectedTab)
                    .frame(
                        width: isVertical ? width : width * 0.38,
                        height: isVertical ? height * 0.29 : height
                    )
                artworksList
                    
            }
        }
        .background(.black)
        .ignoresSafeArea(edges: .vertical)
        .preferredColorScheme(.dark)
    }

    
    @ViewBuilder
    var artworksList: some View {
        switch selectedTab {
        case .aic:
            ArtworksList(artworkListVM: ArtworkListViewModel(service: ArtInstituteChicagoNetworkService.self))
        case .cma:
            ArtworksList(artworkListVM: ArtworkListViewModel(service: ClevelandMuseumNetworkService.self))
        case .liked:
            LikedList()
        }
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}
