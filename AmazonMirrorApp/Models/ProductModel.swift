//
//  ProductModel.swift
//  AmazonMirrorApp
//
//  Created by Omar M1 on 14/04/2023.
//

import Foundation

public struct productModel: Identifiable {
    public var id: Int
    public var productImage: String
    public var productName: String
    public var ratingCount: Int
    public var discount: Int
    public var discountTime: String
    public var priceNow: Double
    public var priceBefore: String
    public var companyName: String
    public var companyWebsite: String
    public var digitalStorage: String
}
