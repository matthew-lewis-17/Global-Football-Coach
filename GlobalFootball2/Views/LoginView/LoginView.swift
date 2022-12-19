//
//  LoginView.swift
//  GlobalFootball2
//
//  Created by Matthew Lewis on 7/9/22.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                TextField("username",text: $viewModel.username)
                Button(action: {
                    viewModel.checkCredentials()
                }) {
                    Text("submit")
                }.onTapGesture {
                    hideKeyboard()
                }
                Spacer()
            }
            if viewModel.validAuth {
                    HomeView()
                    .environmentObject(viewModel)
            }
            if viewModel.isLoading {LoadingView()}
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
