//
//  main.swift
//  Practica_2
//
//  Created by Axel Vargas Díaz de Vivar on 25/02/26.
//

import Foundation

func login(user: String?, pass: String?) {
    // Validamos que el usuario no sea nulo
    guard let user = user else {
        print("Usuario nulo")
        return // Es obligatorio salir
    }
    
    // Validamos que la contraseña no sea nula
    guard let pass = pass else {
        print("Contraseña nula")
        return
    }
    
    // Añadimos espacios alrededor de '>'
    guard pass.count > 5 else {
        print("Al menos 6 caracteres")
        return
    }
    
    print("Conectado como \(user)")
}
login(user: "admin", pass: "123456")
login(user: nil, pass: "123456")
login(user: "admin", pass: nil)
login(user: "admin", pass: "123")

/////////////////////////////////////////////////////////////////////////////
func dividir(a: Double, b: Double)
-> Double?{
    guard b != 0 else {
        print("No puede ser 0")
        return nil
    }
    return a/b
}

print (dividir(a:10.0, b:0.0))
print (dividir(a:10.0, b:3.0))

/////////////////////////////////////////////////////////////////////////////
func process(number:Int?)
{
    if number != nil {
        if number! != 0 {
            print("Numero invalido")
        }
    }
}
func processWithGuard(number: Int?){
    guard let number = number, number != 0 else{
        print("Numero invalido")
        return
    }
}
print("Numero invalido")
