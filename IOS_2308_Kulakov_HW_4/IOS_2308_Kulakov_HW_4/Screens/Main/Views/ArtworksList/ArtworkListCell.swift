
import SwiftUI
import UI

struct ArtworkListCell: View {
    
    var artwork: ArtworkModel
    var onFavTap: () -> ()
    
    var body: some View {
        
        CacheAsyncImage(url: artwork.imageURL) { phase in
            switch phase {
            case .empty:
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: 250, idealHeight: 310, maxHeight: 700)
                    .padding()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
            case .failure(let error):
                Text("Error: \(error.localizedDescription)")
            @unknown default:
                fatalError()
            }
        }
        .frame(maxWidth: .infinity)
        .frame(minHeight: 250, idealHeight: 310, maxHeight: 700)
        .scaledToFill()
        .overlay {
            ZStack {
                GeometryReader { geo in
                    ZStack() {
                        Text(artwork.title)
                            .font(.largeTitle.weight(.light))
                            .foregroundColor(.white)
                            .minimumScaleFactor(0.5)
                            .lineLimit(2)
                            .padding(4)
                            .shadow(color: .black, radius: 2, x: 1, y: 1)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .frame(height: 90)
                    .background(
                        Rectangle()
                            .fill(
                                LinearGradient(colors: [.brown, .brown.opacity(0.3)], startPoint: .top, endPoint: .bottom)
                            )
                            .blur(radius: 3)
                    )
                }
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        Button {
                            onFavTap()
                        } label: {
                            Image(systemName: "heart.circle.fill")
                                .resizable()
                                .symbolRenderingMode(.palette)
                                .foregroundStyle(.red, .black)
                                .frame(width: 30, height: 30)
                                .shadow(radius: 3)
                                .padding()
                        }
                    }
                }
            }
        }
        .padding(.horizontal,4)
        .background(.black)
        //        .onAppear {
        //            print( imageDimenssions(url: artwork.imageURL))
        //        }
    }
    
    func imageDimenssions(url: URL) -> String{
        if let imageSource = CGImageSourceCreateWithURL(url as CFURL, nil) {
            if let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as Dictionary? {
                let pixelWidth = imageProperties[kCGImagePropertyPixelWidth] as! Int
                let pixelHeight = imageProperties[kCGImagePropertyPixelHeight] as! Int
                return "Width: \(pixelWidth), Height: \(pixelHeight)"
            }
        }
        return "None"
    }
}

struct ArtworkListCell_Previews: PreviewProvider {
    static var previews: some View {
        //                ArtworkListCell(artwork: ArtworkListModel.testData.last!){}
        ArtworksList(artworkListVM: ArtworkListViewModel(service: ArtInstituteChicagoNetworkService.self))
    }
}
