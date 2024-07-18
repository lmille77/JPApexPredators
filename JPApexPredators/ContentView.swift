//
//  ContentView.swift
//  JPApexPredators
//
//  Created by Logan Miller on 7/16/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var userInput: String = ""
    @State var alphabetical: Bool = false
    @State var currentFilter = PredatorType.all
    
    let allPredators = Predators()
    
    var filteredPredators: [Predator] {
        allPredators.filter(by: currentFilter)
        allPredators.sort(by: alphabetical)
        return allPredators.search(for: userInput)
    }
    
    var body: some View {
        NavigationStack {
            List(filteredPredators) { predator in
                NavigationLink {
                    PredatorDetail(predator: predator, position: .camera(MapCamera(centerCoordinate: predator.location,
                                          distance: 30000)))
                } label: {
                    HStack {
                        // Dinosaur image
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .shadow(color: .white, radius: 1)
                        
                        VStack(alignment: .leading) {
                            // Name
                            Text(predator.name)
                                .fontWeight(.bold)
                            
                            // Type
                            Text(predator.type.rawValue.capitalized)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 5)
                                .background(predator.type.background)
                                .clipShape(.capsule)
                        }
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .searchable(text: $userInput)
            .autocorrectionDisabled()
            .animation(.default, value: userInput)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            alphabetical.toggle()
                        }
                    } label: {
                        Image(systemName: alphabetical ? "film" : "textformat")
                            .symbolEffect(.bounce, value: alphabetical)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Filter",
                               selection: $currentFilter.animation()) {
                            ForEach(PredatorType.allCases) { type in
                                Label(type.rawValue.capitalized,
                                      systemImage: type.icon)
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
        .preferredColorScheme(.dark)
        .tint(.white)
    }
}

#Preview {
    ContentView()
}
