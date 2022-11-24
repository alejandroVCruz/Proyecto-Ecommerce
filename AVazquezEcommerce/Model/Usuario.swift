//
//  Usuario.swift
//  AVazquezEcommerce
//
//  Created by MacBookMBA3 on 20/09/22.
//
import UIKit
import Foundation
import SQLite3

class Usuario{
    var IdUsuario: Int = 0
    var Nombre: String? = nil
    var ApellidoPaterno: String? = nil
    var ApellidoMaterno: String? = nil
    var Username: String? = nil
    var Contrasena: String? = nil
    var Imagen : String? = nil
    var Usuarios : [Usuario]?
    
    static func GetByUsername(_ Username : String) -> Result{
            let result = Result()
            let query = "Select Username,Contrasena from Usuario where Username = '\(Username)';"
        var statement : OpaquePointer? = nil
        let conexion = Conexion.init()
        do{
            if let context = try? sqlite3_prepare_v2(conexion.db,query,-1,&statement,nil) == SQLITE_OK {
                result.Object = [Any]()
                if sqlite3_step(statement) == SQLITE_ROW {
                  
                    let usuario = Usuario()
                    
                    usuario.Username = String(describing: String(cString: sqlite3_column_text(statement, 0)))
                    usuario.Contrasena = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                    
                    result.Object? = usuario //BONXING
                    result.Correct = true
                }
                else{
                    result.Correct = false
                    result.ErrorMessage = "No se encontro ninguna dato en la tabla usuario"
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
    
    static func Add(_ usuario : Usuario)->Result{
        let result = Result()
        let query = "INSERT INTO Usuario (Nombre,ApellidoPaterno,ApellidoMaterno,Username,Contrasena,Imagen) VALUES(?,?,?,?,?,?);"
        let conexion = Conexion.init()
        
        var statement : OpaquePointer? = nil
        do{
        if sqlite3_prepare_v2(conexion.db, query, -1 , &statement , nil) == SQLITE_OK{
            
            sqlite3_bind_text(statement, 1, (usuario.Nombre! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (usuario.ApellidoPaterno! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 3, (usuario.ApellidoMaterno! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 4, (usuario.Username! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 5, (usuario.Contrasena! as NSString).utf8String, -1, nil)
            let image: Any
            if sqlite3_column_text(statement,6) != nil {
                image = String(describing: String(cString: sqlite3_column_text(statement, 6)))
            }else{
                image = "NotFound"
            }
            
            result.Correct = true
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Usuario agregado exitosamente")
            }else{
                let errmsg = String(cString: sqlite3_errmsg(conexion.db))
                print("No se agrego ningun dato en la tabla usuario\(errmsg)")
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
    
    static func Update(_ usuario: Usuario)->Result{
        let result = Result()
             let conexion = Conexion.init()
             do{
                 var query = "UPDATE Usuario SET Nombre = '' , 'ApellidoPaterno' = '' , ApellidoMaterno = '', UserName = '', Password = '' WHERE IdUsuario = \(usuario.IdUsuario);"
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
             sqlite3_close(conexion.db)
             return result
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
                    //usuario.Imagen = String(describing: String(cString: sqlite3_column_text(statement, 6)))
                    
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
                result.ErrorMessage = "NO SE AGREGO EL USUARIO"
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        //sqlite3_close(conexion.db)
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
