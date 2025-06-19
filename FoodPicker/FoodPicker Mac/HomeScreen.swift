//
//  HomeScreen.swift
//  FoodPicker
//
//  Created by Daniel on 15/6/2025.
//

import SwiftUI

struct HomeScreen: View {
    @State var tab : Int = 0
    
    var body: some View {
        
        TabView(selection: $tab){
            ContentView().tabItem{
                Image(systemName: "house")
                Text("主頁")
            }.tag(0)
            FoodList().tabItem{
                Image(systemName: "list.bullet")
                Text("食物清單")
            }.tag(1)
        }
        
    }
}

#Preview {
    HomeScreen()
}
