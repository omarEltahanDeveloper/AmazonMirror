//
//  CartItem.swift
//  AmazonMirrorApp
//
//  Created by Omar M1 on 15/04/2023.
//

import SwiftUI

struct CartItem: View {
    @Environment(\.managedObjectContext) private var viewContext
    var productItem : Products
    @State var counter : Int
    init(productItem: Products) {
        self.productItem = productItem
        self.counter = Int(productItem.quantity)
    }
    var body: some View {
        VStack {
            HStack {
                Image(productItem.productimage ?? "").resizable().scaledToFit()
                    .frame(width: UIScreen.main.bounds.width / 4 ,height: UIScreen.main.bounds.width / 4)
                VStack(alignment: .leading,spacing: 3) {
                    Text(productItem.productname ?? "")
                        .font(.system(size: 12,weight: .regular))
                    HStack(alignment: .top,spacing: 0) {
                        Text("EGP")
                            .font(.system(size: 12,weight: .semibold))
                        Text(String(productItem.productprice * Double(productItem.quantity)))
                            .font(.system(size: 18,weight: .bold))
                    }
                    
                    Text("Eligible for FREE devliery")
                        .font(.system(size: 10,weight: .regular))
                        .foregroundColor(.gray)
                    Text("In Stock")
                        .font(.system(size: 12,weight: .medium))
                        .foregroundColor(Color("GreenColor"))
                    
                    HStack {
                        Text("Colour:")
                            .font(.system(size: 12,weight: .semibold))
                        Text("Black")
                            .font(.system(size: 12,weight: .regular))
                    }
                    
                    
                }
            }
            
            HStack {
                HStack(spacing: 0) {
                    Image(productItem.quantity > 1 ? "minus" : "delete").resizable().scaledToFit()
                        .frame(width: 16,height: 16)
                        .padding(.vertical,6).padding(.horizontal,10)
                        .onTapGesture {
                            if productItem.quantity > 1 {
                                self.counter = self.counter - 1
                                productItem.quantity = Int16(self.counter)
                                saveChanges()
                            }
                            else {
                                deleteItems()
                            }
                        }
                    Divider().background(Color.gray)
                        
                    Text(String(productItem.quantity))
                        .foregroundColor(Color("DarkBlue"))
                        .frame(width: 60,height: 30)
                        .background(Color.white)
                    Divider().background(Color.gray)
                    Image("add")
                        .resizable().scaledToFit()
                            .frame(width: 16,height: 16)
                        .padding(.vertical,6).padding(.horizontal,10)
                        .onTapGesture {
                            if productItem.quantity < 10 {
                                self.counter = self.counter + 1
                                productItem.quantity = Int16(self.counter)
                                saveChanges()
                            }
                        }
                }.frame(height: 30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 0.7))
                    .background(RoundedRectangle(cornerRadius: 6).foregroundColor(Color("GreyMedium")))
                
                Text("Delete")
                    .font(.system(size: 10,weight: .medium))
                    .foregroundColor(Color.black)
                    .frame(height: 30)
                    .padding(.horizontal,8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 0.7))
                    .background(RoundedRectangle(cornerRadius: 6).foregroundColor(Color.white))
                    .onTapGesture {
                        deleteItems()
                    }
                
                Text("Save for later")
                    .font(.system(size: 10,weight: .medium))
                    .foregroundColor(Color.black)
                    .frame(height: 30)
                    .padding(.horizontal,8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 0.7))
                    .background(RoundedRectangle(cornerRadius: 6).foregroundColor(Color.white))
                Spacer()
            }
        }.padding(5).background(Color("LightGrey"))

    }
    private func saveChanges() {
        withAnimation {
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    private func deleteItems() {
        withAnimation {
            viewContext.delete(productItem)
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}
//
//struct CartItem_Previews: PreviewProvider {
//    static var previews: some View {
//        CartItem(productItem: )
//    }
//}
