//
//  MainView.swift
//  AmazonMirrorApp
//
//  Created by Omar M1 on 15/04/2023.
//

import SwiftUI


enum HomeFullView: Identifiable {
    case products, details, cart, category, checkout
    
    var id: Int {
        self.hashValue
    }
}

struct MainView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Products.productname, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Products>
    @State var searchValue = ""
    var searchPlaceholder = "Search Amazon.eg"
    @State var selectedBar : HomeFullView = .category
    @State var selectedCategoryDetails : categoryModel?
    @State var selectedProductDetails : productModel?
    @State var countOfCart = 0
    var body: some View {
        VStack(spacing: 0) {
            topBar
            if selectedBar == .category {
                CategoriesView(searchValue: $searchValue,selectedBar: $selectedBar, selectedCategoryDetails: $selectedCategoryDetails)
            }
            else if selectedBar == .products {
                ProductsView(listOfProducts: selectedCategoryDetails!.products,listOfProductsState: .constant(selectedCategoryDetails!.products),searchValue: $searchValue,selectedBar: $selectedBar, selectedProductDetails: $selectedProductDetails)
            }
            else if selectedBar == .details {
                ProductDetailsView(modelOfProduct: selectedProductDetails!,selectedBar: $selectedBar)
            }
            else if selectedBar == .checkout {
                CheckoutView(selectedBar: $selectedBar)
            }
            else {
                CartView(selectedBar: $selectedBar)
            }
            
            bottomNavBar
        }.edgesIgnoringSafeArea(.all)
    }
    private var topBar: some View {
        HStack {
            if selectedBar == .checkout {
                Text("CANCEL")
                    .font(.system(size: 14,weight: .medium)).onTapGesture {
                        selectedBar = .cart

                    }
                Spacer()
            }
            else {
                if selectedBar == .details || selectedBar == .products {
                    Image("back")
                        .onTapGesture {
                            if selectedBar == .details {
                                selectedBar = .products
                            }
                            else {
                                selectedBar = .category
                            }
                        }
                }
                HStack {
                    Image("search")
                    TextField(searchPlaceholder, text: $searchValue)
                        .font(.system(size: 14,weight: .regular))
                        .foregroundColor(Color.black)
                        .placeholder(when: searchValue.isEmpty) {
                            Text(searchPlaceholder)
                                .font(.system(size: 14,weight: .regular))
                                .foregroundColor(Color.gray)
                        }
                    
                    
                }
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 4).stroke(Color.gray, lineWidth: 0.7))
                .background(RoundedRectangle(cornerRadius: 4).foregroundColor(Color.white))
            }
        }
        .frame(height: 100,alignment: .bottom)
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("Header 1"), Color("Header 2"),Color("Header 3"),Color("Header 4")]), startPoint: .leading, endPoint: .trailing)
        )
    }
    private var bottomNavBar: some View {
        VStack(spacing: 0) {
            Divider().frame(height: 0.5).background(Color.gray)
            HStack {
                BottomBarItem(iconName: "home", isSelectedBar: selectedBar != .cart,countOfCart: .constant(0))
                    .onTapGesture {
                        if selectedBar == .cart {
                            selectedBar = .category
                        }
                    }
                BottomBarItem(iconName: "user", isSelectedBar: false,countOfCart: .constant(0))
                BottomBarItem(iconName: "cart", isSelectedBar: selectedBar == .cart,countOfCart: .constant(items.count))
                    .onTapGesture {
                        if selectedBar != .cart {
                            selectedBar = .cart
                        }
                    }
                BottomBarItem(iconName: "more", isSelectedBar: false,countOfCart: .constant(0))

            }.padding([.horizontal,.bottom])
        }.background(Color.white)
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
