//
//  ContentView.swift
//  Ejercicio 1
//
//  Created by Axel Vargas Díaz de Vivar on 23/01/26.
//

import SwiftUI

struct ContentView: View {
    var nombre = "Axel"
    let edad = "20"
    var experiencia = ["proyecto 1, proyecto 2"]
    var body: some View{
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Nombre: \(nombre) edad: \(edad)")
            ForEach (experiencia, id: \.self) { proyecto in Text("\(proyecto)")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
