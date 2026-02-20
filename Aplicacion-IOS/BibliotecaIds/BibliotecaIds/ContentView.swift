import SwiftUI

// - Modelo del Libro
struct Libro: Identifiable {
    let id = UUID()
    let titulo: String
    let autor: String
    let añoPublicacion: Int
}

// - Datos de la Biblioteca
struct BibliotecaData {
    static let libros: [Libro] = [
        Libro(titulo: "Clean Architecture", autor: "Robert C. Martin", añoPublicacion: 2017),
        Libro(titulo: "The Pragmatic Programmer", autor: "Andrew Hunt & David Thomas", añoPublicacion: 1999),
        Libro(titulo: "Code Complete", autor: "Steve McConnell", añoPublicacion: 2004),
        Libro(titulo: "Clean Code", autor: "Robert C. Martin", añoPublicacion: 2008),
        Libro(titulo: "Design Patterns", autor: "Erich Gamma, Richard Helm, Ralph Johnson & John Vlissides", añoPublicacion: 1994),
        Libro(titulo: "Refactoring", autor: "Martin Fowler", añoPublicacion: 1999),
        Libro(titulo: "Domain-Driven Design", autor: "Eric Evans", añoPublicacion: 2003),
        Libro(titulo: "Introduction to Algorithms", autor: "Thomas H. Cormen, Charles E. Leiserson, Ronald L. Rivest & Clifford Stein", añoPublicacion: 2009),
        Libro(titulo: "The Mythical Man-Month", autor: "Frederick P. Brooks Jr.", añoPublicacion: 1975),
        Libro(titulo: "Accelerate", autor: "Nicole Forsgren, Jez Humble & Gene Kim", añoPublicacion: 2018)
    ]
}

// - Vista de portada del libro
struct LibroCoverView: View {
    let titulo: String
    let size: CGFloat
    
    /// Nombre del asset de imagen para cada libro (según Assets.xcassets)
    private var nombreImagen: String? {
        switch titulo {
        case "Clean Architecture": return "Clean Architecture 1"
        case "The Pragmatic Programmer": return "The Pragmatic Programmer 1"
        case "Code Complete": return "Code Complete"
        case "Clean Code": return "Clean Code "
        case "Design Patterns": return "Design Patterns"
        case "Refactoring": return "Refactoring"
        case "Domain-Driven Design": return "Domain-Driven Design"
        case "Introduction to Algorithms": return "Introduction to Algorithms"
        case "The Mythical Man-Month": return "The Mythical Man-Month"
        case "Accelerate": return "Accelerate"
        default: return nil
        }
    }
    
    var body: some View {
        Group {
            if let nombre = nombreImagen {
                Image(nombre)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Image(systemName: "book.closed.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.brown.opacity(0.7))
            }
        }
        .frame(width: size, height: size * 1.4)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.brown.opacity(0.5), lineWidth: 1)
        )
    }
}

// - Vista de tarjeta de libro
struct LibroCardView: View {
    let libro: Libro
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            LibroCoverView(titulo: libro.titulo, size: 80)
            
            VStack(alignment: .leading, spacing: 6) {
                Text(libro.titulo)
                    .font(.headline)
                    .foregroundColor(.black)
                    .lineLimit(2)
                
                Text(libro.autor)
                    .font(.subheadline)
                    .bold()
                    .foregroundColor(.black.opacity(0.8))
                
                Text("Año de publicación: \(libro.añoPublicacion)")
                    .font(.caption)
                    .italic()
                    .foregroundColor(.black.opacity(0.7))
            }
            
            Spacer(minLength: 0)
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
    }
}

// - Vista de libro para grid (orientación landscape)
struct LibroGridCardView: View {
    let libro: Libro
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            LibroCoverView(titulo: libro.titulo, size: 70)
            
            Text(libro.titulo)
                .font(.caption)
                .fontWeight(.semibold)
                .lineLimit(2)
            
            Text(libro.autor)
                .font(.caption2)
                .foregroundColor(.secondary)
                .lineLimit(1)
            
            Text("\(libro.añoPublicacion)")
                .font(.caption2)
                .italic()
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.9))
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 1)
    }
}

// - Vista principal con Size Classes
struct ContentView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.brown
                    .ignoresSafeArea()
                
                // Layout adaptativo según Size Classes
                Group {
                    if isCompactLayout {
                        // Portrait / iPhone compact: lista vertical
                        listaVertical
                    } else {
                        // Landscape / iPad regular: grid de 2 columnas
                        gridLibros
                    }
                }
                .padding()
            }
            .navigationTitle("Mi Biblioteca")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    /// Determina si usar layout compacto (lista) o regular (grid)
    private var isCompactLayout: Bool {
        horizontalSizeClass == .compact
    }
    
    /// Lista vertical para orientación portrait
    private var listaVertical: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(BibliotecaData.libros) { libro in
                    LibroCardView(libro: libro)
                }
            }
        }
    }
    
    /// Grid para orientación landscape o iPad
    private var gridLibros: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible(), spacing: 16),
                GridItem(.flexible(), spacing: 16)
            ], spacing: 16) {
                ForEach(BibliotecaData.libros) { libro in
                    LibroGridCardView(libro: libro)
                }
            }
        }
    }
}

#Preview("Portrait (Compact)") {
    ContentView()
        .environment(\.horizontalSizeClass, .compact)
}

#Preview("Landscape (Regular)") {
    ContentView()
        .environment(\.horizontalSizeClass, .regular)
}
