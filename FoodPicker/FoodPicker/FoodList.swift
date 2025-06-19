import SwiftUI

struct FoodList: View {
    @State private var editMode: EditMode = .inactive
    @State private var food: [Food] = []
    @State private var selectedFoodID = Set<Food.ID>()
    @State private var showFoodForm: Bool = false
    @State private var selectedFood: Food?

    var isEditing: Bool { editMode.isEditing }

    var body: some View {
        VStack {
            HStack {
                Label(title: {
                    Text("食物清單")
                }, icon: {
                    Image(systemName: "fork.knife")
                })
                .font(.title.bold())
                .foregroundColor(.accentColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                resetButton
                addButton
                EditButton()
                    .foregroundColor(.accentColor)
                    .buttonStyle(.bordered)
            }
            .padding()

            List($food, editActions: .all, selection: $selectedFoodID) { $food in
                HStack {
                    Text(food.name + " " + food.image)
                        .font(.title2)
                        .padding(.vertical, 10)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    if isEditing {
                        Image(systemName: "pencil")
                            .font(.title2.bold())
                            .foregroundColor(.accentColor)
                            .onTapGesture {
                                selectedFood = food
                            }
                    }
                }.listRowBackground(Color.clear)
            }
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.secondarySystemGroupedBackground))
                    .ignoresSafeArea()
            }
            .padding(.horizontal)
            .listStyle(.plain)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
        .environment(\.editMode, $editMode)
        .safeAreaInset(edge: .bottom) {
            if isEditing {
                Button(action: {
                    withAnimation {
                        food = food.filter { !selectedFoodID.contains($0.id) }
                    }
                }, label: {
                    Text("刪除已選項目")
                        .font(.title2.bold())
                        .frame(maxWidth: .infinity)
                })
                .padding(.bottom)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .cornerRadius(8)
                .padding(.horizontal, 50)
            }
        }
        .sheet(item: $selectedFood) { food in
            FoodForm(food: food) { updatedFood in
                if let index = self.food.firstIndex(where: { $0.id == updatedFood.id }) {
                    self.food[index] = updatedFood
                }
            }
        }
        .sheet(isPresented: $showFoodForm) {
            FoodForm(food: Food(name: "", image: "")) { newFood in
                self.food.append(newFood)
            }
        }
        .onAppear {
            loadData()
        }
        .onChange(of: food) { _ in
            saveData()
        }
    }

    private var addButton: some View {
        Button(action: {
            showFoodForm = true
        }) {
            Image(systemName: "plus.circle.fill")
                .font(.system(size: 40))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, Color.accentColor.gradient)
        }
    }
    
    private var resetButton: some View {
        Button(action: {
            withAnimation{
                food = Food.examples
                saveData()
            }
        }) {
            Image(systemName: "restart.circle.fill")
                .font(.system(size: 40))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white, Color.red.gradient)
        }
    }

    private func loadData() {
        if let data = UserDefaults.standard.data(forKey: "foodList") {
            do {
                food = try JSONDecoder().decode([Food].self, from: data)
            } catch {
                print("Failed to load data: \(error.localizedDescription)")
            }
        } else {
            food = Food.examples
        }
    }

    private func saveData() {
        do {
            let encoded = try JSONEncoder().encode(food)
            UserDefaults.standard.set(encoded, forKey: "foodList")
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
        }
    }
}

#Preview {
    FoodList()
}
