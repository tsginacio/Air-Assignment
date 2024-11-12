//
//  NationPouplationResponseData.swift
//  Air Assignment
//
//  Created by Tiago Inácio on 11/11/2024.
//

struct NationPopulationResponseData: Codable {
    //API response had "data" and "source" keys
    var data: [NationPopulationData]
}
