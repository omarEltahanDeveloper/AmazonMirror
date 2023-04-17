//
//  CheckoutView.swift
//  AmazonMirrorApp
//
//  Created by Omar M1 on 17/04/2023.
//

import SwiftUI

struct CheckoutView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Products.productname, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Products>
    
    @State var showAlert = false
    @Binding var selectedBar : HomeFullView
    

    var body: some View {
        VStack {
            
            VStack {
                ForEach(items) { item in
                    if items.first?.id != item.id {
                        Divider().background(Color.gray)
                    }
                    Checkoutcartitem(productItem: item)
                }
                Divider().background(Color.gray)
                HStack(alignment: .top) {
                    Text("Deliver to")
                        .font(.system(size: 14,weight: .regular))
                        .foregroundColor(Color("DarkBlue"))
                    Spacer().frame(width: 20)
                    VStack(alignment: .leading,spacing: 5) {
                        Text("Omar eltahan")
                            .font(.system(size: 14,weight: .medium))
                            .foregroundColor(Color.black)
                        Text("Cairo Cairo Cairo")
                            .font(.system(size: 13,weight: .regular))
                            .foregroundColor(Color.gray)
                    }
                    Spacer()
                    Image("arrow").resizable().scaledToFit().frame(width: 20,height: 20)
                }
                Divider().background(Color.gray)

                HStack(alignment: .top) {
                    Text("Get it by")
                        .font(.system(size: 14,weight: .regular))
                        .foregroundColor(Color("DarkBlue"))
                    Spacer().frame(width: 20)
                    VStack(alignment: .leading,spacing: 5) {
                        Text("Thursday, Apr 13")
                            .font(.system(size: 14,weight: .medium))
                            .foregroundColor(Color.black)
                        Text("Free standard delivery")
                            .font(.system(size: 13,weight: .regular))
                            .foregroundColor(Color.gray)
                    }
                    Spacer()
                    Image("arrow").resizable().scaledToFit().frame(width: 20,height: 20)
                }
                
                
            }.padding(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 0.5))
            .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.white))
           
            
            Text("Continue")
                .font(.system(size: 16,weight: .semibold))
                .foregroundColor(Color.black)
                .frame(width: UIScreen.main.bounds.width - 40,height: 40)
                .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.yellow))
                .padding()
                .onTapGesture {
                    showAlert = true
                }
            Spacer()
        }.background(Color("LightGrey"))
        .alert(isPresented: self.$showAlert) {
            Alert(title: Text("Order requested successfully"), dismissButton: .default(Text("OK")) {
                showAlert = false
                deleteAllItems()
                selectedBar = .category
            })
        }
    }
    private func deleteAllItems() {
        for i in items {
            viewContext.delete(i)
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

//struct CheckoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckoutView()
//    }
//}
