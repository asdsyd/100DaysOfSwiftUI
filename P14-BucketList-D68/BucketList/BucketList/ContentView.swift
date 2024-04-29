//
//  ContentView.swift
//  BucketList
//
//  Created by Asad Sayeed on 28/04/24.
//
import MapKit
import SwiftUI

struct ContentView: View {
    let startPosition = MapCameraPosition.region( MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 17.40, longitude: 78.47),
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10) ))
    
    @State private var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.isUnlocked {
            MapReader { proxy in
                Map(initialPosition: startPosition) {
                    ForEach(viewModel.locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "heart.circle")
                                .resizable()
                                .foregroundStyle(.white)
                                .frame(width: 44, height: 44)
                                .background(.blue)
                                .clipShape(.circle)
                                .onLongPressGesture {
                                    viewModel.selectedPlace = location
                                }
                        }
                    }
                }
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        viewModel.addLocation(at: coordinate)
                    }
                }
                .sheet(item: $viewModel.selectedPlace) { place in
                    EditView(location: place) {
                        viewModel.update(location: $0)
                        
                    }
                }
            }
        } else {
            HStack {
                Image(systemName: "lock.fill")

                Button("Touch to Unlock Places", action: viewModel.authenticate)
            }
            .padding()
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(.capsule)
        }
    }
}

#Preview {
    ContentView()
}
