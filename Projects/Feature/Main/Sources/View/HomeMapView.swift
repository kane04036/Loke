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
    @EnvironmentObject var regionInformation: RegionInformation
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        let pinImageView = UIImageView(image: SharedAsset.mapPinOn.image)
        mapView.addSubview(pinImageView)

        pinImageView.translatesAutoresizingMaskIntoConstraints = false
        pinImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        pinImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pinImageView.centerYAnchor.constraint(equalTo: mapView.centerYAnchor).isActive = true
        pinImageView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
        return mapView

    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.delegate = context.coordinator
    }
    
    func makeCoordinator() -> HomeMapViewCoordinator {
        HomeMapViewCoordinator(mapData: mapData, regionInformation: regionInformation)
    }
    
    typealias UIViewType = MKMapView
    
    class HomeMapViewCoordinator: NSObject, MKMapViewDelegate, ObservableObject {
        init(mapData: MapData, regionInformation: RegionInformation) {
            self.mapData = mapData
            self.regionInformation = regionInformation
        }
        
        var mapData: MapData
        var regionInformation: RegionInformation
        
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
                localNameList.append(placemark.thoroughfare)
                localNameList.append(placemark.subThoroughfare)
                
                var location: String = ""
                var previousLocation: String = ""
                for item in localNameList {
                    guard let localName = item else {continue}
                    if previousLocation == localName {continue}
                    previousLocation = localName
                    location += localName + " "
                }
                location.removeLast()
                
                
                
                if span.latitudeDelta > 0.5 || span.latitudeDelta > 0.5 {
                    self.mapData.location = placemark.country ?? "대한민국"
                    return
                }
                
                self.mapData.location = location
                let code = self.mapData.getLocationCode(location: location)
                self.regionInformation.aptRent.requestAptRent(code: code)
            }
            
        }
    }
    
}


