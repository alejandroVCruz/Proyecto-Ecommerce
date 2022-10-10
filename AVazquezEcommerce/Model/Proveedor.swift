//
//  Proveedor.swift
//  AVazquezEcommerce
//
//  Created by MacBookMBA3 on 03/10/22.
//
import SQLite3

import Foundation

class Proveedor{
    var IdProveedor : Int = 0
    var Nombre: String? = nil
    var Telefono: Int = 0
    
    static func GetAll()->Result{
        let result = Result()
        let query = "Select IdProveedor,NombreProveedor,Telefono from Proveedor"
        var statement : OpaquePointer? = nil
        let conexion = Conexion.init()
        do{
            if let context = try? sqlite3_prepare_v2(conexion.db,query,-1,&statement,nil) == SQLITE_OK {
                result.Objects = [Any]()
                while sqlite3_step(statement) == SQLITE_ROW {
                    let proveedor = Proveedor()
                    
                    proveedor.IdProveedor = Int(sqlite3_column_int(statement,0))
                    proveedor.Nombre = String(String(cString: sqlite3_column_text(statement, 1)))
                    proveedor.Telefono = Int(sqlite3_column_int(statement,2))
                    
                    result.Objects?.append(proveedor)
                }
                result.Correct = true
            }
            else{
                result.Correct = false
                result.ErrorMessage = "No se encontro ningun dato en la tabla proveedor"
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        sqlite3_close(conexion.db)
        return result
    }
}
