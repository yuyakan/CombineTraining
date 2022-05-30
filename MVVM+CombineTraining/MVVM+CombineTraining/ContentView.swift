//
//  ContentView.swift
//  MVVM+CombineTraining
//
//  Created by 上別縄祐也 on 2022/05/27.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var loginViewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            TextField("", text: $loginViewModel.userId)
            TextField("", text: $loginViewModel.password)
            Button("Button") {
                loginViewModel.loginButtonTap()
            }.disabled(!loginViewModel.loginButtonIsEnabled)
            Label(loginViewModel.validLabelText, systemImage: "42.circle")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
