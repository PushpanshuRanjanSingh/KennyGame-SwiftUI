//
//  ContentView.swift
//  KennyGame
//
//  Created by Pushpanshu Ranjan Singh on 01/07/20.
//  Copyright © 2020 Pushpanshu Ranjan Singh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var score = 0
    @State var timeleft = 10.0
    @State var chosenX = UIScreen.main.bounds.width * 0.5
    @State var chosenY = UIScreen.main.bounds.height * 0.35
    @State var showAlert = false
    let (x1,y1) = (UIScreen.main.bounds.width * 0.1, UIScreen.main.bounds.height * 0.3)
    let (x2,y2) = (UIScreen.main.bounds.width * 0.5, UIScreen.main.bounds.height * 0.3)
    let (x3,y3) = (UIScreen.main.bounds.width * 0.9, UIScreen.main.bounds.height * 0.3)
    let (x4,y4) = (UIScreen.main.bounds.width * 0.1, UIScreen.main.bounds.height * 0.1)
    let (x5,y5) = (UIScreen.main.bounds.width * 0.5, UIScreen.main.bounds.height * 0.1)
    let (x6,y6) = (UIScreen.main.bounds.width * 0.9, UIScreen.main.bounds.height * 0.1)
    let (x7,y7) = (UIScreen.main.bounds.width * 0.1, UIScreen.main.bounds.height * 0.6)
    let (x8,y8) = (UIScreen.main.bounds.width * 0.5, UIScreen.main.bounds.height * 0.6)
    let (x9,y9) = (UIScreen.main.bounds.width * 0.9, UIScreen.main.bounds.height * 0.6)
    
    var countTimer : Timer{
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            
            if self.timeleft < 0.5 {
                self.chosenX = UIScreen.main.bounds.width * 0.5
                self.chosenY = UIScreen.main.bounds.height * 0.3
                self.showAlert = true
            }
            else{
                self.timeleft -= 1
            }
        }
    }
    
    var timer : Timer{
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            let tupleArray = [(self.x1,self.y1), (self.x2,self.y2), (self.x3,self.y3), (self.x4,self.y4), (self.x5,self.y5), (self.x6,self.y6), (self.x7,self.y7), (self.x8,self.y8), (self.x9,self.y9),
            ]
            
            var previousNumber: Int?
            
            func randomNumberGenerator() -> Int{
                var randomNumber = Int(arc4random_uniform(UInt32(tupleArray.count-1)))
                
                while previousNumber == randomNumber {
                    randomNumber = Int(arc4random_uniform(UInt32(tupleArray.count-1)))
                }
                
                previousNumber = randomNumber
                
                return randomNumber
            }
            
            self.chosenX = tupleArray[randomNumberGenerator()].0
            self.chosenY = tupleArray[randomNumberGenerator()].1
        }
    }
    var body: some View {
        VStack{
            
            Spacer()
                .frame(height: 50)
            
            Text("Catch The Kenny")
                .font(.largeTitle)
            
            HStack {
                Text("Time Left: ")
                    .font(.title)
                Text(String(self.timeleft))
                    .font(.title)
            }
            
            HStack {
                Text("Score: ")
                    .font(.title)
                Text(String(self.score))
                    .font(.title)
            }
            
            
            Spacer()
            
            Image("kenny")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.width * 0.3)
                .position(x: self.chosenX, y: self.chosenY)
                .gesture(TapGesture(count: 1).onEnded({ (_) in
                    self.score += 1
                }))
                .onAppear{
                    _ = self.timer
                    _ = self.countTimer
            }
            
            Spacer()
        }.alert(isPresented: $showAlert) {
            return Alert(title: Text("Game Over"), message: Text("Do you want play Again?"), primaryButton: Alert.Button.default(Text("Okay"), action: {
                //
                self.score = 0
                self.timeleft = 10.0
            }), secondaryButton: Alert.Button.cancel(Text("Cancel"), action: {
                exit(0)
                }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ContentView().previewDevice("iPhone 8").previewDisplayName("iPhone 8")
            ContentView().previewDevice("iPhone 11 Pro").previewDisplayName("iPhone 11")
        }
    }
}
