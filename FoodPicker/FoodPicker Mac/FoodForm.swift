//
//  FoodForm.swift
//  FoodPicker
//
//  Created by Daniel on 15/6/2025.
//

import SwiftUI

private enum MyField {
    case title,image
    
}

extension FoodList{
    struct FoodForm: View {
        @State var food: Food
        @Environment(\.dismiss) var dismiss
        @FocusState private var field: MyField?
        
        var onSubmit:(Food) -> Void
        
        
        private var isNotValid: Bool{
            food.name.isEmpty || food.image.count > 2
        }
        
        private var invalidMessage: String?{
            if food.name.isEmpty{ return "請輸入名稱" }
            if food.image.count > 2{ return "圖示字數過多" }
            return .none
        }
      
        var body: some View {
            VStack{
                HStack{
                    Label(title: {
                        Text("編輯食物資訊")
                    }, icon: {
                        Image(systemName: "pencil.and.list.clipboard")
                    })
                    .padding(.leading)
                    .frame(height: 20)
                    .font(.title.bold())
                    .foregroundColor(.accentColor)
                    
                    Spacer()
                    
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("關閉")
                    })
                    .foregroundColor(.accentColor)
                }
                .padding(.horizontal)
                .padding(.top).padding(.top)
                
                Form{
                    LabeledContent("名稱"){
                        TextField("必填", text: $food.name)
                            .submitLabel(.next)
                            .focused($field,equals: .title)
                            .onSubmit {
                                field = .image
                            }
                    }
                    
                    LabeledContent("圖示"){
                        TextField("可選 最多輸入2個表情符號", text: $food.image)
                            .submitLabel(.next)
                            .focused($field,equals: .image)
                            .onSubmit {
                                field = nil
                            }
                    }
                    
                }
                
                Button(action: {
                    dismiss()
                    onSubmit(food)
                }, label: {
                    Text(invalidMessage ?? "儲存")
                        .frame(maxWidth: .infinity)
                        .font(.title3.bold())
                })
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .tint(.accentColor)
                .padding()
                .disabled(isNotValid)
                
            }
            .background(Color(.secondarySystemFill))
            .multilineTextAlignment(.trailing)
            .scrollDismissesKeyboard(.interactively)
        }
    }
}

#Preview {
    FoodList.FoodForm(food:Food.examples.first!) {_ in}
}
