# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.create!(
	name: "Ocio y Turismo Activo",
	summary: "Tonterías varias")

Empresa.create!(
	name: "Valle de los Molinos",
	description: "Un año más Valle de los Molinos saca su oferta de campamentos de verano para 2016. Campamentos de verano en Extremadura, donde disfrutamos de actividades multiaventura, naturaleza e inglés.
		Situado en un enclave idílico a los pies de Sierra Morena, podemos encontrar el valle de los molinos en las cercanías de Llerena, donde el joven podrá disfrutar de una experiencia inolvidable en  su campamentos de 15 días en Los Molinos realizando diferentes actividades en el medio natural, así como diferentes prácticas deportivas, visitas culturales y talleres de artesanía ofrecidos por expertos artesanos, además algunos de estos talleres son impartidos en la modalidad bilingüe, en inglés.
		En el Valle de los molinos, sabemos de la importancia del inglés como segunda lengua hoy en día, por eso la hemos incluido en nuestras actividades de forma natural. No queremos enfocarlo a difíciles y pesadas actividades escritas, sino a vocabulario natural hablado y enfocado a mejorar la fluidez y la respuesta a situaciones habituales, convirtiendo el inglés no en una asignatura, sino en una herramienta de comunicación que nos mejora la vida día tras día.",
	address: "Calle Zapatería, 6",
	web: "www.valledelosmolinos.com",
	email: "juanmi@valledelosmolinos.com",
	tel: "644 252 097",
	video: "https://www.youtube.com/embed/1qykU8LDbrY",
	plan: 0,
	creditos: 0,
	mlon: 38.237937,
	mlat:  -6.014943,
	id: 1
)


Promo.create!(
	titulo: "Rebaja del 50% en todos nuestros productos",
	texto: "Te presentamos las tarjetas de memoria con mayor capacidad y velocidad de lectura de su clase, idóneas para vídeos Full HD. Mantén tus recuerdos siempre a salvo con el rendimiento y fiabilidad de las tarjetas EVO Plus. ",
	empresa_id: 1,
	id: 1
)
Promo.create!(
	titulo: "Rebaja del 80% en casas",
	texto: "Información muy valiosa. Ayer nos preguntó la tía qué factores externos nos motivaban y yo le dije que ver como personas de mi entorno me retan intelectualmente con cualquier tema de la vida. Me parecía guay decirtelo. ",
	empresa_id: 1,
	id: 2
)
