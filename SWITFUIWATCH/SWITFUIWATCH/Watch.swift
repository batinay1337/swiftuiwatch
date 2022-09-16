//
//  Watch.swift
//      Watch
//
//  Created by Batınay Ünsel on 17/08/2022.
//

import SwiftUI

struct Watch: View {
    
    @State var isDark = false
    @State var currentTime = Time(sec: 15, min: 10, hour: 10)
    var receiver = Timer.publish(every: 1, on: .current, in: .default)
        .autoconnect()
    
    var body: some View {
        VStack {
            
            
            Spacer()
            clockFace(isDark: $isDark, currentTime: $currentTime)
            //MARK: Time text: (ex. 11.23 AM)
            /*Text(getTime())
             // .font(.system(size: 15))
                .fontWeight(.bold)
                
                .padding(.bottom,10)
            */
            Text(hiTime())
            //Good Afternoon
            .font(.custom("Poppins Bold", size: 18)).foregroundColor(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.75))).tracking(0.72)
            .shadow(radius: 12)
            
            Spacer()
        }
        .onAppear(perform: {
            getTimeComponents()
        })
        .onReceive(receiver) { _ in
            getTimeComponents()
        }
    }
    private func getTime() -> String {
        let format = DateFormatter()
        format.dateFormat = "hh:mm a"
        return format.string(from: Date())
    }
    
    private func hiTime() -> String {
        
        let format = DateFormatter()
        format.dateFormat = "hh a"
        let fullTime: String = format.string(from: Date())
        var timeCircle: Int = 0
        let formatArr = fullTime.components(separatedBy: " ")
        
        if formatArr[1] == "PM"{
            timeCircle += 12
        }
        
        timeCircle = ((formatArr[0] as NSString).integerValue) + timeCircle
        
        
        
        
        
        if 5 <= timeCircle && timeCircle <= 11 {
            return "Good Morning!"
        }
        
        if 11 <= timeCircle && timeCircle <= 17 {
            return "Good Afternoon!"
        }
        
        if 17 <= timeCircle && timeCircle <= 23 {
            return "Good Evening!"
        }
        
        else {
            return "Good Night!"
        }
        
        
    }
    
    private func getTimeComponents() {
        let calender = Calendar.current
        let sec = calender.component(.second, from: Date())
        let min = calender.component(.minute, from: Date())
        let hour = calender.component(.hour, from: Date())
        withAnimation(Animation.linear(duration: 0.01)) {
            currentTime = Time(sec: sec, min: min, hour: hour)
        }
    }
}

struct clockFace: View {
    
    @Binding var isDark: Bool
    @Binding var currentTime: Time
    var width = UIScreen.main.bounds.width
    var body: some View {
        ZStack {
            Circle()
                .fill(.ultraThinMaterial)
                
            ForEach(0..<60) { second in
                Rectangle()
                    .fill(Color.primary)
                    .frame(width:  0.6, height: (second % 5) == 0 ? 7 : 2)
                    .offset(y: (width - 313) / 2)
                    .rotationEffect(.init(degrees: Double(second) * 6))
            }
            
            Rectangle()
                .fill(Color.primary)
                .frame(width: 1, height: (width - 300) / 2)
                .cornerRadius(2)
                .offset(y: -(width - 300) / 4)
                .rotationEffect(.init(degrees: Double(currentTime.sec) * 6))
        
            Rectangle()
                .fill(Color.primary)
                .frame(width: 1.8, height: (width - 310) / 2)
                .cornerRadius(2)
                .offset(y: -(width - 310) / 4)
                .rotationEffect(.init(degrees: Double(currentTime.min) * 6))
           
            Rectangle()
                .fill(Color.primary)
                .frame(width: 2.5, height: (width - 340) / 2)
                .cornerRadius(2)
                .offset(y: -(width - 340) / 4)
                .rotationEffect(.init(degrees: Double(currentTime.hour) * 30))
            
            Circle()
                .fill(Color.primary)
                .frame(width: 9, height: 7)
        }
        .frame(width: width - 300, height: width - 300)
        
    }
}

struct Time {
    var sec: Int
    var min: Int
    var hour: Int
}

struct Watch_Previews: PreviewProvider {
    static var previews: some View {
        Watch()
            .frame(width: 200)
            
    }
}

