!classDefinition: #TerniLapilliTest category: #'TerniLapilli-Test'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Test'!

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'APç 11/1/2018 19:24:33'!
test01

	|tablero|
	
	tablero:= Tablero new.
	
	self assert: (tablero estaVacia: 1@1). ! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'APç 11/1/2018 20:28:56'!
test03

	|tablero|
	
	tablero:= Tablero new.
	
	tablero ponerEn: 1@1	.
	
	self deny: (tablero estaVacia: 1@1). ! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'APç 11/1/2018 20:29:00'!
test04

	|tablero|
	
	tablero:= Tablero new.
	
	tablero ponerEn: 1@1.
	tablero ponerEn: 1@1.
	
	self deny: (tablero hayFichaDeOEn: 1@1). 
	self assert: (tablero hayFichaDeXEn: 1@1). ! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'APç 11/1/2018 20:29:05'!
test05

	|tablero|
	
	tablero:= Tablero new.
	
	tablero ponerEn: 1@2.
	tablero ponerEn: 2@1.
	
	self assert: (tablero estaVacia: 2@1). 
	self assert: (tablero estaVacia: 1@2). ! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'APç 11/1/2018 20:29:13'!
test06

	|tablero|
	
	tablero:= Tablero new.
	
	tablero ponerEn: 1@1.
	tablero ponerEn: 0@1.
	
	self deny: (tablero estaVacia: 1@1). 
	self deny: (tablero estaVacia: 0@1). ! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'APç 11/1/2018 20:59:39'!
test07

	|tablero|
	
	tablero:= Tablero new.
	
	tablero ponerEn: 1@1.
	tablero ponerEn: 0@1.
	tablero ponerEn: -1@1.
	tablero ponerEn: 0@-1.
	tablero ponerEn: -1@-1.
	tablero ponerEn: 1@-1.
	[tablero ponerEn: 1@0.
		self fail]
	on: MessageNotUnderstood 
	do:[self assert: (tablero estaVacia: 1@0). ].
	
	! !
