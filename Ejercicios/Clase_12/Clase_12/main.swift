//
//  main.swift
//  Clase_12
//
//  Created by Axel Díaz de Vivar on 22/04/26.
//

import Foundation

// MARK: - Enums
// Los enums nos permiten definir un grupo de valores relacionados de forma segura.
enum Level: String {
    case basico = "Básico"
    case intermedio = "Intermedio"
    case avanzado = "Avanzado"
}

enum AcademicStatus: String {
    case aprobado = "Aprobado"
    case reprobado = "Reprobado"
    case excelente = "Excelente"
}

// MARK: - Modelos (Structs)
// Usamos struct para datos simples. Student actúa como un contenedor de información.
struct Student {
    let id: Int
    let name: String
    let age: Int
    let email: String
}

// MARK: - Lógica de Negocio (Classes)

// La clase Enrollment gestiona la relación entre un alumno y sus notas en un curso específico.
class Enrollment {
    let student: Student
    let courseName: String
    var grades: [Double] = [] // Arreglo para almacenar múltiples calificaciones
    
    // Propiedad computada: Calcula el promedio cada vez que se solicita.
    // Usamos 'guard' para asegurar que el arreglo no esté vacío y evitar división por cero.
    var average: Double {
        guard !grades.isEmpty else { return 0.0 }
        let sum = grades.reduce(0, +) // Suma todos los elementos del arreglo
        return sum / Double(grades.count)
    }
    
    // Propiedad computada: Determina el estado basándose en el promedio actual.
    var status: AcademicStatus {
        switch average {
        case ..<6: return .reprobado
        case ..<9: return .aprobado
        default: return .excelente
        }
    }
    
    init(student: Student, courseName: String) {
        self.student = student
        self.courseName = courseName
    }
    
    func addGrade(_ grade: Double) {
        // Validación de lógica de negocio: Las notas deben ser de 0 a 10.
        guard grade >= 0 && grade <= 10 else {
            print("Error: La calificación \(grade) no es válida.")
            return
        }
        grades.append(grade)
    }
}

// La clase Course controla la capacidad y quiénes están inscritos.
class Course {
    let code: String
    let name: String
    let level: Level
    let maxCapacity: Int
    var enrolledStudents: [Student] = [] // Lista de estudiantes inscritos
    
    init(code: String, name: String, level: Level, maxCapacity: Int) {
        self.code = code
        self.name = name
        self.level = level
        self.maxCapacity = maxCapacity
    }
    
    // Método de validación antes de realizar la inscripción.
    func canEnroll(_ student: Student) -> Bool {
        // Validar que no se exceda el cupo máximo usando guard.
        guard enrolledStudents.count < maxCapacity else {
            print("Error: El curso \(name) está lleno.")
            return false
        }
        // Validar que el estudiante no esté ya en el arreglo (evita duplicados).
        guard !enrolledStudents.contains(where: { $0.id == student.id }) else {
            print("Error: El estudiante \(student.name) ya está inscrito.")
            return false
        }
        return true
    }
}

// MARK: - Sistema Principal
// Esta clase actúa como el motor que conecta todas las piezas.
class CampusSystem {
    var students: [Student] = []
    var courses: [Course] = []
    var enrollments: [Enrollment] = []
    
    // Crea un estudiante validando los requisitos del ejercicio.
    func registerStudent(id: Int, name: String, age: Int, email: String) {
        guard !name.isEmpty else { return print("Error: Nombre vacío") }
        guard age >= 16 else { return print("Error: Edad mínima 16") }
        guard email.contains("@") else { return print("Error: Email inválido") }
        
        let newStudent = Student(id: id, name: name, age: age, email: email)
        students.append(newStudent)
        print("Estudiante \(name) agregado correctamente.")
    }
    
    func registerCourse(code: String, name: String, level: Level, capacity: Int) {
        let newCourse = Course(code: code, name: name, level: level, maxCapacity: capacity)
        courses.append(newCourse)
        print("Curso \(name) agregado correctamente.")
    }
    
    // Maneja la inscripción buscando primero que el alumno y curso existan (uso de Optionals).
    func enrollStudent(studentId: Int, courseCode: String) {
        // Buscamos en los arreglos usando first(where:) que devuelve un opcional.
        guard let student = students.first(where: { $0.id == studentId }),
              let course = courses.first(where: { $0.code == courseCode }) else {
            print("Error: Estudiante o Curso no encontrado.")
            return
        }
        
        // Si pasa las validaciones de la clase Course, creamos el registro de inscripción.
        if course.canEnroll(student) {
            course.enrolledStudents.append(student)
            let newEnrollment = Enrollment(student: student, courseName: course.name)
            enrollments.append(newEnrollment)
            print("Inscripción de \(student.name) en \(course.name) realizada correctamente.")
        }
    }
    
    // Busca la inscripción específica para añadir la nota.
    func addGradeToStudent(studentId: Int, courseName: String, grade: Double) {
        if let enrollment = enrollments.first(where: { $0.student.id == studentId && $0.courseName == courseName }) {
            enrollment.addGrade(grade)
            print("Calificación \(grade) agregada a \(enrollment.student.name).")
        }
    }
    
    // Itera sobre el arreglo de inscripciones para imprimir los resultados finales.
    func showFinalReport() {
        print("\n=== REPORTE FINAL ===")
        for enrollment in enrollments {
            print("Estudiante: \(enrollment.student.name)")
            print("Curso: \(enrollment.courseName)")
            print("Calificaciones: \(enrollment.grades)")
            // Formateamos el promedio a 2 decimales para una mejor vista.
            print("Promedio: \(String(format: "%.2f", enrollment.average))")
            print("Estado: \(enrollment.status.rawValue)")
            print("----------------------")
        }
    }
}

// MARK: - Ejecución
// Instanciamos el sistema y simulamos el uso.
let control = CampusSystem()

// 1. Registro de datos iniciales
control.registerStudent(id: 1, name: "Ana", age: 21, email: "ana@correo.com")
control.registerCourse(code: "SW101", name: "Swift Básico", level: .basico, capacity: 20)

// 2. Proceso de inscripción
control.enrollStudent(studentId: 1, courseCode: "SW101")

// 3. Carga de calificaciones
control.addGradeToStudent(studentId: 1, courseName: "Swift Básico", grade: 9.5)
control.addGradeToStudent(studentId: 1, courseName: "Swift Básico", grade: 8.0)

// 4. Generación del reporte solicitado
control.showFinalReport()
