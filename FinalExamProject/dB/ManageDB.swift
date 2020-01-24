//
//  ManageDB.swift
//  FinalExamProject
//
//  Created by COE-14 on 24/01/20.
//  Copyright © 2020 COE-14. All rights reserved.
//

import UIKit

class ManageDB: NSObject {
    
    var dbPath = ""
    var db:OpaquePointer?
    var stmt:OpaquePointer?
    
    override init() {
        super.init()
        dbPath = (UIApplication.shared.delegate as! AppDelegate).dbLocation
    }
    
    private func IsOpen() -> Bool {
        if (sqlite3_open(dbPath, &db) == SQLITE_OK) {
            return true
        }
        return false
    }
    
    func ExecCommand(with cmd:String) -> Bool {
        if !IsOpen() {
            return false
        }
        
        if sqlite3_prepare_v2(db, cmd, -1, &stmt, nil) == SQLITE_OK {
            if sqlite3_step(stmt) == SQLITE_DONE{
                sqlite3_finalize(stmt)
                sqlite3_close(db)
                return true
            }
            sqlite3_finalize(stmt)
            sqlite3_close(db)
        }
        return false
    }
    
    func ExecQuery(with query:String) -> [[String:Any]] {
        var data = [[String:Any]]()
        if !IsOpen() {
            return data
        }
        
        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            while sqlite3_step(stmt) == SQLITE_ROW{
                var row = [String:Any]()
                let count  = sqlite3_column_count(stmt)
                for collIndex in 0..<count{
                    let col_text = String.init(cString: sqlite3_column_text(stmt, collIndex))
                    let col_name = String.init(cString: sqlite3_column_name(stmt, collIndex))
                    
                    row[col_name] = col_text
                }
                data.append(row)
            }
            sqlite3_finalize(stmt)
            sqlite3_close(db)
        }
        return data
    }

}
