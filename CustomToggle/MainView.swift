//
//  MainView.swift
//  CustomToggle
//
//  Created by ELMIR ISMAYILZADA on 28.08.22.
//

import SwiftUI

struct MainView: View {
    
    @State var counter = 0
    @State var circleOffset = CGSize.zero
    @State var plusMinusCounter = CounterPlusMinus.equal
    @State var value = CGSize.zero
    
    //@State var capsuleOffset = CGSize.zero
    
    var body: some View {
        
        ZStack {
            
            Color("Background")
                .ignoresSafeArea()
            
            VStack {
                
                Text("\(counter)")
                    .font(.system(size: 80))
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                                
                Capsule()
                    //.offset(x: capsuleOffset.width)
                    .frame(width: 150, height: 60)
                    .foregroundColor(Color("Color1"))
                    .overlay {
                        ZStack {
                            HStack {
                                Image(systemName: "minus")
                                    .font(.title2)
                                    .foregroundColor(.gray)
                                
                                Spacer()
                                
                                Image(systemName: "plus")
                                    .font(.title2)
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal)
                            
                            Circle()
                                .offset(x: circleOffset.width)
                                .fill(.gray)
                                .padding(6)
                                .animation(.default, value: value)
                                .gesture(DragGesture(minimumDistance: 0).onChanged({ position in
                                    
                                    if position.translation.width <= 43 && position.translation.width >= -43 {
                                        self.circleOffset = position.translation
                                        self.value = position.translation
                                        
                                        if position.translation.width >= 30 {
                                            self.plusMinusCounter = .plus
                                        }
                                        if position.translation.width <= -30 {
                                            self.plusMinusCounter = .minus
                                        }
                                        print("DEBUG: \(position.translation.width)")
                                    }
                                }).onEnded({ _ in
                                    self.circleOffset = .zero
                                    self.value = .zero
                                    self.counter += plusMinusCounter.value
                                    self.plusMinusCounter = .equal
                                }))
                        }
                    }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

enum CounterPlusMinus: Int, CaseIterable {
    case plus
    case minus
    case equal
    
    var value: Int {
        switch self {
        case .plus:
            return 1
        case .minus:
            return -1
        case .equal:
            return 0
        }
    }
}
