//
//  ContentView.swift
//  FoodPicker Watch Watch App
//
//  Created by Daniel on 19/6/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var food = Food.examples
    @State private var selectedFood: Food?
    var body: some View {
        VStack {
            Group{
                if selectedFood == nil{
                    Image(.dinner)
                        .resizable()
                        .scaledToFit()
                }else{
                    Text(selectedFood!.image)
                        .font(.system(size: 200))
                        .lineLimit(1)
                        .minimumScaleFactor(0.01)
                        .id(selectedFood!.name)
                }
            }
            .frame(height: 70)
            .offset(y:10)
            
            Text("吃飯小決定")
                .font(.title2.bold())
                
            if selectedFood != nil{
                Text(selectedFood!.name)
                    .id(selectedFood!.image)
                    .foregroundColor(.green)
            }

            VStack{
                Button(action: {
                    selectedFood = food.shuffled().first { $0 != selectedFood}
                }, label: {
                    Text(selectedFood == nil ? "告訴我" : "換一個")
                        .font(.title3)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity,maxHeight: 200, alignment: .center)
                })
                .buttonStyle(.plain)
                .background{
                    RoundedRectangle(cornerRadius: 60)
                        .fill(.blue)
                        .onTapGesture {
                            selectedFood = food.shuffled().first { $0 != selectedFood}
                        }
                }
                
                Button(action: {
                    selectedFood = nil
                    return
                }, label: {
                    Text("重置")
                        .font(.title3)
                        .padding(.vertical)
                        .frame(maxWidth: .infinity, minHeight: 30, alignment: .center)
                })
                .buttonStyle(.plain)
                .background{
                    RoundedRectangle(cornerRadius: 60)
                        .fill(.tint.opacity(0.4))
                        .onTapGesture {
                            selectedFood = nil
                        }
                }
                .padding(.horizontal,20)
                .offset(y:5)
                
            }.padding(.bottom,40)

            
        }
        .animation(.easeInOut, value: selectedFood)
    }
}

#Preview {
    ContentView()
}

