//
//  ContentView.swift
//  CustomGridDemo
//
//  Created by Shawn Schwartz on 1/14/22.
//
// Adapted from and inspired by: https://www.youtube.com/watch?v=F-PcYUgUySk
// Icons downloaded from: https://icons8.com/icon/set/support/small
//

import SwiftUI

struct Item: Identifiable {

    let id = UUID()
    let title: String
    let image: String
    let imgColor: Color
    
}

struct ContentView: View {
    
    // declare button items
    let items = [
        Item(title: "Home", image: "home", imgColor: .orange),
        Item(title: "Money", image: "money", imgColor: .green),
        Item(title: "Bank", image: "bank", imgColor: Color.black.opacity(0.8)),
        Item(title: "Vacation", image: "vacation", imgColor: .green),
        Item(title: "User", image: "user", imgColor: .blue),
        Item(title: "Charts", image: "chart", imgColor: .orange),
        Item(title: "Support", image: "support", imgColor: .purple)
    ]
    
    // define constants
    let spacing: CGFloat = 10
    
    // define state variables
    @State private var numberOfColumns = 3 // change this to change the number of items per row (looks good with 3)
    @State private var currentBGColor: Color = .purple // always start at color purple
    
    var body: some View {
        let columns = Array(repeating: GridItem(.flexible(), spacing: spacing), count: numberOfColumns)
        
        ScrollView {
            headerView
            
            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach(items) { item in
                    Button(action: {}) {
                        ItemView(item: item)
                    }
                    .buttonStyle(ItemButtonStyle(cornerRadius: 20))
                }
            }
            .padding(.horizontal)
            .offset(y: -50) // make the grid cells hover over the colored backdrop
        }
        .background(Color.white)
        .ignoresSafeArea()
    }
    
    var headerView: some View {
        VStack {
            Image("avatar") // leave it just like this with no params to have full view (looks cool)
                .resizable()
                .frame(width: 110, height: 110)
                .clipShape(Circle())
                .overlay(Circle().stroke(.white, lineWidth: 4))
                .onTapGesture {
                    let colors: [Color] = [.red, .gray, .green, .yellow, .blue, .purple].shuffled()
                    numberOfColumns = numberOfColumns % 3 + 1
                    currentBGColor = colors[0]
                }
            
            Text("Shawn Schwartz")
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .bold, design: .rounded))
            
            Text("Strive not to be a success, but rather to be of value")
                .foregroundColor(Color.white.opacity(0.7))
                .font(.system(size: 16, weight: .medium, design: .rounded))
                .multilineTextAlignment(.center)
        }
        .frame(height: 350)
        .frame(maxWidth: .infinity)
        .background(currentBGColor)
    }
    
}

struct ItemButtonStyle: ButtonStyle {
    let cornerRadius: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.label
            
            if configuration.isPressed {
                Color.black.opacity(0.2)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.2), radius: 10, y: 5)
    }
}

struct ItemView: View {
    
    let item: Item
    
    var body: some View {
        GeometryReader { reader in
            // dynamically update text and image to fit dimensions
            let fontSize = min(reader.size.width * 0.2, 28)
            let imageWidth: CGFloat = min(50, reader.size.width * 0.6)
            
            VStack(spacing: 5) {
                Image(item.image)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(item.imgColor)
                    .frame(width: imageWidth)
                
                Text(item.title)
                    .font(.system(size: fontSize, weight: .bold, design: .rounded))
                    .foregroundColor(Color.black.opacity(0.9))
            }
            .frame(width: reader.size.width, height: reader.size.height)
            .background(.white)
        }
        .frame(height: 150)
//        .clipShape(RoundedRectangle(cornerRadius: 20))
//        .shadow(color: Color.black.opacity(0.2), radius: 10, y: 5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
