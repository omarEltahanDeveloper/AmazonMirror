//
//  ProductsView.swift
//  AmazonMirrorApp
//
//  Created by Omar M1 on 13/04/2023.
//

import SwiftUI

struct CategoriesView: View {
    
    var listOfCategories : [categoryModel] = [categoryModel(id: 1, categoryname: "Mobile phones", categoryImage: "mobilephones", products:
    [
        productModel(id: 1, productImage: "ProductImage1", productName: "Samsung Galaxy A04e Dual SIM - 3GB Ram, 32GB size", ratingCount: 2, discount: 10, discountTime: "5:20", priceNow: 14300.00, priceBefore: "18,210.00", companyName: "Samsung", companyWebsite: "https://www.samsung.com/eg/", digitalStorage: "32 GB")
        ,productModel(id: 2, productImage: "productImage2", productName: "Iphone 14 pro max Dual SIM - 3GB Ram, 64GB size", ratingCount: 5, discount: 15, discountTime: "10:23", priceNow: 30649.00, priceBefore: "40,635.00", companyName: "Apple", companyWebsite: "https://www.apple.com", digitalStorage: "64 GB")]),categoryModel(id: 2, categoryname: "Head phones", categoryImage: "headphones", products:[
            productModel(id: 3, productImage: "earpod", productName: "Ear pods white sound core company with 48H charges", ratingCount: 3, discount: 17, discountTime: "14:01", priceNow: 1349.00, priceBefore: "2,010.00", companyName: "Sound core", companyWebsite: "https://uk.soundcore.com", digitalStorage: "48 H"),
            productModel(id: 4, productImage: "headphone", productName: "Head phone black-grey from beats company with high performance", ratingCount: 4, discount: 5, discountTime: "06:32", priceNow: 850.00, priceBefore: "1,180.00", companyName: "Beats", companyWebsite: "https://www.bestweb.com", digitalStorage: "12 H"),
            productModel(id: 5, productImage: "handfree", productName: "Handfree white color - type C charger and provides a converter for appple devices", ratingCount: 1, discount: 30, discountTime: "15:55", priceNow: 349.00, priceBefore: "410.00", companyName: "Google", companyWebsite: "https://www.google.com/", digitalStorage: "type C")])]
    
    @State var listOfCategoriesState : [categoryModel] = [categoryModel(id: 1, categoryname: "Mobile phones", categoryImage: "mobilephones", products:
                                                                            [
                                                                                productModel(id: 1, productImage: "ProductImage1", productName: "Samsung Galaxy A04e Dual SIM - 3GB Ram, 32GB size", ratingCount: 2, discount: 10, discountTime: "5:20", priceNow: 14300.00, priceBefore: "18,210.00", companyName: "Samsung", companyWebsite: "https://www.samsung.com/eg/", digitalStorage: "32 GB")
                                                                                ,productModel(id: 2, productImage: "productImage2", productName: "Iphone 14 pro max Dual SIM - 3GB Ram, 64GB size", ratingCount: 5, discount: 15, discountTime: "10:23", priceNow: 30649.00, priceBefore: "40,635.00", companyName: "Apple", companyWebsite: "https://www.apple.com", digitalStorage: "64 GB")]),categoryModel(id: 2, categoryname: "Head phones", categoryImage: "headphones", products:[
                                                                                    productModel(id: 3, productImage: "earpod", productName: "Ear pods white sound core company with 48H charges", ratingCount: 3, discount: 17, discountTime: "14:01", priceNow: 1349.00, priceBefore: "2,010.00", companyName: "Sound core", companyWebsite: "https://uk.soundcore.com", digitalStorage: "48 H"),
                                                                                    productModel(id: 4, productImage: "headphone", productName: "Head phone black-grey from beats company with high performance", ratingCount: 4, discount: 5, discountTime: "06:32", priceNow: 850.00, priceBefore: "1,180.00", companyName: "Beats", companyWebsite: "https://www.bestweb.com", digitalStorage: "12 H"),
                                                                                    productModel(id: 5, productImage: "handfree", productName: "Handfree white color - type C charger and provides a converter for appple devices", ratingCount: 1, discount: 30, discountTime: "15:55", priceNow: 349.00, priceBefore: "410.00", companyName: "Google", companyWebsite: "https://www.google.com/", digitalStorage: "type C")])]
    @Binding var searchValue : String
    @Binding var selectedBar : HomeFullView
    @Binding var selectedCategoryDetails : categoryModel?
    let columns = [
        GridItem(.adaptive(minimum: (UIScreen.main.bounds.width / 2) - 20 ))
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(listOfCategoriesState) { category in
                        CategoryItem(categoryImage: category.categoryImage, categoryName: category.categoryname)
                            .onTapGesture {
                                self.selectedCategoryDetails = category
                                self.selectedBar = .products
                            }
                    }
                }.padding()
            }
            .onChange(of: searchValue, perform: { newValue in
                if newValue.isEmpty {
                    listOfCategoriesState = listOfCategories
                }
                else {
                    listOfCategoriesState.removeAll()
                    for i in listOfCategories {
                        if i.categoryname.lowercased().contains(newValue.lowercased()) {
                            listOfCategoriesState.append(i)
                        }
                    }
                    
                }
            })
            
        }
    }
}

//struct CategoriesView_Previews: PreviewProvider {
//    static var previews: some View {
//
//    }
//}
