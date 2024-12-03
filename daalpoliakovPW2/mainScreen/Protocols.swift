//
//  Protocols.swift
//  daalpoliakovPW2
//
//  Created by Danya Polyakov on 03.11.2024.
//

import Foundation

protocol WishMakerBusinessLogic {
    func loadStart(_ request: WishMakerModel.Start.Request)
    func loadOther(_ request: WishMakerModel.Other.Request)
}

protocol WishMakerPresentationLogic {
    func presentStart(_ response: WishMakerModel.Start.Response)
    func presentOther(_ response: WishMakerModel.Other.Response)
    
    func routeTo()
}
