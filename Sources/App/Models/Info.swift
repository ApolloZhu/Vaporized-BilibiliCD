//
//  Info.swift
//  App
//
//  Created by Apollo Zhu on 5/6/18.
//

import Vapor

struct Info: Content {
    let url: String
    let title: String
    let author: String
}
