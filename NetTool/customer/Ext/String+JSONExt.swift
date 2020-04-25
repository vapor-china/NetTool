//
//  String+JSONExt.swift
//  NetTool
//
//  Created by xj on 2020/4/25.
//  Copyright © 2020 spectator.nan. All rights reserved.
//

import Foundation

extension String {
    
    func toJsonStr(_ isPretty: Bool = false) -> String {
        if let jsonData = data(using: .utf8) {
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                let serialization = try JSONSerialization.data(withJSONObject: jsonObject, options: isPretty ? [.prettyPrinted] : [])
                
                return String(data: serialization, encoding: .utf8) ?? ""
            } catch let err {
                
                print("valid json type error: \(err)")
                return ""
            }
        }
        return ""
    }
    
    func toJsonDic() -> [String: Any] {
        if let jsonData = data(using: .utf8) {
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                if let jsonDic = jsonObject as? [String: Any] {
                    return jsonDic
                }
                return [:]
            } catch let err {
                
                print("valid json type error: \(err)")
                return [:]
            }
        }
        return [:]
    }
    
    func isJsonDic() -> Bool {
        if let jsonData = data(using: .utf8) {
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                if let _ = jsonObject as? [String: Any] {
                    return true
                }
                return false
            } catch let err {
                
                print("valid json type error: \(err)")
                return false
            }
        }
        return false
    }
    
    func isJsonArr() -> Bool {
        if let jsonData = data(using: .utf8) {
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                if let _ = jsonObject as? [String] {
                    return true
                }
                return false
            } catch let err {
                
                print("valid json type error: \(err)")
                return false
            }
        }
        return false
    }
    
    func isJsonStr() -> Bool {
        
        if let jsonData = data(using: .utf8) {
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
                return JSONSerialization.isValidJSONObject(jsonObject)
                
            } catch let err {
                
                print("valid json type error: \(err)")
                return false
            }
        }
        
        return false
    }
    
}
