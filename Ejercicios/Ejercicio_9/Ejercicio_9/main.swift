//
//  main.swift
//  Ejercicio_9
//
//  Created by Axel Vargas Díaz de Vivar on 11/04/26.
//
import Foundation

// 1. CLASE BASE: USUARIO
// Esta es la superclase que contiene la lógica común para todos los tipos de cuenta.
class Usuario {
    // Propiedades internas (por defecto): accesibles desde cualquier parte del proyecto.
    var nombre: String
    var email: String
    
    // 'private': Solo la clase Usuario puede leer o escribir esta variable.
    // Ni siquiera las subclases (Admin/Cliente) tienen acceso directo a ella.
    private var password: String
    
    // 'private(set)': El mundo exterior puede leer si está activo,
    // pero SOLO Usuario puede cambiar el valor de true a false.
    private(set) var activo: Bool
    
    // Inicializador designado: Es el constructor principal que llena todos los datos.
    init(nombre: String, email: String, password: String, activo: Bool) {
        self.nombre = nombre
        self.email = email
        self.password = password
        self.activo = activo
    }
    
    // 'convenience init': Un inicializador secundario que facilita crear usuarios rápidos.
    // Llama al inicializador principal internamente con valores predefinidos.
    convenience init(nombre: String, email: String) {
        self.init(nombre: nombre, email: email, password: "123456-default", activo: true)
    }
    
    // LÓGICA DE SEGURIDAD
    // Compara la contraseña sin exponer la propiedad privada 'password'.
    func login(password: String) -> Bool {
        return self.password == password
    }
    
    // Validación doble: requiere la contraseña vieja y que la nueva cumpla una regla (6 caracteres).
    func cambiarPassword(actual: String, nueva: String) -> Bool {
        if actual == self.password && nueva.count >= 6 {
            self.password = nueva
            return true
        }
        return false
    }
    
    // MÉTODOS DE ESTADO
    func activar() { self.activo = true }
    func desactivar() { self.activo = false }
    
    // 'fileprivate': Este es un "truco" de Swift. Permite que otras clases (como Administrador)
    // accedan a este método SIEMPRE Y CUANDO estén escritas en este mismo archivo .swift.
    fileprivate func cambiarPasswordDirecto(nueva: String) {
        if nueva.count >= 6 {
            self.password = nueva
        }
    }
    
    func descripcion() {
        print("\n--- Datos del Usuario ---")
        print("Nombre: \(nombre) | Email: \(email) | Activo: \(activo)")
    }
}

// --------------------

// 2. SUBCLASE: ADMINISTRADOR
// Hereda todo de Usuario, pero añade permisos de gestión.
class Administrador: Usuario {
    var nivelAcceso: Int
    
    // El inicializador debe recibir los datos de Usuario + los propios de Administrador.
    init(nombre: String, email: String, password: String, activo: Bool, nivelAcceso: Int) {
        self.nivelAcceso = nivelAcceso
        // 'super.init' delega la creación de la parte básica al padre (Usuario).
        super.init(nombre: nombre, email: email, password: password, activo: activo)
    }
    
    // 'override': Reemplazamos el comportamiento del padre para añadir el nivel de acceso.
    override func descripcion() {
        super.descripcion() // Ejecuta el print del padre
        print("Privilegios: Nivel \(nivelAcceso)")
    }
    
    // Lógica de administración: Solo niveles altos (5+) pueden ejecutar estas acciones.
    func eliminarUsuario(_ usuario: Usuario) {
        if nivelAcceso >= 5 {
            usuario.desactivar() // Usamos un método público del objeto 'usuario'
            print("INFO: El administrador \(self.nombre) desactivó a \(usuario.nombre).")
        } else {
            print("ERROR: Permisos insuficientes para desactivar.")
        }
    }
    
    func resetearPassword(usuario: Usuario, nueva: String) {
        if nivelAcceso >= 5 {
            // Aquí usamos el método 'fileprivate' que definimos en la clase base.
            // Esto permite al admin "saltarse" la validación de la contraseña actual.
            usuario.cambiarPasswordDirecto(nueva: nueva)
            print("INFO: Contraseña de \(usuario.nombre) actualizada por el administrador.")
        } else {
            print("ERROR: Permisos insuficientes para resetear contraseñas.")
        }
    }
}

// --------------------

// 3. SUBCLASE: CLIENTE
// Enfocada en la economía y el historial de compras.
class Cliente: Usuario {
    // 'private': Nadie fuera de esta clase puede ver o tocar el dinero.
    private var saldo: Double = 0
    
    // 'fileprivate': El historial se puede ver desde cualquier parte de este archivo,
    // pero no desde otros archivos del proyecto si los hubiera.
    fileprivate var historialCompras: [String] = []
    
    // Método para sumar dinero (encapsula la lógica de no aceptar negativos).
    func depositar(_ cantidad: Double) {
        if cantidad > 0 {
            saldo += cantidad
            print("DEPÓSITO: +$\(cantidad). Saldo actual: $\(saldo)")
        }
    }
    
    // Lógica de negocio: Verifica fondos antes de permitir la transacción.
    func comprar(producto: String, precio: Double) {
        if precio <= saldo {
            saldo -= precio
            historialCompras.append(producto)
            print("COMPRA: Compraste \(producto) por $\(precio).")
        } else {
            print("RECHAZADO: Saldo insuficiente para \(producto). Te faltan $\(precio - saldo).")
        }
    }
    
    // Getter: permite leer el saldo de forma controlada.
    func verSaldo() -> Double {
        return saldo
    }
    
    override func descripcion() {
        super.descripcion()
        print("Saldo: $\(saldo) | Historial: \(historialCompras.isEmpty ? "Vacío" : historialCompras.description)")
    }
}

// --------------------
// EJEMPLO PRÁCTICO EN CONSOLA

// 1. Creamos un cliente con saldo inicial mediante depósitos
let clienteEjemplo = Cliente(nombre: "Axel", email: "axel@tecmilenio.mx", password: "passwordSeguro", activo: true)
clienteEjemplo.depositar(500)
clienteEjemplo.comprar(producto: "Curso de AWS", precio: 250)

// 2. Creamos un administrador con nivel 5 (puede gestionar)
let adminSoporte = Administrador(nombre: "Soporte Técnico", email: "admin@dev.com", password: "root", activo: true, nivelAcceso: 5)

// 3. El administrador ayuda al cliente que olvidó su clave
adminSoporte.resetearPassword(usuario: clienteEjemplo, nueva: "NuevaClave2026")

// 4. Verificamos el estado final
clienteEjemplo.descripcion()


