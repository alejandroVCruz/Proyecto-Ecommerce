//
//  Producto.swift
//  AVazquezEcommerce
//
//  Created by MacBookMBA3 on 30/09/22.
//

import Foundation
import SQLite3

class Producto{
    var IdDepartamento : Int = 0
    var IdProducto : Int = 0
    var Nombre: String? = nil
    var PrecioUnitario: Double = 0
    var Stock: Int = 0
    var Descripcion: String? = nil
    //Propiedad de Navegacion
    var proveedor = Proveedor()
    var departamento = Departamento()

    var Productos : [Producto]?
    
    static func Add(_ producto : Producto){
        let query = "INSERT INTO Producto (NombreProducto,PrecioUnitario,Stock,Descripcion,IdProveedor,IdDepartamento) VALUES(?,?,?,?,?,?);"
        
        let conexion = Conexion.init()
        var statement : OpaquePointer? = nil
        
        
            if sqlite3_prepare_v2(conexion.db, query, -1 , &statement , nil) == SQLITE_OK{
                
                sqlite3_bind_text(statement, 1, (producto.Nombre! as NSString).utf8String, -1, nil)
                sqlite3_bind_double(statement, 2, Double((producto.PrecioUnitario)))
                sqlite3_bind_int(statement, 3, Int32(producto.Stock as NSInteger))
                sqlite3_bind_text(statement, 4, (producto.Descripcion! as NSString).utf8String, -1, nil)
                sqlite3_bind_int(statement, 5, Int32(producto.proveedor.IdProveedor as NSInteger))
                sqlite3_bind_int(statement, 6, Int32(producto.departamento.IdDepartamento as NSInteger))
                
                if sqlite3_step(statement) == SQLITE_DONE {
                    print("Producto agregado exitosamente")
                }else{
                    let errmsg = String(cString: sqlite3_errmsg(conexion.db))
                    print("No se agrego ningun producto  \(errmsg)")
                }
            }
    }
    static func Update(_ producto : Producto){
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
        let query = "Select IdProducto,NombreProducto,PrecioUnitario,Stock,IdProveedor,IdDepartamento,Descripcion from Producto"
        //let query = "Select Producto.IdProducto,Producto.NombreProducto,Producto.PrecioUnitario,Producto.Stock,Producto.Descripcion,Proveedor.IdProveedor,Proveedor.NombreProveedor,Departamento.IdDepartamento,Departamento.NombreDepartamento from Producto INNER JOIN Proveedor ON(Producto.IdProveedor = Proveedor.IdProveedor) INNER JOIN Departamento ON (Producto.IdDepartamento = Departamento.IdDepartamento)"
        var statement : OpaquePointer? = nil
        let conexion = Conexion.init()
        do{
            if let context = try? sqlite3_prepare_v2(conexion.db,query,-1,&statement,nil) == SQLITE_OK {
                result.Objects = [Any]()
                while sqlite3_step(statement) == SQLITE_ROW {
                    let producto = Producto()
                    
                    producto.IdProducto = Int(sqlite3_column_int(statement,0))
                    producto.Nombre = String(String(cString: sqlite3_column_text(statement, 1)))
                    producto.PrecioUnitario = Double(sqlite3_column_double(statement,2))
                    producto.Stock = Int(sqlite3_column_int(statement,3))
                    producto.proveedor.IdProveedor  = Int(sqlite3_column_int(statement,4))
                    producto.departamento.IdDepartamento = Int(sqlite3_column_int(statement,5))
                    producto.Descripcion = String(String(cString: sqlite3_column_text(statement, 6)))
                    
                    result.Objects?.append(producto)
                }
                result.Correct = true
            }
            else{
                result.Correct = false
                result.ErrorMessage = "No se encontro ningun dato en la tabla Producto"
            }
        }catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        //sqlite3_close(conexion.db)
        return result
    }
    
    static func GetById(_ IdProducto : Int)->Result{
        let result = Result()
        let query = "Select IdProducto,NombreProducto,PrecioUnitario,Stock,IdProveedor,IdDepartamento,Descripcion from Producto where IdProducto = \(IdProducto)"
        var statement : OpaquePointer? = nil
        let conexion = Conexion.init()
        do{
            if let context = try? sqlite3_prepare_v2(conexion.db,query,-1,&statement,nil) == SQLITE_OK {
                result.Object = [Any]()
                if sqlite3_step(statement) == SQLITE_ROW {
                  
                    let producto = Producto()
                    
                    producto.IdProducto = Int(sqlite3_column_int(statement,0))
                    producto.Nombre = String(String(cString: sqlite3_column_text(statement, 1)))
                    producto.PrecioUnitario = Double(sqlite3_column_double(statement,2))
                    producto.Stock = Int(sqlite3_column_int(statement,3))
                    producto.proveedor.IdProveedor  = Int(sqlite3_column_int(statement,4))
                    producto.departamento.IdDepartamento = Int(sqlite3_column_int(statement,5))
                    producto.Descripcion = String(String(cString: sqlite3_column_text(statement, 6)))
                    
                    result.Object? = producto //BONXING
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
        //sqlite3_close(conexion.db)
        return result
    }
    
    static func Delete(IdProducto : Int){
        let result = Result()
        let query = "DELETE FROM Producto Where IdProducto = \(IdProducto)"
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
    
    
    
    static func GetByIdP(_ IdDepartamente : Int)->Result{
        let result = Result()
        let query = "Select IdProducto,NombreProducto,PrecioUnitario,Stock,IdProveedor,IdDepartamento,Descripcion from Producto where IdDepartamento = \(IdDepartamente) "
        var statement : OpaquePointer? = nil
        let conexion = Conexion.init()
        do{
            if let context = try? sqlite3_prepare_v2(conexion.db,query,-1,&statement,nil) == SQLITE_OK {
                result.Objects = [Any]()
                while sqlite3_step(statement) == SQLITE_ROW {
                    let producto = Producto()
                    
                    producto.IdProducto = Int(sqlite3_column_int(statement,0))
                    producto.Nombre = String(String(cString: sqlite3_column_text(statement, 1)))
                    producto.PrecioUnitario = Double(sqlite3_column_double(statement,2))
                    producto.Stock = Int(sqlite3_column_int(statement,3))
                    producto.proveedor.IdProveedor  = Int(sqlite3_column_int(statement,4))
                    producto.departamento.IdDepartamento = Int(sqlite3_column_int(statement,5))
                    producto.Descripcion = String(String(cString: sqlite3_column_text(statement, 6)))
                    
                    result.Objects?.append(producto)
                }
                result.Correct = true
            }
            else{
                result.Correct = false
                result.ErrorMessage = "No se encontro ningun dato en la tabla Producto"
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
