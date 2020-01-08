//
//  ListModel.swift
//  ServiceCall
//
//  Created by gowri anguraj on 08/01/20.
//  Copyright © 2020 gowri anguraj. All rights reserved.
//

import Foundation

struct CarListings: Codable {
    let listings: [UsedCarSpecs]
    
    private enum listingCodingKeys: String, CodingKey {
        case listings
    }
}

struct UsedCarSpecs: Codable {
    let year: Int
    let make: String
    let model: String
    let trim: String
    let currentPrice: Double
    let mileage: Int
    let images: CarImages?
    let dealer: Dealer //contains dealer phone#, city, state
    
    private enum codingKeys: String, CodingKey {
        case year
        case make
        case model
        case trim
        case currentPrice
        case mileage
        case images
        case dealer
    }
    
    init(from decoder: Decoder) throws {
        let carListModel = try decoder.container(keyedBy: codingKeys.self)
        year = try carListModel.decodeIfPresent(Int.self, forKey: .year) ?? 0
        make = try carListModel.decodeIfPresent(String.self, forKey: .make) ?? ""
        model = try carListModel.decodeIfPresent(String.self, forKey: .model) ?? ""
        trim = try carListModel.decodeIfPresent(String.self, forKey: .trim) ?? ""
        currentPrice = try carListModel.decodeIfPresent(Double.self, forKey: .currentPrice) ?? 0
        mileage = try carListModel.decodeIfPresent(Int.self, forKey: .mileage) ?? 0
        dealer = try carListModel.decode(Dealer.self, forKey: .dealer)
        images = try? carListModel.decode(CarImages.self, forKey: .images)
    }
}

struct CarImages: Codable {
    
    let firstPhoto: ImagesList
    
    private enum carImagesCodingKeys: String, CodingKey {
        case firstPhoto
    }
    
    init(from decoder: Decoder) throws {
        let carImagesList = try decoder.container(keyedBy: carImagesCodingKeys.self)
        firstPhoto = try carImagesList.decode(ImagesList.self, forKey: .firstPhoto)
    }
}

struct ImagesList: Codable {
    
    let large: String
    
    private enum finalImageCodingKeys: String, CodingKey {
        case large
    }
    
    init(from decoder: Decoder) throws {
        let imagesListModel = try decoder.container(keyedBy: finalImageCodingKeys.self)
        large = try imagesListModel.decode(String.self, forKey: .large)
    }
}

struct Dealer: Codable {
    
    let city: String
    let state: String
    let phone: String
    
    private enum dealerCodingKeys: String, CodingKey {
        case city
        case state
        case phone
    }
    
    init(from decoder: Decoder) throws {
        let dealerModel = try decoder.container(keyedBy: dealerCodingKeys.self)
        city = try dealerModel.decodeIfPresent(String.self, forKey: .city) ?? ""
        state = try dealerModel.decodeIfPresent(String.self, forKey: .state) ?? ""
        phone = try dealerModel.decodeIfPresent(String.self, forKey: .phone) ?? ""
    }
}

