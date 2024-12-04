//
//  LeaderboardView.swift
//  Benchmark_app
//
//  Created by Bogdan Savianu on 02.12.2024.
//

import SwiftUI

struct LeaderboardView: View {
    @State private var results: [ResultType] = []
    @State private var sortAscending: Bool = true
    @State private var sortBy: SortCriteria = .score

    enum SortCriteria: String, CaseIterable {
        case device = "Device"
        case score = "Score"
        case date = "Date"
    }

    var body: some View {
        VStack {
            Text("🏆 Leaderboard")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            HStack {
                Text("Sort by:")
                Picker("Sort by", selection: $sortBy) {
                    ForEach(SortCriteria.allCases, id: \.self) { criteria in
                        Text(criteria.rawValue).tag(criteria)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding(.horizontal)
                .frame(width: 150)

                Button(action: {
                    sortAscending.toggle()
                    sortResults()
                }) {
                    HStack {
                        Text("Sort Order")
                        Image(systemName: sortAscending ? "arrow.up" : "arrow.down")
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                .shadow(radius: 5)
            }
            .padding(.bottom, 10)

            VStack(spacing: 0) {
                HStack {
                    Text("Device")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Score")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("Date")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(10)
                .shadow(radius: 10)

                List(results) { result in
                    HStack {
                        Text(result.device)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text("\(result.value)")
                            .frame(maxWidth: .infinity, alignment: .center)
                        Text(result.date.formatted(.dateTime.month().day().hour().minute()))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                    .padding(.vertical, 8)
                }
                .listStyle(PlainListStyle())
            }
            
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [.white, .cyan.opacity(0.3)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
        .onAppear {
            loadResults()
        }
    }
    
    private func loadResults() {
        self.results = Singleton.fileWorker.read()
        print("Results: \(results)")
        sortResults()
    }

    private func sortResults() {
        switch sortBy {
        case .device:
            results.sort { sortAscending ? $0.device < $1.device : $0.device > $1.device }
        case .score:
            results.sort { sortAscending ? $0.value < $1.value : $0.value > $1.value }
        case .date:
            results.sort { sortAscending ? $0.date < $1.date : $0.date > $1.date }
        }
    }
}


#Preview {
    LeaderboardView()
}
