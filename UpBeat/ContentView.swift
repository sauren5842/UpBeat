//
//  ContentView.swift
//  UpBeat
//
//  Created by Harish Yerra on 9/11/20.
//  Copyright © 2020 UpBeat. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    private var model = PulsatingViewModel()
    var body: some View {
        ZStack{
            RadialGradient(gradient: Gradient(colors: [.blue, .red]), center: .center, startRadius: 100, endRadius: 470).edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                PulsatingView(viewModel: model)
                Spacer()
            }
        }
    }
}

class PulsatingViewModel: ObservableObject {
    @Published var colorIndex = 1
}

struct PulsatingView: View {

    @ObservedObject var viewModel: PulsatingViewModel

    func colourToShow() -> Color {
            return Color.orange
    }

    @State var animate = false
    var body: some View {
        VStack {
            ZStack {
                Circle().fill(colourToShow().opacity(0.25)).frame(width: 40, height: 40).scaleEffect(self.animate ? 1 : 0)
                Circle().fill(colourToShow().opacity(0.35)).frame(width: 30, height: 30).scaleEffect(self.animate ? 1 : 0)
                Circle().fill(colourToShow().opacity(0.45)).frame(width: 15, height: 15).scaleEffect(self.animate ? 1 : 0)
                Circle().fill(colourToShow()).frame(width: 6.25, height: 6.25)
            }
            .onAppear { self.animate = true }
            .animation(animate ? Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true) : .default)
            .onReceive(viewModel.$colorIndex) { _ in
                self.animate = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.animate = true
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
