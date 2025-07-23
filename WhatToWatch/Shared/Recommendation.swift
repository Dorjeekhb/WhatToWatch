//
//  Recommendation.swift
//  WhatToWatch
//
//  Created by Dorjee on 23/7/25.
//

import Foundation

struct Recommendation: Identifiable {
    let id = UUID()
    let title: String
    let genre: String
    let platform: String
    let duration: String
    let description: String
}

let sampleRecommendations: [Recommendation] = [
    Recommendation(
        title: "Inception",
        genre: "Sci-Fi",
        platform: "Netflix",
        duration: "2h 28m",
        description: "Dom Cobb es un ladrón especializado en el arte de la extracción: robar secretos del subconsciente mientras las víctimas sueñan. Su habilidad lo ha convertido en un jugador codiciado en el mundo del espionaje corporativo, pero también le ha costado todo lo que ama. Ahora tiene una oportunidad de redención si puede lograr lo imposible: una inserción, plantar una idea en la mente de alguien."
    ),
    Recommendation(
        title: "The Office",
        genre: "Comedia",
        platform: "Prime Video",
        duration: "22 min",
        description: "La serie documenta la vida cotidiana de los empleados de la oficina de ventas Dunder Mifflin en Scranton, Pensilvania. A través de un formato de falso documental, se muestran momentos incómodos, bromas internas, tensiones románticas y las excentricidades del jefe Michael Scott, que mezcla lo absurdo con lo entrañable."
    ),
    Recommendation(
        title: "The Witcher",
        genre: "Fantasía",
        platform: "Netflix",
        duration: "1h",
        description: "Geralt de Rivia, un cazador de monstruos mutado genéticamente, lucha por encontrar su lugar en un mundo donde a menudo las personas son más perversas que las bestias. Basada en la saga de Andrzej Sapkowski, la serie mezcla política, magia y monstruos en un entorno brutal e impredecible."
    ),
    Recommendation(
        title: "Breaking Bad",
        genre: "Drama",
        platform: "Netflix",
        duration: "45 min",
        description: "Walter White, un profesor de química diagnosticado con cáncer terminal, decide fabricar metanfetamina con la ayuda de un antiguo alumno para asegurar el futuro financiero de su familia. La serie sigue su transformación en Heisenberg, uno de los criminales más temidos del suroeste de Estados Unidos."
    ),
    Recommendation(
        title: "Stranger Things",
        genre: "Ciencia ficción",
        platform: "Netflix",
        duration: "50 min",
        description: "En la ciudad de Hawkins, Indiana, un niño desaparece misteriosamente, lo que da pie a una serie de eventos sobrenaturales que incluyen experimentos secretos del gobierno, una niña con poderes telequinéticos y una dimensión oscura llamada El Otro Lado. Un homenaje a los 80 cargado de nostalgia y suspenso."
    ),
    Recommendation(
        title: "The Mandalorian",
        genre: "Aventura",
        platform: "Disney+",
        duration: "40 min",
        description: "En los márgenes de la galaxia, un solitario cazarrecompensas conocido como el Mandaloriano acepta una misteriosa misión que cambiará su destino. Ambientada en el universo de Star Wars, la serie mezcla acción, western espacial y drama paternal con la entrañable aparición de Grogu, el Niño."
    ),
    Recommendation(
        title: "Dark",
        genre: "Misterio",
        platform: "Netflix",
        duration: "55 min",
        description: "En la ciudad alemana de Winden, la desaparición de varios niños expone secretos oscuros y una red de viajes en el tiempo que afecta a varias generaciones. 'Dark' es una compleja historia de bucles temporales, familias entrelazadas y un destino inevitable que desafía la lógica."
    )
]
