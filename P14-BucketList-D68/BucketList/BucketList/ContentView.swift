//
//  ContentView.swift
//  BucketList
//
//  Created by Asad Sayeed on 28/04/24.
//
import MapKit
import SwiftUI

// P14-C3: Create another view model, this time for EditView. What you put in the view model is down to you, but I would recommend leaving dismiss and onSave in the view itself – the former uses the environment, which can only be read by the view, and the latter doesn’t really add anything when moved into the model.


struct ContentView: View {
    let startPosition = MapCameraPosition.region( MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 17.40, longitude: 78.47),
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10) ))
    
    @State private var viewModel = ViewModel()
    @State private var showingPlainView = true
    
    var body: some View {
        if viewModel.isUnlocked {
            ZStack {
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
                    .mapStyle(showingPlainView == true ? .standard : .hybrid)
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
                
                // P14-C1: Allow the user to switch map modes, between the standard mode and hybrid.
                VStack {
                    Spacer()
                    if showingPlainView {
                        Button{ showingPlainView.toggle() } label: {
                            Label("Hybrid view", systemImage: "map.fill")
                        }
                        .padding()
                        .background(in: .capsule)
                    } else {
                        Button{ showingPlainView.toggle() } label: {
                            Label("Default view", systemImage: "map")
                        }
                        .padding()
                        .background(in: .capsule)
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
