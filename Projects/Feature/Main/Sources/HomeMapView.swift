//
//  MapView.swift
//  Feature
//
//  Created by 제이콥 on 5/13/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import SwiftUI
import MapKit
import Shared

struct HomeMapView: UIViewRepresentable {
    @EnvironmentObject var mapData: MapData
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        return mapView

    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        print("update")
        uiView.delegate = context.coordinator
    }
    
    func makeCoordinator() -> HomeMapViewCoordinator {
        HomeMapViewCoordinator(mapData: mapData)
    }
    
    typealias UIViewType = MKMapView
    
    class HomeMapViewCoordinator: NSObject, MKMapViewDelegate, ObservableObject {
        var mapData: MapData
        init(mapData: MapData) {
            self.mapData = mapData
        }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            let latitude = mapView.region.center.latitude
            let longitude = mapView.region.center.longitude
            let coordinate = CLLocation(latitude: latitude, longitude: longitude)
            let span = mapView.region.span
            
            CLGeocoder().reverseGeocodeLocation(coordinate) { placemarks, error in
                guard error == nil else {print("func error");return}
                guard let placemarks = placemarks else {print("unwrapping error");return}
                guard let placemark = placemarks.first else {return}
                
                var localNameList: [String?] = []
                localNameList.append(placemark.administrativeArea)
                localNameList.append(placemark.subAdministrativeArea)
                localNameList.append(placemark.locality)
                localNameList.append(placemark.subLocality)
                
                var location: String = ""
                for item in localNameList {
                    guard let localName = item else {continue}
                    location += localName + " "
                }
                location.removeLast()
                
                if span.latitudeDelta > 0.5 || span.latitudeDelta > 0.5 {
                    self.mapData.location = placemark.country ?? "대한민국"
                    return
                }
                
                self.mapData.location = location
                print(self.mapData.getLocationCode(location: location))
            }
            
        }
    }
    
}


