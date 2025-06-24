import SwiftUI

struct ContentView: View {
    @State private var foodList: [Food] = []
    @State private var selectedFood: Food?

    init() {
        loadData()
    }

    var body: some View {
        VStack {
            Spacer()
            
            Group {
                if selectedFood == nil {
                    Image("dinner")
                        .resizable()
                        .scaledToFit()
                } else {
                    Text(selectedFood!.image)
                        .font(.system(size: 200))
                        .lineLimit(1)
                        .minimumScaleFactor(0.01)
                        .id(selectedFood!.name)
                }
            }
            .frame(height: 250)
            
            Text("吃飯小決定")
                .font(.largeTitle.bold())
            
            if let food = selectedFood {
                Text(food.name)
                    .font(.largeTitle.bold())
                    .foregroundColor(.green)
                    .id(food.name)
                    .padding()
            }

            Spacer()
            
            Button(action: {
                selectedFood = foodList.shuffled().first { $0 != selectedFood }
            }, label: {
                Text(selectedFood == nil ? "告訴我" : "換一個")
                    .font(.title)
                    .frame(width: 200)
            })
            .controlSize(.large)
            .tint(.accentColor)
            .foregroundColor(.white)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .glassEffect()
            
            Button(action: {
                selectedFood = nil
            }, label: {
                Text("重置")
                    .font(.title)
                    .frame(width: 150)
            })
            .foregroundColor(.accentColor)
            .controlSize(.large)
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
            .padding()
        }
        .animation(.easeInOut, value: selectedFood)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.secondarySystemFill))
        .onAppear {
            loadData()
        }
    }

    private func loadData() {
        if let data = UserDefaults.standard.data(forKey: "foodList") {
            do {
                foodList = try JSONDecoder().decode([Food].self, from: data)
            } catch {
                print("Failed to load data: \(error.localizedDescription)")
            }
        } else {
            // 如果沒有數據，使用示例數據
            foodList = Food.examples
        }
    }

    private func saveData() {
        do {
            let encoded = try JSONEncoder().encode(foodList)
            UserDefaults.standard.set(encoded, forKey: "foodList")
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
}
