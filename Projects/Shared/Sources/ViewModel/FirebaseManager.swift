//
//  FirebaseManager.swift
//  Shared
//
//  Created by 제이콥 on 6/12/24.
//  Copyright © 2024 projectG. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

public class FirebaseManager {
    // MARK: - Object lifecycle
    public init() {
        FirebaseApp.configure()
        db = Firestore.firestore()
        auth = Auth.auth()
    }
    
    // MARK: - Propoerties
    public static let shared = FirebaseManager()
    
    public let db: Firestore
    public let auth: Auth
}
