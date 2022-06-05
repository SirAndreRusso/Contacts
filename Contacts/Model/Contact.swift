//
//  Contact.swift
//  Contacts
//
//  Created by Андрей Русин on 05.06.2022.
//

import Foundation
protocol ContactProtocol{
    var title: String {get set}
    var phone: String {get set}
}
struct Contact: ContactProtocol{
    var title: String
    var phone: String
}
