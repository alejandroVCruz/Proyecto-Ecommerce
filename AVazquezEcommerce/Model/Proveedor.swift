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
    var Proveedores : [Proveedor]?
    
    static func Add(_ proveedor : Proveedor)->Result{
        let result = Result()
        let query = "INSERT INTO Proveedor (NombreProveedor,Telefono,) VALUES(?,?);"
        let conexion = Conexion.init()
        
        var statement : OpaquePointer? = nil
        do{
        if sqlite3_prepare_v2(conexion.db, query, -1 , &statement , nil) == SQLITE_OK{
            
            sqlite3_bind_text(statement, 1, (proveedor.Nombre! as NSString).utf8String, -1, nil)
            sqlite3_bind_int(statement, 2, Int32(proveedor.Telefono as NSInteger))
            result.Correct = true
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Usuario agregado exitosamente")
            }else{
                let errmsg = String(cString: sqlite3_errmsg(conexion.db))
                print("No se agrego ningun dato en la tabla Proveedor\(errmsg)")
                result.Correct = false
                result.ErrorMessage = "No se agrego el usuario"
            }
            
        }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        sqlite3_close(conexion.db)
        sqlite3_finalize(statement)
        return result
    }
    
    static func Update(_ proveedor: Proveedor)->Result{
        let result = Result()
                let conexion = Conexion.init()
                do{
                    var query = "UPDATE Usuario SET Nombre = \\'name\' , 'ApellidoPaterno' = 'update' , ApellidoMaterno = 'test', UserName = 'user', Password = '143' WHERE IdUsuario = \(proveedor.IdProveedor);"
                    var statement : OpaquePointer? = nil
                    if sqlite3_prepare_v2(conexion.db, query, -1, &statement, nil) == SQLITE_OK{
                        if sqlite3_step(statement) == SQLITE_DONE {
                            result.Correct = true
                        }else {
                            result.ErrorMessage = "Ocurrio 'un error al actualizar el usuario"
                            result.Correct = false
                        }
                    }
                    
                }catch let error{
                    result.Correct = false
                    result.Ex = error
                    result.ErrorMessage = error.localizedDescription
                }
                //sqlite3_close(conexion.db)
                return result
    }
    
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
        //sqlite3_close(conexion.db)
        return result
    }
    
    static func GetById(_ IdProveedor : Int)->Result{
        let result = Result()
        let query = "Select IdProveedor,NombreProveedor,Telefono from Proveedor where IdProveedor = \(IdProveedor)"
        var statement : OpaquePointer? = nil
        let conexion = Conexion.init()
        do{
            if let context = try? sqlite3_prepare_v2(conexion.db,query,-1,&statement,nil) == SQLITE_OK {
                result.Object = [Any]()
                if sqlite3_step(statement) == SQLITE_ROW {
                  
                    let proveedor = Proveedor()
                    
                    proveedor.IdProveedor = Int(sqlite3_column_int(statement,0))
                    proveedor.Nombre = String(String(cString: sqlite3_column_text(statement, 1)))
                    proveedor.Telefono = Int(sqlite3_column_int(statement,3))
                    
                    result.Object? = proveedor //BONXING
                }
                result.Correct = true
            }
            else{
                result.Correct = false
                result.ErrorMessage = "No se encontro ninguna dato en la tabla proveedor"
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        //sqlite3_close(conexion.db)
        return result
    }
    
    static func Delete(IdProveedor : Int){
        let result = Result()
        let query = "DELETE FROM Proveedor Where IdProveedor = \(IdProveedor)"
        var statement : OpaquePointer? = nil
        let conexion = Conexion.init()
        
        if let context = try? sqlite3_prepare_v2(conexion.db,query,-1,&statement,nil) == SQLITE_OK{
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Proveedor eliminado correctamente")
            }else {
                print("Error al eliminar el Proveedor")
            }
        }
    }
}
