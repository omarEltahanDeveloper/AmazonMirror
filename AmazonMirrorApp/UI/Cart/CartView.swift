//
//  CartView.swift
//  AmazonMirrorApp
//
//  Created by Omar M1 on 13/04/2023.
//

import SwiftUI

struct CartView: View {

    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Products.productname, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Products>
    @Binding var selectedBar : HomeFullView

    @State var subtotal : Double = 0.00
    var body: some View {
        ScrollView {
            VStack(alignment: .leading,spacing: 0) {
                if items.count > 0 {
                    HStack {
                        Text("Subtotal")
                            .font(.system(size: 18,weight: .medium))
                            .foregroundColor(Color.black)
                        HStack(alignment: .top,spacing: 0) {
                            Text("EGP")
                                .font(.system(size: 12,weight: .semibold))
                                .foregroundColor(Color.black)
                            Text(String(subtotalCalculation()))
                                .font(.system(size: 20,weight: .bold))
                                .foregroundColor(Color.black)
                        }
                        Spacer()
                    }
                    HStack(spacing: 2) {
                        Image("check").resizable().scaledToFit().frame(width: 20,height: 20)
                        Text("You order qualifies for FREE Shipping")
                            .font(.system(size: 14,weight: .regular))
                            .foregroundColor(Color("GreenColor"))
                    }.padding(.top)
                    HStack(spacing: 5) {
                        Text("Choose this option at checkout.")
                            .font(.system(size: 14,weight: .regular))
                            .foregroundColor(Color.black)
                        Text("See details")
                            .font(.system(size: 13,weight: .regular))
                            .foregroundColor(Color("GreenColor"))
                    }.padding(.leading,25)
                    
                    Text("Proceed to Buy (" + String(items.count) + " item)")
                        .font(.system(size: 16,weight: .semibold))
                        .foregroundColor(Color.black)
                        .frame(width: UIScreen.main.bounds.width - 40,height: 40)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.yellow))
                        .padding(.vertical).onTapGesture {
                            selectedBar = .checkout
                        }
                    
                    Divider().background(Color.gray)
                    
                    ForEach(0..<items.count, id: \.self) { index in
                        CartItem(productItem: items[index])
                    }
                   
                    
                    Divider().background(Color.gray)
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text("Returns are easy")
                            .font(.system(size: 18,weight: .semibold))
                            .foregroundColor(Color.black)
                        Text("30-day returns on millions of items")
                            .font(.system(size: 14,weight: .regular))
                            .foregroundColor(Color.black)
                    }
                    Spacer()
                    Image("return").resizable().scaledToFit().frame(width: 50,height: 50)
                    
                }.padding(.vertical)
                
                
                Spacer()
            }.padding()
        }
    }
    
    func subtotalCalculation() -> Double{
        var subtotalis = 0.0
        for i in items {
            subtotalis = subtotalis + (i.productprice * Double(i.quantity))
        }
        
        return subtotalis
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(selectedBar: .constant(.cart))
    }
}
