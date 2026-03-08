//
//  main.swift
//  Ejercicio_Clase
//
//  Created by Axel Vargas Díaz de Vivar on 08/03/26.
//
import Foundation


enum MessageStatus: String {
    case enviado = "Enviado"
    case recibido = "Recibido"
    case leido = "Leido"
}



let status: MessageStatus = .enviado
print("status :\(status)")

switch status {
case .enviado:
    print("Mensaje enviado")
case .recibido:
    print("Mensaje recibido")
case .leido:
    print("Mensaje leido")
}
print("----------------------------------------")

print(status.rawValue)

enum PuntosCardinales : Int {
    case norte = 1
    case sur
    case este
    case oeste
}

let puntoCardinal : PuntosCardinales = .oeste
print("puntosCardinal :\(puntoCardinal.rawValue)")


enum Dias: Int {
    case lunes = 1
    case martes
    case miercoles
    case jueves
    case viernes
    case sabado
    case domingo
}

func dias(from number: Int) -> Dias? {
    Dias(rawValue: number)
}

var number: Int = 12

if let dia = dias(from: 3) {
    print("El dia numero 3 es \(dia)")
} else {
    print("Numero de dia invalido")
}
print("----------------------------------------")

enum Semaforo {
    case red, yellow, green
}

func action(for semaforo: Semaforo) -> String {
    switch semaforo {
    case .red:
        return "alto"
    case .yellow:
        return "precaución"
    case .green:
        return "avanzar"
    }
}

print(action(for: .red))
print(action(for: .yellow))
print(action(for: .green))
print("----------------------------------------")

// enums con variables asociadas

enum LoadState {
    case idle
    case loading
    case success(items: [String])
    case failure(message: String)
}

func render(_ state: LoadState) {
    switch state {
        case .idle:
        print("Listo para buscar")
    case .loading:
        print("Cargando...")
    case .success(items: let items):
        print("Resultados: \(items)")
    case .failure(message: let message):
        print("Error: \(message)")
    }
}

render(.idle)
render(.loading)
render(.success(items: ["item 1", "item 2", "item 3"]))
render(.failure(message: "No se pudo cargar"))
print("----------------------------------------")

