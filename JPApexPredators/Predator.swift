//
//  ApexPredator.swift
//  JPApexPredators
//
//  Created by Logan Miller on 7/16/24.
//

import Foundation
import SwiftUI
import MapKit

struct Predator: Decodable, Identifiable {
    let id: Int
    let name: String
    let type: PredatorType
    let latitude: Double
    let longitude: Double
    let movies: [String]
    let movieScenes: [MovieScene]
    let link: String
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "")
    }
    
    var location: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude,
                               longitude: longitude)
    }
        
    struct MovieScene: Decodable, Identifiable {
        let id: Int
        let movie: String
        let sceneDescription: String
    }
}

enum PredatorType: String, Decodable, CaseIterable, Identifiable {
    var id: PredatorType { self }
    
    case all
    case land
    case air
    case sea
    
    var background: Color {
        switch self {
            case .all: return .black
            case .land: return .brown
            case .air: return .teal
            case .sea: return .blue
        }
    }
    
    var icon: String {
        switch self {
            case .all: "square.stack.3d.up.fill"
            case .land: "leaf.fill"
            case .air: "wind"
            case .sea: "drop.fill"
        }
    }
}
