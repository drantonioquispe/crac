********************************************************************************
**************          Cálculo de Tamaño de Muestra              **************
********************************************************************************

* Estadístico: Antonio Quispe (drantonioquispe@gmail.com, +51 95131-3577)          



*** Housekeeping


** Configuramos nuestras preferencias 

* Iniciamos desde zero
clear							// Limpiamos la data previa

* Configuramos la visualización de datos 
set more off					// Desactivamos el comando more
set linesize 80					// Fijamos como máximo 80 caracteres por línea
set scheme s2mono				// Fijamos los gráficos como monocromático 


**** Tamaño de muestra : 


*** Escenario 1: Muestra para estimar incrementos de una media en una misma población 


** Supuestos: 2 colas, Ho: m=m0 vs Ha: m!=m0, m=20, diff=10 (o ma=30), sd=10, p=0.05, power=0.80

* n?
power onemean 20 30, sd(10)
power onemean 20, diff(10) sd(10)		// lo mismo pero especificando la diferencia
power onemean 20 30, sd(10) knownsd		// lo mismo pero si conoces la SD de la población

power onemean 20, diff(10 20 30) sd(10 12.5 15) table(alpha power N delta m0 ma sd)	// Tabla

power onemean 20, diff(10 20 30) power(0.8) sd(10 12.5 15) graph
power onemean 20, diff(10 20 30) power(0.8) sd(10 12.5 15)																			/// 
	graph(legend(on pos(2) cols(1) title("Desviación Estándar ({&sigma})")															///
	ring(0) region(style(none))) graphregion(color(white))																			///
	title("Muestra para una diferencia de medias en una población") 																///
	subtitle("Prueba {it:t} " "{txt}{bind:H{sub:0}: {&mu} = {&mu}{sub:0}} {txt}versus  {bind:H{sub:a}: {&mu} {&ne} {&mu}{sub:0}}") 	///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:1-{&beta}} = {res:.8}{txt:,} {txt:{&mu}{sub:0}} = {res:20}")		///
	ytitle("Tamaño de Muestra (n)") 																								///
	xtitle("Diferencia Esperada ({&mu}{sub:a}-{&mu}{sub:0})"))

* Poder de estudio?
power onemean 20 30, n(10) sd(10)

power onemean 20, diff(5 (5) 15) sd(10) n(10 (2) 20) table(alpha power N delta m0 ma sd)	// Tabla

power onemean 20, diff(5 (5) 15) sd(10) n(8 (2) 16)																					/// 
	graph(legend(on pos(3) cols(1) title("Media Alterna ({&mu}{sub:a})")															///
	ring(0) region(style(none))) graphregion(color(white))																			///
	title("Poder de Estudio para una diferencia de medias en una población")														///
	subtitle("Prueba {it:t} " "{txt}{bind:H{sub:0}: {&mu} = {&mu}{sub:0}}  {txt}versus  {bind:H{sub:a}: {&mu} {&ne} {&mu}{sub:0}}") ///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:1-{&beta}} = {res:.8}{txt:,} {txt:{&mu}{sub:0}} = {res:20}")		///
	ytitle("Power (1-{&beta})")  																									///
	xtitle("Diferencia Esperada ({&mu}{sub:a}-{&mu}{sub:0})"))

* Efecto esperado  (delta/sd)?
power onemean 20, n(10) power(0.8) sd(10)

power onemean 20, n(10 20 30) power(0.8) sd(10 12.5 15) table(alpha power N delta m0 ma sd)

power onemean 20, n(10 20 30) power(0.8) sd(10 12.5 15)																				///
	graph(legend(on pos(2) cols(1) title("Desviación Estándar ({&sigma})")															///
	ring(0) region(style(none))) graphregion(color(white))																			///
	title("Media objetivo para una Diferencia de Medias en una Población") 															///
	subtitle("Prueba {it:t} " "{txt}{bind:H{sub:0}: {&mu} = {&mu}{sub:0}}  {txt}versus  {bind:H{sub:a}: {&mu} {&ne} {&mu}{sub:0}}") ///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:1-{&beta}} = {res:.8}{txt:,} {txt:{&mu}{sub:0}} = {res:20}")		///
	ytitle("Media objetivo ({&mu}{sub:a})")  																						///
	xtitle("Tamaño de muestra (N)"))

* Gráficos unificados 
power onemean 20 (25(5)35), n(20 (5) 40) sd(10) alpha(0.05 0.1) graph(by(ma) graph(alpha))

* Una cola (superioridad)?
power onemean 20, n(10) power(0.8) sd(10) onesided

power onemean 20, diff(10 20 30) power(0.8) sd(10 12.5 15) onesided table		// Tabla

power onemean 20, diff(10 20 30) power(0.8) sd(10 12.5 15) onesided																			/// 
	graph(legend(on pos(2) cols(1) title("Desviación Estándar ({&sigma})")	 																///
	ring(0) region(style(none))) graphregion(color(white))																					///
	title("Muestra para una diferencia de medias en una población") 																		///
	subtitle("Prueba {it:t} de una cola" "{txt}{bind:H{sub:0}: {&mu} = {&mu}{sub:0}}  {txt}versus  {bind:H{sub:a}: {&mu} > {&mu}{sub:0}}") 	///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:1-{&beta}} = {res:.8}{txt:,} {txt:{&mu}{sub:0}} = {res:20}")				///
	ytitle("Tamaño de Muestra (n)") 																										///
	xtitle("Diferencia Esperada ({&mu}{sub:a}-{&mu}{sub:0})"))


	
*** Escenario 2: Muestra para estimar incrementos de una proporción en una misma población 


** Supuestos: 2 colas, Ho: p=p0 vs Ha: p!=p0, p=10, diff=10 (o p0=20), p=0.05, power=0.80

* n?
power oneproportion 0.1 0.2
power oneproportion 0.1, diff(0.1)				// lo mismo pero especificando la diferencia
power oneproportion 0.1, diff(0.1) power(0.9)	// lo mismo pero con un poder del 90%

power oneproportion 0.1, diff(0.1(0.05)0.2) power(0.8 0.85 0.9) table			// Tabla

power oneproportion 0.1, diff(0.1(0.05)0.2) power(0.8 0.85 0.9)																				/// 
	graph(legend(on pos(2) cols(1) title("Diferencia (p-p{sub:0})")																			///
	ring(0) region(style(none))) graphregion(color(white))																					///
	title("Muestra para una Diferencia de proporciones en una población") 																	///
	subtitle("Prueba {it:z}" "{txt}{bind:H{sub:0}: p = p{sub:0}}  {txt}versus  {bind:H{sub:a}: p {&ne} p{sub:0}}") 							///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:p{sub:0}} = {res:.1}")													///
	ytitle("Tamaño de Muestra (n)") 																										///
	xtitle("Power (1-{&beta})"))
	
* Poder de estudio?
power oneproportion 0.1, diff(0.1) n(80)

power oneproportion 0.1, diff(0.1(0.05)0.2) n(40 80 120) table					// Tabla

power oneproportion 0.1, diff(0.1(0.05)0.2) n(40 80 120) 																					///
	graph(legend(on pos(4) cols(1) title("Diferencia (p-p{sub:0})")																			///
	ring(0) region(style(none))) graphregion(color(white))																					///
	title("Poder de estudio para una Diferencia de proporciones en una población") 															///
	subtitle("Prueba {it:z}" "{txt}{bind:H{sub:0}: p = p{sub:0}}  {txt}versus  {bind:H{sub:a}: p {&ne} p{sub:0}}") 							///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:p{sub:0}} = {res:.1}")													///
	ytitle("Power (1-{&beta})") 																											///
	xtitle("Tamaño de Muestra (n)"))

* Efecto esperado  (delta/sd)?
power oneproportion 0.1,  n(80) power(0.8)

power oneproportion 0.1,  n(40 80 120) power(0.8 0.85 0.9) table				// Tabla

power oneproportion 0.1,  n(40 80 120) power(0.8 0.85 0.9)																					///
	graph(legend(on pos(2) cols(1) title("Power (1-{&beta})")				 																///
	ring(0) region(style(none))) graphregion(color(white))																					///
	title("Media objetivo para una diferencia de medias en una población") 																	///
	subtitle("Prueba {it:z}" "{txt}{bind:H{sub:0}: p = p{sub:0}}  {txt}versus  {bind:H{sub:a}: p {&ne} p{sub:0}}{txt}; {bind:p > p{sub:0}}") 	///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:p{sub:0}} = {res:.1}")													///
	ytitle("Proporción esperada (p)")  																										///
	xtitle("Tamaño de muestra (N)"))

* Gráficos unificados 
power oneproportion 0.1, diff(0.1(0.05)0.2) power(0.8 0.85 0.9) graph(by(ma) graph(alpha))

* Una cola (superioridad)?
power oneproportion 0.1 0.2 onesided

power oneproportion 0.1, diff(0.1(0.05)0.2) power(0.8 0.85 0.9) table			// Tabla

power oneproportion 0.1, diff(0.1(0.05)0.2) power(0.8 0.85 0.9) onesided																	///
	graph(legend(on pos(2) cols(1) title("Diferencia (p-p{sub:0})")																			///
	ring(0) region(style(none))) graphregion(color(white))																					///
	title("Muestra para una diferencia de Proporciones en una Población") 																	///
	subtitle("Prueba {it:z}" "{txt}{bind:H{sub:0}: p = p{sub:0}}  {txt}versus  {bind:H{sub:a}: p > p{sub:0}}") 								///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:p{sub:0}} = {res:.1}")													///
	ytitle("Tamaño de Muestra (n)") 																										///
	xtitle("Power (1-{&beta})"))



*** Escenario 3: Muestra para estimar diferencia de medias de dos poblaciones independientes con varianzas desiguales 


** Supuestos: 2 colas, Ho: m2=m1 vs Ha: m2!= m1, sd1=5.5, sd2=5, p=0.05, power=0.80

* n?
power twomeans 12 16, sd1(5.5) sd2(5) 
power twomeans 12, diff(4) sd1(5.5) sd2(5)			// lo mismo pero especificando la diferencia
power twomeans 12 16, sd1(5.5) sd2(5) knownsd		// lo mismo pero si conoces la SD de la población

power twomeans 12, diff(2 (1) 6) sd1(5.5) sd2(5 5.5 6) table					// Tabla

power twomeans 12, diff(2 (1) 6) sd1(5.5) sd2(5 5.5 6)							/// Gráfico
	graph(legend(on pos(2) cols(1) title("Desviación Estándar de los Casos ({&sigma}{sub:2})")												///
	ring(0) region(style(none))) graphregion(color(white))																					///
	title("Muestra para Diferencia de Medias de dos Poblaciones") 																			///
	subtitle("Prueba {it:t} asumiendo varianzas desiguales" "{txt}{bind:H{sub:0}: {&mu}{sub:2} = {&mu}{sub:1}}  {txt}versus  {bind:H{sub:a}: {&mu}{sub:2} {&ne} {&mu}{sub:1}}") ///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:1-{&beta}} = {res:.8}{txt:,} {txt:{&mu}{sub:1}} = {res:12}{txt:,} {txt:{&sigma}{sub:1}} = {res:5.5}")		///
	ytitle("Tamaño de Muestra (n)") 																										///
	xtitle("Diferencia esperada ({&mu}{sub:2}-{&mu}{sub:1})"))

* Poder de estudio?
power twomeans 12 16, sd1(5.5) sd2(5) n(58)

power twomeans 12, diff(2 (1) 6) sd1(5.5) sd2(5) n(50 (5) 70) table				// Tabla

power twomeans 12, diff(2 (1) 6) sd1(5.5) sd2(5) n(50 (5) 70)																				///
	graph(legend(on pos(3) cols(1) title("Diferencia ({&mu}{sub:2}-{&mu}{sub:1})")															///
	ring(0) region(style(none))) graphregion(color(white))																					///
	title("Media estimada experimental para una diferencia de Medias de dos Poblaciones")													///
	subtitle("Prueba {it:t} asumiendo varianzas desiguales" "{txt}{bind:H{sub:0}: {&mu}{sub:2} = {&mu}{sub:1}}  {txt}versus  {bind:H{sub:a}: {&mu}{sub:2} {&ne} {&mu}{sub:1}}") ///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:{&mu}{sub:1}} = {res:12}{txt:,} {txt:{&sigma}{sub:1}} = {res:5.5}{txt:,} {txt:{&sigma}{sub:2}} = {res:5}")		///
	ytitle("Power (1-{&beta})")  																											///
	xtitle("Diferencia esperada ({&mu}{sub:2}-{&mu}{sub:1})"))

* Efecto esperado  (delta/sd)?
power twomeans 12, sd1(5.5) sd2(5) n(58) power(0.8)

power twomeans 12, sd1(5.5) sd2(5 5.5 6) n(50 (5) 70) power(0.8) table			// Tabla

power twomeans 12, sd1(5.5) sd2(5 5.5 6) n(50 (5) 70) power(0.8)																			///
	graph(legend(on pos(2) cols(1) title("Desviación Estándar de los Casos ({&sigma}{sub:2})")												///
	ring(0) region(style(none))) graphregion(color(white))																					///
	title("Media objetivo para una diferencia de Medias de dos Poblaciones") 																///
	subtitle("Prueba {it:t} asumiendo varianzas desiguales" "{txt}{bind:H{sub:0}: {&mu}{sub:2} = {&mu}{sub:1}}  {txt}versus  {bind:H{sub:a}: {&mu}{sub:2} {&ne} {&mu}{sub:1}}") ///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:1-{&beta}} = {res:.8}{txt:,} {txt:{&mu}{sub:1}} = {res:12}{txt:,} {txt:{&sigma}{sub:1}} = {res:5.5}")		///
	ytitle("Media esperada de casos ({&mu}{sub:2})")  																						///
	xtitle("Tamaño de muestra (N)"))

* Una cola (superioridad)?
power twomeans 12, sd1(5.5) sd2( n( 70) power(0.8) onesided 

power twomeans 12, sd1(5.5) sd2(5 5.5 6) n(50 (5) 70) power(0.8) onesided table // Tabla

power twomeans 12, sd1(5.5) sd2(5 5.5 6) n(50 (5) 70)  power(0.8)																			///
	graph(legend(on pos(2) cols(1) title("Desviación Estándar de los Casos ({&sigma}{sub:2})")												///
	ring(0) region(style(none))) graphregion(color(white))																					///
	title("Media objetivo para una diferencia de Medias de dos Poblaciones") 																///
	subtitle("Prueba {it:t} de una cola asumiendo varianzas desiguales" "{txt}{bind:H{sub:0}: {&mu}{sub:2} = {&mu}{sub:1}}  {txt}versus  {bind:H{sub:a}: {&mu}{sub:2} > {&mu}{sub:1}}") ///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:1-{&beta}} = {res:.8}{txt:,} {txt:{&mu}{sub:1}} = {res:12}{txt:,} {txt:{&sigma}{sub:1}} = {res:5.5}")		///
	ytitle("Media esperada de casos ({&mu}{sub:2})")  																						///
	xtitle("Tamaño de muestra (N)"))

	
	
*** Escenario 4: Muestra para estimar diferencia de proporciones en dos poblaciones independientes 


** Supuestos: 2 colas, Ho: p2=p1 vs Ha: p2!=p1, p1=10, diff=40 (o p2=50), p=0.05, power=0.80

* n?
power twoproportions 0.1 0.5
power twoproportions 0.1, diff(0.4)				// lo mismo pero especificando la diferencia
power twoproportions 0.1, diff(0.4) nratio(0.5)	// lo mismo pero especificando dos controles por caso
power twoproportions 0.1, diff(0.4) nratio(2)	// lo mismo pero especificando dos casos por control
power twoproportions 0.1, diff(0.4) power(0.9)	// lo mismo pero con un poder del 90%
power twoproportions 0.1, diff(0.4) n1(20) compute(n2)	// lo mismo pero calculando n2
power twoproportions 0.1, or(4) 				// lo mismo pero especificando el odds rati (OR)
power twoproportions 0.1, rr(4) 				// lo mismo pero especificando el riesgo relativo (RR)

power twoproportions 0.1 (0.2(0.1)0.9), power(0.8 0.9) table					// Tabla

power twoproportions 0.1 (0.2(0.1)0.5), power(0.8 0.85 0.9) 																						/// Gráfico
	graph(legend(on pos(2) cols(1) title("Poder (1-{&beta})")																						///
	ring(0) region(style(none))) graphregion(color(white))																							///
	title("Muestra para p2-p1 en poblaciones independientes") 																						///
	subtitle(" Prueba {&chi}{sup:2} de Pearson" "{txt}{bind:H{sub:0}: p{sub:2} = p{sub:1}}  {txt}versus  {bind:H{sub:a}: p{sub:2} {&ne} p{sub:1}}") ///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:p{sub:0}} = {res:.1}")															///
	ytitle("Tamaño de Muestra (n)") 																												///
	xtitle("Proporción experimental (p{sub:2})"))

* Poder de estudio?
power twoproportions 0.1 0.5, n(40)
power twoproportions 0.1, diff(0.4) n1(20) n2(40)				// lo mismo pero especificando la diferencia
power twoproportions 0.1, diff(0.4) n2(40) nratio(2)	// lo mismo pero especificando dos controles por caso
power twoproportions 0.1, diff(0.4) n1(20) nratio(2)	// lo mismo pero especificando dos casos por control

power twoproportions 0.1 0.5, n(30(10)60) table									// Tabla

power twoproportions 0.1 (0.3 0.4 0.5), n(30(10)60) 																								/// Gráfico
	graph(legend(on pos(4) cols(1) title("Proporción experimental (p{sub:2})")																		///
	ring(0) region(style(none))) graphregion(color(white))																							///
	title("Poder de estudio para p2-p1 en poblaciones independientes") 																				///
	subtitle(" Prueba {&chi}{sup:2} de Pearson" "{txt}{bind:H{sub:0}: p{sub:2} = p{sub:1}}  {txt}versus  {bind:H{sub:a}: p{sub:2} {&ne} p{sub:1}}{txt}; {bind:p{sub:2} > p{sub:1}}") 	///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:p{sub:1}} = {res:.1}")															///
	ytitle("Power (1-{&beta})") 																													///
	xtitle("Tamaño de Muestra (n)"))

* Proporción del grupo experimental  (p2)?
power twoproportions 0.1, n(40) power(0.8)

power twoproportions 0.1, n(30(10)60) power(0.8 0.85 0.9) table					// Tabla

power twoproportions 0.1, n(30(10)60) power(0.8 0.85 0.9)																							/// Gráfico
	graph(legend(on pos(2) cols(1) title("Power (1-{&beta})")																					 	///
	ring(0) region(style(none))) graphregion(color(white))																							///
	title("Proporción experimental para p2-p1 en poblaciones independientes") 																		///
	subtitle(" Prueba {&chi}{sup:2} de Pearson" "{txt}{bind:H{sub:0}: p{sub:2} = p{sub:1}}  {txt}versus  {bind:H{sub:a}: p{sub:2} {&ne} p{sub:1}}") ///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:p{sub:0}} = {res:.1}")															///
	ytitle("Proporción experimental (p{sub:2})")  																									///
	xtitle("Tamaño de muestra (N)"))

* Una cola (superioridad)?
power twoproportions 0.1 0.5, onesided

power twoproportions 0.1 (0.2(0.1)0.9), power(0.8 0.9)  onesided table			// Tabla

power twoproportions 0.1 (0.2(0.1)0.5), power(0.8 0.85 0.9) onesided																				/// Gráfico
	graph(legend(on pos(2) cols(1) title("Power (1-{&beta})")																						///
	ring(0) region(style(none))) graphregion(color(white))																							///
	title("Muestra total para p2-p1 en poblaciones independientes") 																				///
	subtitle(" Prueba {&chi}{sup:2} de Pearson" "{txt}{bind:H{sub:0}: p{sub:2} = p{sub:1}}  {txt}versus  {bind:H{sub:a}: p{sub:2} > p{sub:1}}") 	///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:p{sub:0}} = {res:.1}")															///
	ytitle("Tamaño de Muestra (n)") 																												///
	xtitle("Proporción experimental (p{sub:2})"))

* Odds ratios
power twoproportions (.3) , oratio(2)

power twoproportions (.3 .4 .5) , oratio(2 2.5 3) 								/// Tabla

power twoproportions (.3 .4 .5) , oratio(2 2.5 3) 																									/// Gráfico
	graph(legend(on pos(3) cols(1) title("Proporción experimental (p{sub:2})")																		///
	ring(0) region(style(none))) graphregion(color(white))																							///
	title("Poder de estudio para OR en poblaciones independientes") 																				///
	subtitle(" Prueba {&chi}{sup:2} de Pearson" "{txt}{bind:H{sub:0}: p{sub:2} = p{sub:1}}  {txt}versus  {bind:H{sub:a}: p{sub:2} {&ne} p{sub:1}}") ///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:{betha}} = {res:0.8}")															///
	ytitle("Tamaño de muestra (n)") 																												///
	xtitle("Proporción control (p{sub:1})"))

* razón de prevalencias
power twoproportions (.3) , rrisk(2)

power twoproportions (.3 .4 .5) , rrisk(2 2.5 3) 								/// Tabla

power twoproportions (.3 .4 .5) , rrisk(2 2.5 3) 																									/// Gráfico
	graph(legend(on pos(3) cols(1) title("Proporción experimental (p{sub:2})")																		///
	ring(0) region(style(none))) graphregion(color(white))																							///
	title("Poder de estudio para RP en poblaciones independientes") 																				///
	subtitle(" Prueba {&chi}{sup:2} de Pearson" "{txt}{bind:H{sub:0}: p{sub:2} = p{sub:1}}  {txt}versus  {bind:H{sub:a}: p{sub:2} {&ne} p{sub:1}}") ///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:{betha}} = {res:0.8}")															///
	ytitle("Tamaño de muestra (n)") 																												///
	xtitle("Proporción control (p{sub:1})"))

	
*** Escenario 5: Muestra para estimar diferencia de medias de dos muestras dependientes con varianzas iguales 


** Supuestos: 2 colas, Ho: d=d0 vs Ha: d!= d0, sd1=sd2=sd, p=0.05, power=0.80

* n?
power pairedmeans 12 16, sd(5.5) corr(0.4)

power pairedmeans 12 (16(1)18), sd(5.5) corr(0.3 0.4 0.5) table(alpha power N delta da ma1 ma2 sd corr) // Tabla

power pairedmeans 12 (16(1)18), sd(5.5) corr(0.3 0.4 0.5)																							/// Gráfico
	graph(legend(on pos(2) cols(1) title("Correlación ({&rho})")																					///
	ring(0) region(style(none))) graphregion(color(white))																							///
	title("Muestra para Diferencia de Medias Pareadas")																								///		
	subtitle("Prueba {it:t} pareada asumiendo {&sigma}{sub:1} = {&sigma}{sub:2} = {&sigma}" "{txt}{bind:H{sub:0}: d = d{sub:0}}  {txt}versus  {bind:H{sub:a}: d {&ne} d{sub:0}}") ///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:1-{&beta}} = {res:.8}{txt:,} {txt:d{sub:0}} = {res:0}{txt:,} {txt:{&mu}{sub:a1}} = {res:12}{txt:,} {txt:{&sigma}} = {res:5.5}")		///
	ytitle("Tamaño de Muestra (n)") 																												///
	xtitle("Media del Control ({&mu}{sub:a2})"))

* Poder de estudio?
power pairedmeans 12 16, sd(5.5) corr(0.4) n(20)

power pairedmeans 12 (16(1)18), sd(5.5) corr(0.4) n(15 20 25) table(alpha power N delta da ma1 ma2 sd corr)	// Tabla

power pairedmeans 12 (16(1)18), sd(5.5) corr(0.4) n(15 20 25)																						/// Gráfico
	graph(legend(on pos(4) cols(1) title("Media del Control ({&mu}{sub:a2})")																		///
	ring(0) region(style(none))) graphregion(color(white))																							///
	title("Poder de estudio para una diferencia de Medias Pareadas")																				///
	subtitle("Prueba {it:t} pareada asumiendo {&sigma}{sub:1} = {&sigma}{sub:2} = {&sigma}" "{txt}{bind:H{sub:0}: d = d{sub:0}}  {txt}versus  {bind:H{sub:a}: d {&ne} d{sub:0}}") ///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:d{sub:0}} = {res:0}{txt:,} {txt:{&mu}{sub:a1}} = {res:12}{txt:,} {txt:{&sigma}{sub:d}} = {res:6}{txt:,} {txt:{&sigma}} = {res:5.5}{txt:,} {txt:{&rho}} = {res:.4}")		///
	ytitle("Poder de Estudio (1-{&beta})")  																										///
	xtitle("Tamaño de Muestra (N)"))

* Efecto o diferencia esperada?
power pairedmeans 12, sd(5.5) corr(0.4) n(20) power(0.8)

power pairedmeans 12, sd(5.5) corr(0.4) n(20) power(0.8) table				// Tabla

power pairedmeans 12, sd(5.5) corr(0.3 0.4 0.5) n(15 20 25) power(0.8) graph																		/// Gráfico
	graph(legend(on pos(2) cols(1) title("Correlación ({&rho})")																					///
	ring(0) region(style(none))) graphregion(color(white))																							///
	title("Diferencia objetivo para una diferencia de Medias de dos Poblaciones") 																	///
	subtitle("Prueba {it:t} pareada asumiendo {&sigma}{sub:1} = {&sigma}{sub:2} = {&sigma}" "{txt}{bind:H{sub:0}: d = d{sub:0}}  {txt}versus  {bind:H{sub:a}: d {&ne} d{sub:0}}{txt}; {bind:d > d{sub:0}}") ///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:1-{&beta}} = {res:.8}{txt:,} {txt:d{sub:0}} = {res:0}{txt:,} {txt:{&mu}{sub:a1}} = {res:12}{txt:,} {txt:{&sigma}} = {res:5.5}")		///
	ytitle("Diferencia esperada d{sub:a})")  																										///
	xtitle("Tamaño de muestra (N)"))

* Una cola (superioridad)?
power pairedmeans 12 16, sd(5.5) corr(0.4) onesided 

power pairedmeans 12 (16(1)18), sd(5.5) corr(0.3 0.4 0.5) onesided table		// Tabla

power pairedmeans 12 (16(1)18), sd(5.5) corr(0.3 0.4 0.5) onesided																					/// Gráfico
	graph(legend(on pos(2) cols(1) title("Correlación ({&rho})")																					///
	ring(0) region(style(none))) graphregion(color(white))																							///
	title("Muestra para Diferencia de Medias Pareadas")																								///		
	subtitle("Prueba {it:t} pareada asumiendo {&sigma}{sub:1} = {&sigma}{sub:2} = {&sigma}" "{txt}{bind:H{sub:0}: d = d{sub:0}}  {txt}versus  {bind:H{sub:a}: d > d{sub:0}}") ///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:1-{&beta}} = {res:.8}{txt:,} {txt:d{sub:0}} = {res:0}{txt:,} {txt:{&mu}{sub:a1}} = {res:12}{txt:,} {txt:{&sigma}} = {res:5.5}")		///
	ytitle("Tamaño de Muestra (n)") 																												///
	xtitle("Media del Control ({&mu}{sub:a2})"))

	
	
*** Escenario 6: Muestra para estimar diferencia de proporciones en dos muestras dependientes con varianzas iguales 


** Supuestos: 2 colas, Ho: p2=p1 vs Ha: p2!=p1, p1=10, diff=40 (o p2=50), p=0.05, power=0.80

* n?
power pairedproportions 0.1 0.4
power pairedproportions 0.1, diff(0.3)				// lo mismo pero especificando la diferencia
power pairedproportions 0.1, prdiscord(0.5)			// lo mismo pero especificando la suma de proporciones discordantes
power pairedproportions 0.1, diff(0.3) ratio(2)		// lo mismo pero especificando dos controles por caso
power pairedproportions 0.1, diff(0.3) corr(0.2)	// lo mismo pero con un poder del 90%

power pairedproportions 0.1 (0.2(0.1)0.4), power(0.8 0.85 0.9) table					// Tabla

power pairedproportions 0.1 (0.2(0.1)0.4), power(0.8 0.85 0.9) 																						/// Gráfico
	graph(legend(on pos(3) cols(1) title("p{sub:21}")																								///
	ring(0) region(style(none))) graphregion(color(white))																							///
	title("Tamaño de muestra para p{sub:21}-p{sub:12} en muestras pareadas") 																		///
	subtitle("Prueba de McNemar" "{txt}{bind:H{sub:0}: p{sub:21} = p{sub:12}}  {txt}versus  {bind:H{sub:a}: p{sub:21} {&ne} p{sub:12}}")		 	///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:p{sub:12}+p{sub:21}} = {res:.5}")												///
	ytitle("Tamaño de Muestra (n)") 																												///
	xtitle("Power (1-{&beta})"))

* Poder de estudio?
power pairedproportions 0.1 0.4, n(50)
power pairedproportions 0.1 0.4, n(50) effect(ratio)	// lo mismo pero reportando el efecto de diseño como una razón

power pairedproportions 0.1 0.4, n(40 50 60) table								// Tabla

power pairedproportions 0.1 (0.3 0.4 0.5), n(40 50 60) 																								/// Gráfico
	graph(legend(on pos(3) cols(1) title("Proporción experimental (p{sub:2})")																		///
	ring(0) region(style(none))) graphregion(color(white))																							///
	title("Poder de estudio para p{sub:21}-p{sub:12} en muestras pareadas") 																		///
	subtitle("Prueba de McNemar" "{txt}{bind:H{sub:0}: p{sub:21} = p{sub:12}}  {txt}versus  {bind:H{sub:a}: p{sub:21} {&ne} p{sub:12}}") 			///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:p{sub:12}+p{sub:21}} = {res:.5}")												///
	ytitle("Power (1-{&beta})") 																													///
	xtitle("Tamaño de Muestra (n)"))

* Proporción discordante objetivo  (p21)?
power pairedproportions, prdiscord(0.5) n(50) power(0.8)
power pairedproportions, prdiscord(0.5) n(50) power(0.8) effect(ratio) // lo mismo pero reportando el efecto de diseño como una razón

power pairedproportions, prdiscord(0.5) n(40 50 60) power(0.8 0.85 0.9) table	// Tabla

power pairedproportions, prdiscord(0.5) n(40 50 60) power(0.8 0.85 0.9)																				/// Gráfico
	graph(legend(on pos(2) cols(1) title("Power (1-{&beta})")																					 	///
	ring(0) region(style(none))) graphregion(color(white))																							///
	title("p{sub:12} objetivo para muestras pareadas") 																								///
	subtitle("Prueba {&chi}{sup:2} de Pearson" "{txt}{bind:H{sub:0}: p{sub:2} = p{sub:1}}  {txt}versus  {bind:H{sub:a}: p{sub:2} {&ne} p{sub:1}}") 	///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:p{sub:12}+p{sub:21}} = {res:.5}")												///
	ytitle("P{sub:12}") 																															///
	xtitle("Tamaño de Muestra (n)"))
		

	
*** Escenario 7: Muestra para análisis de tipo anova unidireccional (comparación de más de dos medias) 


** Supuestos: 2 colas, Ho: delta =0 vs Ha: delta !=0, m1=50, m2=60 m3=70, var error=900, p=0.05, power=0.80

* n?
power oneway 50 60 70, varerror(900)
power oneway, varmeans(60) ngroups(3) varerror(900)		// lo mismo pero especificando la varianza
power oneway 50 60 70, varerror(900) grweights(1 2 2)	// lo mismo pero especificando un diseño desbalanceado
power oneway 50 60 70, varerror(900) contrast(1 -1 0)	// lo mismo pero comparando los primeros dos grupos

power oneway, ngroups(3) varmeans(50 60 70) varerror(800 900 1000) table 		// Tabla

power oneway, ngroups(3) varmeans(50 60 70) varerror(800 900 1000) 																					/// Gráfico
	graph(legend(on pos(2) cols(1) title("Varianza del Error ({&sigma}{sub:e}{sup:2})")																///
	ring(0) region(style(none))) graphregion(color(white))																							///
	title("Muestra para un análisis ANOVA unidireccional")																							///
	subtitle(" Prueba F para efecto grupal" "{txt}{bind:H{sub:0}: {&delta} = 0}  {txt}versus  {bind:H{sub:a}: {&delta} {&ne} 0}") 					///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:N{sub:g}} = {res:3}{txt:,} {txt:{&mu}{sub:1}} = {res:50}{txt:,} {txt:{&mu}{sub:2}} = {res:60}{txt:,} {txt:{&mu}{sub:3}} = {res:70}{txt:,} {txt:{&sigma}{sub:m}{sup:2}} = {res:67}")		///
	ytitle("Tamaño de Muestra (n)") 																												///
	xtitle("Between-group variance ({&sigma}{sub:m}{sup:2})"))

* Poder de estudio?
power oneway 50 60 70, varerror(900) n(135) 
power oneway 50 60 70, varerror(900) n(135) grweights(1 2 2)	// lo mismo pero especificando un diseño desbalanceado

power oneway 50 60 70, varerror(800 900 1000) n(120 135 150)  table				// Tabla

power oneway 50 60 70, varerror(800 900 1000) n(120 135 150)																						/// Gráfico
	graph(legend(on pos(4) cols(1) title("Varianza del Error ({&sigma}{sub:e}{sup:2})")																///
	ring(0) region(style(none))) graphregion(color(white))																							///
	title("Muestra para un análisis ANOVA unidireccional")																							///
	subtitle(" Prueba F para efecto grupal" "{txt}{bind:H{sub:0}: {&delta} = 0}  {txt}versus  {bind:H{sub:a}: {&delta} {&ne} 0}") 					///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:N{sub:g}} = {res:3}{txt:,} {txt:{&mu}{sub:1}} = {res:50}{txt:,} {txt:{&mu}{sub:2}} = {res:60}{txt:,} {txt:{&mu}{sub:3}} = {res:70}{txt:,} {txt:{&sigma}{sub:m}{sup:2}} = {res:67}")		///
	ytitle("Poder de Estudio (1-{&beta})")  																										///
	xtitle("Tamaño de Muestra (N)"))

* Efecto o diferencia esperada?
power oneway, n(135) ngroups(3) power(0.8) 
power oneway, n(135) ngroups(3) power(0.8) varerror(900)	// lo mismo pero especificando la varianza

power oneway, n(120 135 150) ngroups(3) power(0.8 0.85 0.9) table				// Tabla

power oneway, n(120 135 150) ngroups(3) power(0.8 0.85 0.9)																							/// Gráfico
	graph(legend(on pos(2) cols(1) title("Poder de Estudio (1-{&beta})")																			///
	ring(0) region(style(none))) graphregion(color(white))																							///
	title("Muestra para un análisis ANOVA unidireccional")																							///
	subtitle(" Prueba F para efecto grupal" "{txt}{bind:H{sub:0}: {&delta} = 0}  {txt}versus  {bind:H{sub:a}: {&delta} {&ne} 0}") 					///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:N{sub:g}} = {res:3}{txt:,} {txt:{&mu}{sub:1}} = {res:50}{txt:,} {txt:{&mu}{sub:2}} = {res:60}{txt:,} {txt:{&mu}{sub:3}} = {res:70}{txt:,} {txt:{&sigma}{sub:m}{sup:2}} = {res:67}")		///
	ytitle("Effect size ({&delta})")  																												///
	xtitle("Tamaño de muestra (N)"))
		

	
*** Escenario 8: Muestra para comparación de más de dos proporciones


** Supuestos: 2 colas, Ho: delta =0 vs Ha: delta !=0, p1=50, p2=60 p3=70, p=0.05, power=0.80

*  n para estimar el efecto de la fila?
artbin,pr(.5 .6 .7) ngroups(3) aratios(1 1 1) distant(0) alpha(0.05) power(.80)


			
	

** Cross sectional

* One-sample mean: Mean of 5.5 vs. X value of 6, with a range s of 1.4(0.2)1,8  
power onemean 5.5 6, power(0.8 0.9) sd(1.4 1.6 1.8) onesided 		// Sample size
power onemean 5.5 6, n(200) sd(1.4 1.6 1.8) onesided				// Power
power onemean 5.5, n(50) power(0.8 0.9) sd(1.4 1.6 1.8) onesided	// Effect size or Minimal detectale difference
power onemean 5.5 6, power(0.8 0.85 0.9) sd(1.4 1.6 1.8) onesided graph 		// Sample size
	
power onemean 5.5 6, power(0.8 0.85 0.9) sd(1.4 1.6 1.8) onesided																					/// Gráfico
	graph(legend(on pos(4) cols(1) title("Desviación Estandard ({&sigma})")																			///
	ring(0) region(style(none))) graphregion(color(white))																							///
	title("Muestra para estimar una Media de una Población") 																						///
	subtitle("Prueba {it:t} {txt}{bind:H{sub:0}: {&mu} = {&mu}{sub:0}}  {txt}versus  {bind:H{sub:a}: {&mu} > {&mu}{sub:0}}") 						///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:{&mu}{sub:0}} = {res:5.5}{txt:,} {txt:{&mu}{sub:a}} = {res:6}")					///
	ytitle("Tamaño de muestra (N)")  																												///
	xtitle("Poder de Estudio (1-{&beta})"))

* One-sample mean: Mean of 5.5 vs. X value of 6, with a range s of 1.4(0.2)1,8  
power twomeans 0, sd(0.18 0.2 0.24) power(0.8 0.9) n1(5) n2(15)	// Effect size
power twomeans 7.0 5.2, sd1(1.8) sd2(2.2) power(0.8 0.9)		// sample
sampsi 93 98, p(0.9) r(0.787) sd1(4.5) sd2(4.5)	// Sample size
sampsi 93 94, n1(61) n2(48) sd1(4.5) sd2(4.5)	// Power

power twomeans 7.0 5.2, sd1(1.8) sd2(2.2) power(0.8 0.85 0.9) graph		// sample

power twomeans 0, sd(0.18 0.2 0.24) power(0.8 0.85 0.9) n1(5) n2(15)																				/// Gráfico
	graph(legend(on pos(4) cols(1) title("Desviación Estandard Común ({&sigma})")																	///
	ring(0) region(style(none))) graphregion(color(white))																							///
	title("Muestra para estimar una Media de una Población") 																						///
	subtitle("Prueba {it:t} {txt}{bind:H{sub:0}: {&mu} = {&mu}{sub:0}}  {txt}versus  {bind:H{sub:a}: {&mu} > {&mu}{sub:0}}") 						///
	note("{txt:Parámetros:} {txt:{&alpha}} = {res:.05}{txt:,} {txt:{&mu}{sub:0}} = {res:5.5}{txt:,} {txt:{&mu}{sub:a}} = {res:6}")					///
	ytitle("Tamaño de muestra (N)")  																												///	
	xtitle("Poder de Estudio (1-{&beta})"))


