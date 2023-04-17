//
//  CategoriesModel.swift
//  AmazonMirrorApp
//
//  Created by Omar M1 on 16/04/2023.
//

import Foundation

public struct categoryModel: Identifiable {
    public var id: Int
    public var categoryname: String
    public var categoryImage: String
    public var products: [productModel]
}
