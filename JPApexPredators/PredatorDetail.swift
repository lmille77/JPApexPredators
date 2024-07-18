//
//  PredatorDetail.swift
//  JPApexPredators
//
//  Created by Logan Miller on 7/16/24.
//

import SwiftUI
import MapKit

struct PredatorDetail: View {
    let predator: Predator
    
    @State var position: MapCameraPosition
    
    var body: some View {
        GeometryReader { reader in
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    // Background Image
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(stops: [
                                Gradient.Stop(color: .clear, location: 0.80),
                                Gradient.Stop(color: .black, location: 1.00)],
                            startPoint: .top,
                            endPoint: .bottom)
                        }
                    // Predator Image
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: reader.size.width * 0.6,
                               height: reader.size.height * 0.33)
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius: 7)
                        .offset(y: 20)
                }
                
                VStack(alignment: .leading) {
                    // Predator name
                    Text(predator.name)
                        .font(.largeTitle)
                    
                    // Current location
                    NavigationLink {
                        PredatorMap(position: .camera(MapCamera(centerCoordinate: predator.location, distance: 1000,
                                               heading: 250,
                                               pitch: 80)))
                    } label: {
                        Map(position: $position) {
                            Annotation(predator.name, coordinate: predator.location) {
                                Image(systemName: "mappin.and.ellipse")
                                    .font(.largeTitle)
                                    .imageScale(.large)
                                    .symbolEffect(.pulse)
                            }
                            .annotationTitles(.hidden)
                        }
                        .frame(height: 125)
                        .clipShape(.rect(cornerRadius: 15))
                        .overlay(alignment: .trailing) {
                            Image(systemName: "greaterthan")
                                .imageScale(.large)
                                .font(.title3)
                                .padding(.trailing, 5)
                        }
                        .overlay(alignment: .topLeading) {
                            Text("Current Location")
                                .padding([.leading, .bottom], 5)
                                .padding(.trailing, 8)
                                .background(.black.opacity(0.33))
                                .clipShape(.rect(bottomTrailingRadius: 15))
                        }
                        .clipShape(.rect(cornerRadius: 15))
                    }
                    
                    // Movie appearences
                    Text("Appears In: ")
                        .font(.title3)
                        .padding(.top, 10)
                    
                    ForEach(predator.movies, id: \.self) { movie in
                        Text("•" + movie)
                            .font(.subheadline)
                    }
                    // Movie moments
                    Text("Movie Moments")
                        .font(.title)
                        .padding(.top, 14)
                    
                    ForEach(predator.movieScenes) { scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        
                        Text(scene.sceneDescription)
                            .padding(.bottom, 14)
                    }
                    
                    // Link
                    Text("Read More: ")
                        .font(.caption)
                    
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .font(.caption)
                        .foregroundStyle(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
                .padding()
                .padding(.bottom)
                .frame(width: reader.size.width, alignment: .leading)
            }.ignoresSafeArea()
        }
        .toolbarBackground(.automatic)
    }
}

#Preview {
    NavigationStack {
        PredatorDetail(predator: Predators().apexPredators[0], position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[0].location,
                              distance: 30000)))
    }

}
