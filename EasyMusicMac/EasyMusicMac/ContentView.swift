//
//  ContentView.swift
//  EasyMusicMac
//
//  Created by Platon on 08.12.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var currentStation: Station? = nil
    @ObservedObject private var radioPlayer = RadioPlayer.shared

    private let stations: [Station] = [
        Station(
            name: "Tabris FM",
            description: "Радио с приятными треками.",
            streamURL: "https://stream.zeno.fm/uzrnuzqmen6tv",
            gradient: [Color.red, Color.orange]
        ),
        Station(
            name: "Night FM",
            description: "Спокойная музыка для ночных прогулок.",
            streamURL: "https://stream.zeno.fm/lgxpsux5v9avv",
            gradient: [Color.blue, Color.cyan]
        ),
        Station(
            name: "Penis FM",
            description: "Альтернативная музыка для любителей нового.",
            streamURL: "https://stream.zeno.fm/hfrwlmkuux4uv",
            gradient: [Color.purple, Color.blue]
        ),
        Station(
            name: "Platon FM",
            description: "Музыка всех жанров.",
            streamURL: "http://45.95.234.91:8000/music",
            gradient: [Color.yellow, Color.orange]
        ),
        Station(
            name: "Myschool FM",
            description: "Полная сборная солянка от красивых и уникальных жанров до рофл гей ремиксов и блатных треков, часто проводятся подкасты на разные темы в прямом эфире от простого общения до политики.",
            streamURL: "https://stream.zeno.fm/hydtchh8maguv.m3u",
            gradient: [Color.purple, Color.purple]
        )
    ]

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Общий градиентный фон
                if let gradientColors = currentStation?.gradient {
                    LinearGradient(
                        gradient: Gradient(colors: gradientColors),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .animation(Animation.linear(duration: 5).repeatForever(autoreverses: true))
                    .edgesIgnoringSafeArea(.all)
                }

                HStack(spacing: 0) {
                    // Меню слева
                    VStack(alignment: .leading) {
                        List(stations) { station in
                            Button(action: {
                                currentStation = station
                                radioPlayer.playStream(url: station.streamURL)
                            }) {
                                Text(station.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        .listStyle(PlainListStyle())
                    }
                    .frame(width: geometry.size.width * 0.25) // 25% ширины для меню
                    .background(Color.black.opacity(0.3)) // Полупрозрачный слой для выделения меню

                    Divider()
                        .background(Color.white.opacity(0.5)) // Визуальное разделение

                    // Основной контент справа
                    if let station = currentStation {
                        VStack(spacing: 20) {
                            Text(station.name)
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(.white)

                            Text(station.description)
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)

                            Text("Now Playing: \(radioPlayer.trackTitle)")
                                .font(.headline)
                                .foregroundColor(.white)

                            HStack {
                                Button(action: togglePlay) {
                                    Image(systemName: radioPlayer.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                                        .font(.system(size: 50))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity) // Занимает оставшееся пространство
                        .padding()
                    } else {
                        VStack {
                            Text("Выберите радиостанцию из списка слева")
                                .font(.title)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
            }
        }
    }

    private func togglePlay() {
        if radioPlayer.isPlaying {
            radioPlayer.stop()
        } else if let station = currentStation {
            radioPlayer.playStream(url: station.streamURL)
        }
    }
}
