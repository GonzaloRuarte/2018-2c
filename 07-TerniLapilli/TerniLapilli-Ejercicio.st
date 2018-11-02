!classDefinition: #EstadoTablero category: #'TerniLapilli-Ejercicio'!
Object subclass: #EstadoTablero
	instanceVariableNames: 'tablero'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!EstadoTablero methodsFor: 'as yet unclassified' stamp: 'APç 11/1/2018 19:59:33'!
initializeWith: aTablero

	tablero:= aTablero .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstadoTablero class' category: #'TerniLapilli-Ejercicio'!
EstadoTablero class
	instanceVariableNames: ''!

!EstadoTablero class methodsFor: 'as yet unclassified' stamp: 'APç 11/1/2018 20:00:10'!
for: aTablero

	^self new initializeWith: aTablero .! !

!EstadoTablero class methodsFor: 'as yet unclassified' stamp: 'APç 11/1/2018 20:55:21'!
for: aTablero with: aNumber

	|estado|
	
	estado := self subclasses detect: [:aSubclass| aSubclass isFor: aNumber].
	
	^estado new initializeWith: aTablero.! !


!classDefinition: #JuegaO category: #'TerniLapilli-Ejercicio'!
EstadoTablero subclass: #JuegaO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'JuegaO class' category: #'TerniLapilli-Ejercicio'!
JuegaO class
	instanceVariableNames: ''!

!JuegaO class methodsFor: 'as yet unclassified' stamp: 'APç 11/1/2018 20:56:24'!
isFor: aNumber

	^false! !


!classDefinition: #JuegaX category: #'TerniLapilli-Ejercicio'!
EstadoTablero subclass: #JuegaX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'JuegaX class' category: #'TerniLapilli-Ejercicio'!
JuegaX class
	instanceVariableNames: ''!

!JuegaX class methodsFor: 'as yet unclassified' stamp: 'APç 11/1/2018 20:56:04'!
isFor: aNumber

	^aNumber = 3! !


!classDefinition: #PoneO category: #'TerniLapilli-Ejercicio'!
EstadoTablero subclass: #PoneO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!PoneO methodsFor: 'as yet unclassified' stamp: 'APç 11/1/2018 20:57:18'!
ponerFichaEn: aPoint
	
	tablero ponerFichaOEn: aPoint.
	tablero amIReadyToPlay .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PoneO class' category: #'TerniLapilli-Ejercicio'!
PoneO class
	instanceVariableNames: ''!

!PoneO class methodsFor: 'as yet unclassified' stamp: 'APç 11/1/2018 20:56:31'!
isFor: aNumber

	^false! !


!classDefinition: #PoneX category: #'TerniLapilli-Ejercicio'!
EstadoTablero subclass: #PoneX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!PoneX methodsFor: 'as yet unclassified' stamp: 'APç 11/1/2018 20:24:33'!
ponerFichaEn: aPoint
	
	tablero ponerFichaXEn: aPoint.
	tablero cambiarA: (PoneO for: tablero).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PoneX class' category: #'TerniLapilli-Ejercicio'!
PoneX class
	instanceVariableNames: ''!

!PoneX class methodsFor: 'as yet unclassified' stamp: 'APç 11/1/2018 20:56:56'!
isFor: aNumber

	^aNumber < 3! !


!classDefinition: #Tablero category: #'TerniLapilli-Ejercicio'!
Object subclass: #Tablero
	instanceVariableNames: 'fichasX fichasO estado'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Ejercicio'!

!Tablero methodsFor: 'xxxx' stamp: 'APç 11/1/2018 20:53:19'!
amIReadyToPlay

	
	
	self cambiarA: (EstadoTablero for: self with: fichasX size)! !

!Tablero methodsFor: 'xxxx' stamp: 'APç 11/1/2018 20:08:39'!
cambiarA: aEstado

	estado := aEstado! !

!Tablero methodsFor: 'xxxx' stamp: 'APç 11/1/2018 20:32:56'!
estaOcupada: aPoint

	^(self estaVacia: aPoint)  not.! !

!Tablero methodsFor: 'xxxx' stamp: 'APç 11/1/2018 19:47:36'!
estaVacia: aPoint 
	((fichasX includes: aPoint) or: [ fichasO  includes: aPoint ]) ifTrue:[^false].
	^true! !

!Tablero methodsFor: 'xxxx' stamp: 'APç 11/1/2018 19:42:00'!
hayFichaDeOEn: aPoint

	^fichasO includes: aPoint.	

	! !

!Tablero methodsFor: 'xxxx' stamp: 'APç 11/1/2018 19:42:06'!
hayFichaDeXEn: aPoint

	^fichasX includes: aPoint.	

	! !

!Tablero methodsFor: 'xxxx' stamp: 'APç 11/1/2018 20:04:35'!
initialize
	fichasX := Set new.
	fichasO:= Set new.
	
	estado:=PoneX for: self.! !

!Tablero methodsFor: 'xxxx' stamp: 'APç 11/1/2018 20:12:19'!
listoParaJugar

	^fichasX size = 3 and: [ fichasO size = 3]! !

!Tablero methodsFor: 'xxxx' stamp: 'APç 11/1/2018 20:24:17'!
ponerEn: aPoint 

	estado ponerFichaEn: aPoint .! !

!Tablero methodsFor: 'xxxx' stamp: 'APç 11/1/2018 20:32:28'!
ponerFichaEn: aPoint in: set.

	 (aPoint x abs > 1 or:[aPoint y abs > 1 ] or: [self estaOcupada: aPoint] )  ifFalse: [set add: aPoint].
   ! !

!Tablero methodsFor: 'xxxx' stamp: 'APç 11/1/2018 20:28:07'!
ponerFichaOEn: aPoint 

	self ponerFichaEn: aPoint in: fichasO.
   ! !

!Tablero methodsFor: 'xxxx' stamp: 'APç 11/1/2018 20:27:34'!
ponerFichaXEn: aPoint 

	self ponerFichaEn: aPoint in: fichasX.
   ! !
