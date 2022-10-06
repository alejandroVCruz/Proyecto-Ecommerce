//
//  Usuario.swift
//  AVazquezEcommerce
//
//  Created by MacBookMBA3 on 20/09/22.
//

import Foundation
import SQLite3

class Usuario{
    var IdUsuario: Int = 0
    var Nombre: String? = nil
    var ApellidoPaterno: String? = nil
    var ApellidoMaterno: String? = nil
    var Username: String? = nil
    var Contrasena: String? = nil
    var Usuarios : [Usuario]?
    
    static func Add(_ usuario : Usuario){
        
        let query = "INSERT INTO Usuario (Nombre,ApellidoPaterno,ApellidoMaterno,Username,Contrasena) VALUES(?,?,?,?,?);"
        
        let conexion = Conexion.init()
        var statement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(conexion.db, query, -1 , &statement , nil) == SQLITE_OK{
            
            sqlite3_bind_text(statement, 1, (usuario.Nombre! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (usuario.ApellidoPaterno! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (usuario.ApellidoMaterno! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 4, (usuario.Username! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 5, (usuario.Contrasena! as NSString).utf8String, -1, nil)
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Usuario agregado exitosamente")
            }else{
                print("No se encontro ningun dato en la tabla usuario")
            }
            
        }
    }
    
    static func Update(_ usuario: Usuario){
        let query = "Update into Usuario SET Nombre=?,ApellidoPaterno=?,ApellidoMaterno=?,Username=?,Contrasena=? where IdUsuario = IdUsuario"
        
        let conexion = Conexion.init()
        var statement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(conexion.db, query, -1 , &statement , nil) == SQLITE_OK{
            
            let usuario = Usuario()
            sqlite3_bind_text(statement, 1, (usuario.Nombre! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (usuario.ApellidoPaterno! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (usuario.ApellidoMaterno! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 4, (usuario.Username! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 5, (usuario.Contrasena! as NSString).utf8String, -1, nil)
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Usuario agregado exitosamente")
            }else{
                print("Ocurrio un error")
            }
        }
    }
    
    static func GetAll()->Result{
        let result = Result()
        let query = "Select IdUsuario,Nombre,ApellidoPaterno,ApellidoMaterno,Username,Contrasena from Usuario"
        var statement : OpaquePointer? = nil
        let conexion = Conexion.init()
        do{
            if let context = try? sqlite3_prepare_v2(conexion.db,query,-1,&statement,nil) == SQLITE_OK {
                result.Objects = [Any]()
                while sqlite3_step(statement) == SQLITE_ROW {
                    let usuario = Usuario()
                    
                    usuario.IdUsuario = Int(sqlite3_column_int(statement,0))
                    usuario.Nombre = String(String(cString: sqlite3_column_text(statement, 1)))
                    usuario.ApellidoPaterno = String(describing: String(cString: sqlite3_column_text(statement, 2)))
                    usuario.ApellidoMaterno = String(describing: String(cString: sqlite3_column_text(statement, 3)))
                    usuario.Username = String(describing: String(cString: sqlite3_column_text(statement, 4)))
                    usuario.Contrasena = String(describing: String(cString: sqlite3_column_text(statement, 5)))
                    
                    result.Objects?.append(usuario)
                }
                result.Correct = true
            }
            else{
                result.Correct = false
                result.ErrorMessage = "No se encontro ningun dato en la tabla usuario"
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        sqlite3_close(conexion.db)
        return result
    }
    
    
    static func GetById(_ IdUsuario : Int)->Result{
        let result = Result()
        let query = "Select IdUsuario,Nombre,ApellidoPaterno,ApellidoMaterno,Username,Contrasena from Usuario where IdUsuario = \(IdUsuario)"
        var statement : OpaquePointer? = nil
        let conexion = Conexion.init()
        do{
            if let context = try? sqlite3_prepare_v2(conexion.db,query,-1,&statement,nil) == SQLITE_OK {
                result.Object = [Any]()
                if sqlite3_step(statement) == SQLITE_ROW {
                  
                    let usuario = Usuario()
                    
                    usuario.IdUsuario = Int(sqlite3_column_int(statement,0))
                    usuario.Nombre = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    usuario.ApellidoPaterno = String(describing: String(cString: sqlite3_column_text(statement, 2)))
                    usuario.ApellidoMaterno = String(describing: String(cString: sqlite3_column_text(statement, 3)))
                    usuario.Username = String(describing: String(cString: sqlite3_column_text(statement, 4)))
                    usuario.Contrasena = String(describing: String(cString: sqlite3_column_text(statement, 5)))
                    
                    result.Object? = usuario //BONXING
                }
                result.Correct = true
                
            }
            else{
                result.Correct = false
                result.ErrorMessage = "No se encontro ninguna dato en la tabla usuario"
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        sqlite3_close(conexion.db)
        return result
    }
    
    static func Delete(IdUsuario : Int){
        let result = Result()
        let query = "DELETE FROM Usuario Where IdUsuario = \(IdUsuario)"
        var statement : OpaquePointer? = nil
        let conexion = Conexion.init()
        
        if let context = try? sqlite3_prepare_v2(conexion.db,query,-1,&statement,nil) == SQLITE_OK{
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Usuario eliminado correctamente")
            }else {
                print("Error al eliminar el usuario")
            }
        }
        
        
        
    }
}
