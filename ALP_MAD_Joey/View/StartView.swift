//
//  StartView.swift
//  ALP_MAD_Joey
//
//  Created by Christianto Elvern Haryanto on 04/06/25.
//

import SwiftUI
import SwiftData

struct StartView: View {
    @EnvironmentObject var sessionViewModel: SessionViewModel
    var body: some View {
        NavigationStack {
            if sessionViewModel.isLoggedIn {
                HomeView()
            } else {
                LoginRegisterView()
            }
        }
    }
}

#Preview {
    StartView()
}
