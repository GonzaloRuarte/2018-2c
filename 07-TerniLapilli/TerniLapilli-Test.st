!classDefinition: #TerniLapilliTest category: #'TerniLapilli-Test'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-Test'!

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 02:31:21'!
test01

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	self assert: (terniLapilli noXTokensPlaced).
	self assert: (terniLapilli noOTokensPlaced).
	self assert: (terniLapilli xPlacesNext)
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 02:31:59'!
test03

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@1.
	
	self deny: (terniLapilli isVacant: 1@1). 
	self deny: (terniLapilli noXTokensPlaced).
	self assert: (terniLapilli noOTokensPlaced).
	self assert: (terniLapilli oPlacesNext)! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 02:32:22'!
test04

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@1.
	self should:  [terniLapilli placeTokenAt: 1@1.] raise: Error withExceptionDo: 
	[:anException|
		self deny: (terniLapilli isOTokenAt: 1@1). 
		self assert: (terniLapilli isXTokenAt: 1@1).
		self deny: (terniLapilli noXTokensPlaced).
		self assert: (terniLapilli noOTokensPlaced).
		self assert: (terniLapilli oPlacesNext)]
	description: TerniLapilli OccupiedPositionErrorDescription ! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 02:32:31'!
test05

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	

	self should:  [terniLapilli placeTokenAt: 1@2.] raise: Error withExceptionDo: 
	[:anException|
		self assert: (terniLapilli isVacant: 1@2).
		self assert: (terniLapilli noXTokensPlaced).
		self assert: (terniLapilli noOTokensPlaced).
		self assert: (terniLapilli xPlacesNext)]
	description: TerniLapilli OutOfBoundsErrorDescription ! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 02:32:37'!
test06

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 0@1.
	
	self deny: (terniLapilli isVacant: 1@1). 
	self deny: (terniLapilli isVacant: 0@1). 
	self deny: (terniLapilli noXTokensPlaced).
	self deny: (terniLapilli noOTokensPlaced).
	self assert: (terniLapilli xPlacesNext)! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 02:32:55'!
test07

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 0@1.
	terniLapilli placeTokenAt: 1@0.
	terniLapilli placeTokenAt: 0@0.
	terniLapilli placeTokenAt: 0@-1.
	terniLapilli placeTokenAt: 1@-1.
	self should:[terniLapilli placeTokenAt: -1@-1]
	raise: Error
	withExceptionDo:[:anException|
		self assert: (terniLapilli isVacant: -1@-1).
		self deny: (terniLapilli noXTokensPlaced).
		self deny: (terniLapilli noOTokensPlaced).
		self assert: (terniLapilli xMovesNext)]
	description: TerniLapilli TokenPositioningTimeOutErrorDescription 
	
	! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 02:37:03'!
test08

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 0@1.
	terniLapilli placeTokenAt: 1@0.
	terniLapilli placeTokenAt: 0@0.
	terniLapilli placeTokenAt: 1@-1.
	self assert: (terniLapilli winner = 'X'). 
	self deny: (terniLapilli noXTokensPlaced).
	self deny: (terniLapilli noOTokensPlaced).
	self assert:(terniLapilli isFinished).! !

!TerniLapilliTest methodsFor: 'tests' stamp: 'GR 11/2/2018 02:37:10'!
test09

	|terniLapilli|
	
	terniLapilli := TerniLapilli new.
	
	terniLapilli placeTokenAt: 1@1.
	terniLapilli placeTokenAt: 0@1.
	terniLapilli placeTokenAt: 1@0.
	terniLapilli placeTokenAt: 0@0.
	terniLapilli placeTokenAt: 1@-1.
	self should:[terniLapilli placeTokenAt: 0@-1]
	raise: Error
	withExceptionDo:[:anException|
		self assert: (terniLapilli isVacant: 0@-1). 
		self deny: (terniLapilli noXTokensPlaced).
		self deny: (terniLapilli noOTokensPlaced).
		self assert:(terniLapilli isFinished)].
			"aca iria error de no se puede poner una ficha si ya gano alguien, notar que al momento de poner una pieza solo pudo haber ganado X"
	
	! !
