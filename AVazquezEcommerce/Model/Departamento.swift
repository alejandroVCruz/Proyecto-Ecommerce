//
//  Departamento.swift
//  AVazquezEcommerce
//
//  Created by MacBookMBA3 on 03/10/22.
//
import SQLite3

import Foundation

class Departamento{
    var IdDepartamento : Int = 0
    var Nombre: String? = nil
    var IdArea: Int = 0
    var area = Area()
    
    
    static func Add(_ departamento : Departamento)->Result{
        let result = Result()
        let query = "INSERT INTO Departamento (Nombre,IdArea,Imagen) VALUES(?,?,?);"
        let conexion = Conexion.init()
        
        var statement : OpaquePointer? = nil
        do{
        if sqlite3_prepare_v2(conexion.db, query, -1 , &statement , nil) == SQLITE_OK{
            
            sqlite3_bind_text(statement, 1, (departamento.Nombre! as NSString).utf8String, -1, nil)
            sqlite3_bind_int(statement, 6, Int32(departamento.area.IdArea as NSInteger))
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
    
    static func Update(_ departamento : Departamento){
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
        let query = "Select IdDepartamento,Nombre,IdArea from Departamento"
        var statement : OpaquePointer? = nil
        let conexion = Conexion.init()
        do{
            if let context = try? sqlite3_prepare_v2(conexion.db,query,-1,&statement,nil) == SQLITE_OK {
                result.Objects = [Any]()
                while sqlite3_step(statement) == SQLITE_ROW {
                    let departamento = Departamento()
                    
                    departamento.IdDepartamento = Int(sqlite3_column_int(statement,0))
                    departamento.Nombre = String(String(cString: sqlite3_column_text(statement, 1)))
                    departamento.IdArea = Int(sqlite3_column_int(statement, 2))
                    
                    result.Objects?.append(departamento)
                }
                result.Correct = true
            }
            else{
                result.Correct = false
                result.ErrorMessage = "No se encontro ningun dato en la tabla Departamento"
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        //sqlite3_close(conexion.db)
        return result
    }
    
    
    static func GetById(_ IdArea : Int)->Result{
        let result = Result()
        let query = "Select IdDepartamento,Nombre,IdArea from Departamento where IdArea = \(IdArea)"
        var statement : OpaquePointer? = nil
        let conexion = Conexion.init()
        do{
            if let context = try? sqlite3_prepare_v2(conexion.db,query,-1,&statement,nil) == SQLITE_OK {
                result.Objects = [Any]()
                while sqlite3_step(statement) == SQLITE_ROW {
                    let departamento = Departamento()
                    
                    departamento.IdDepartamento = Int(sqlite3_column_int(statement,0))
                    departamento.Nombre = String(String(cString: sqlite3_column_text(statement, 1)))
                    departamento.IdArea = Int(sqlite3_column_int(statement,3))
                    
                    
                    result.Object? = departamento
                }
                result.Correct = true
            }
            else{
                result.Correct = false
                result.ErrorMessage = "No se encontro ningun dato"
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
       sqlite3_close(conexion.db)
        return result
    }
    
    static func Delete(IdDepartamento : Int){
        let result = Result()
        let query = "DELETE FROM Producto Where IdProducto = \(IdDepartamento)"
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

