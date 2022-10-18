//
//  SQLiteTestViewController.swift
//  PracticePlaygrounds
//
//  Created by Zhou Zhiyuan on 10/17/22.
//

import Foundation
import SQLite
import UIKit

class SQLiteTestViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    var db: Connection? = nil
    
    do {
      let path = NSSearchPathForDirectoriesInDomains(
          .documentDirectory, .userDomainMask, true
      ).first!
      db = try Connection("\(path)/testDB.sqlite3")
    } catch {
      print("error is \(error)")
    }
    
    if let db = db {
      createUserTable(db: db)
    }
  }
  
  func createUserTable(db: Connection) {
    let id = Expression<Int64>("id")
    let email = Expression<String>("email")
    let balance = Expression<Double>("balance")
    let verified = Expression<Bool>("verified")
    let name = Expression<String?>("name")
    
    let users = Table("users")
    do {
      try db.run(users.create(ifNotExists: true) { t in
        t.column(id, primaryKey: true) //     "id" INTEGER PRIMARY KEY NOT NULL,
        t.column(email, unique: true)  //     "email" TEXT UNIQUE NOT NULL,
        t.column(name)                 //     "name" TEXT
      })
      try db.run(users.insert(email <- "alice@mac.com", name <- "Alice"))
    } catch {
      print(error)
    }
    
    do {
      let exists = try db.scalar(users.exists)
      print("User table existence status: \(exists)")
    } catch {
      print(error)
    }
    
    
    printCurrentUserTable(db, users)
  }
  
  func printCurrentUserTable(_ db: Connection, _ users: Table) {
    let id = Expression<Int64>("id")
    let email = Expression<String>("email")
    let balance = Expression<Double>("balance")
    let verified = Expression<Bool>("verified")
    let name = Expression<String?>("name")
    do {
      for user in try db.prepare(users) {
        print("id: \(user[id]), email: \(user[email]), name: \(user[name])")
      }
    } catch {
      print(error)
    }
  }
}
