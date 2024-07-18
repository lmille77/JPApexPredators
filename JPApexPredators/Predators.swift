//
//  Predators.swift
//  JPApexPredators
//
//  Created by Logan Miller on 7/16/24.
//

import Foundation

class Predators {
    var allApexPredators: [Predator] = []
    var apexPredators: [Predator] = []
    
    init() {
        decodePredatorData()
    }
    
    func decodePredatorData() {
        if let url = Bundle.main.url(forResource: "jpapexpredators",
                                     withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                allApexPredators = try decoder.decode([Predator].self, from: data)
                apexPredators = allApexPredators
            } catch {
                print("Unable to decode JSON data - \(error)")
            }
        }
    }
    
    func search(for searchTerm: String) -> [Predator] {
        if searchTerm.isEmpty {
            return apexPredators
        } else {
            return apexPredators.filter {
                $0.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    func sort(by alphabetical: Bool) {
        apexPredators.sort {
            if alphabetical {
                $0.name < $1.name
            } else {
                $0.id < $1.id
            }
        }
    }
    
    func filter(by type: PredatorType) {
        if type != .all {
            apexPredators = allApexPredators.filter {
                $0.type == type
            }
        } else {
            apexPredators = allApexPredators
        }
    }
}
