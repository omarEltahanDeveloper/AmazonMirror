//
//  ProductDetailsView.swift
//  AmazonMirrorApp
//
//  Created by Omar M1 on 13/04/2023.
//

import SwiftUI

struct ProductDetailsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Products.productname, ascending: true)], predicate: NSPredicate(format: "productid == %i", UserDefaults.standard.integer(forKey: "productid")),
        animation: .default)
    var itemSelected: FetchedResults<Products>

    @State var showAlert = false
    @State var searchValue = ""
    var searchPlaceholder = "Search Amazon.eg"
    var modelOfProduct : productModel
    @Binding var selectedBar : HomeFullView
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                Image("banner").resizable().scaledToFit().frame(height: 40)
                VStack(alignment: .leading) {
                    ZStack(alignment: .top) {
                        Image(modelOfProduct.productImage).resizable().scaledToFit()
                            .frame(width: UIScreen.main.bounds.width - 20 ,height: UIScreen.main.bounds.height / 3,alignment: .center)
                        HStack {
                            Text(String(modelOfProduct.discount) + "%\noff")
                                .font(.system(size: 12,weight: .semibold))
                                .frame(width: 40,height: 40)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.white)
                                .background(Color("RedColor"))
                                .clipShape(Circle())
                            
                            Spacer()
                            
                            Image("share")
                                .padding(10)
                                .overlay(
                                    Circle().stroke(Color.gray, lineWidth: 0.5))
                        }
                    }
                    HStack {
                        Text("Visit " + modelOfProduct.companyName + " Store")
                            .font(.system(size: 12,weight: .regular))
                            .foregroundColor(Color("DarkBlue"))
                            .onTapGesture {
                                let url = URL(string: modelOfProduct.companyWebsite)
                                UIApplication.shared.open(url!)
                            }
                        Spacer()
                        HStack(spacing: 0) {
                            ForEach(0..<5) { number in
                                if number < modelOfProduct.ratingCount {
                                    Image("star-on")
                                        .renderingMode(.template).foregroundColor(Color("RatingColor"))
                                } else {
                                    Image("star-off")
                                        .renderingMode(.template).foregroundColor(Color("RatingColor"))
                                }
                            }
                        }
                        Text(String(modelOfProduct.ratingCount))
                            .font(.system(size: 14,weight: .regular))
                            .padding(.leading,2)
                    }.padding(.top)
                    Text(modelOfProduct.productName)
                        .font(.system(size: 16,weight: .bold))
                        .frame(alignment: .leading)
                    Divider()
                    HStack {
                        Text("Digital storage capacity:" )
                            .font(.system(size: 14,weight: .regular))
                        Text(modelOfProduct.digitalStorage)
                            .font(.system(size: 14,weight: .semibold))
                    }
                    Divider()
                    HStack {
                        Text( "-" + String(modelOfProduct.discount) + "%" )
                            .font(.system(size: 25,weight: .regular))
                            .foregroundColor(Color("RedColor"))
                        HStack(spacing: 0) {
                            Text("EGP")
                                .font(.system(size: 16,weight: .regular))
                            Text(String(modelOfProduct.priceNow))
                                .font(.system(size: 25,weight: .semibold))
                        }
                    }
                    HStack {
                        Text("Last Price")
                            .font(.system(size: 14,weight: .light))
                        Text(modelOfProduct.priceBefore)
                            .font(.system(size: 16,weight: .light))
                            .strikethrough()
                    }
                    Text("FREE shipping")
                        .font(.system(size: 12,weight: .regular))
                        .foregroundColor(Color("DarkBlue"))
                    
                    
                    VStack {
                        Text("Add to Cart")
                            .font(.system(size: 16,weight: .semibold))
                            .foregroundColor(Color.black)
                            .frame(width: UIScreen.main.bounds.width - 40,height: 40)
                            .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.yellow))
                            .onTapGesture {
                                checkItem()
                            }
                        
                        Text("Buy Now")
                            .font(.system(size: 16,weight: .semibold))
                            .foregroundColor(Color.black)
                            .frame(width: UIScreen.main.bounds.width - 40,height: 40)
                            .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.orange))
                        
                    }.padding(.top)
                    
                }.padding()
                
            }
            .alert(isPresented: self.$showAlert) {
                Alert(title: Text("Product added successfully"), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func checkItem() {
       
        if itemSelected.count > 0 {
            updateItem(item: itemSelected[0])
        }
        else {
            addItem()
        }
    }
    private func updateItem(item: Products) {
        item.quantity += 1
        saveChanges()
    }
    private func saveChanges() {
        withAnimation {
            do {
                try viewContext.save()
                self.showAlert = true
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func addItem() {
        let newItem = Products(context: viewContext)
        newItem.productname = modelOfProduct.productName
        newItem.productid = Int16(modelOfProduct.id)
        newItem.quantity = Int16(1)
        newItem.productimage = modelOfProduct.productImage
        newItem.productprice = modelOfProduct.priceNow
        
        saveChanges()
    }
}

struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView(modelOfProduct: productModel(id: 1, productImage: "ProductImage1", productName: "Samsung Galaxy A04e Dual SIM - 3GB Ram, 32GB size", ratingCount: 4, discount: 20, discountTime: "23:23", priceNow: 3349.00, priceBefore: "4,210.00", companyName: "Samsung", companyWebsite: "https://www.samsung.com/eg/", digitalStorage: "32 GB"), selectedBar: .constant(.details))
    }
}
