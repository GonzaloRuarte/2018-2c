!classDefinition: #TerniLapilliConsoleTest category: #'TerniLapilli-ConsoleTest'!
TestCase subclass: #TerniLapilliConsoleTest
	instanceVariableNames: 'game console'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-ConsoleTest'!

!TerniLapilliConsoleTest methodsFor: 'as yet unclassified' stamp: 'APç 11/8/2018 21:59:19'!
test01

	| lines |
	game := TerniLapilli new.
	

	console:= TerniLapilliConsole new.
	
	game addObserver: console.
	
	game putXAt: 2@2.
	lines := console lines.
	
	self assert: 'X marcó en 2@2' equals: (lines at:1).
	self assert: 'Estado: Jugando O' equals: (lines at:2)! !

!TerniLapilliConsoleTest methodsFor: 'as yet unclassified' stamp: 'APç 11/8/2018 21:59:27'!
test02

	| lines |
	game := TerniLapilli new.
	

	console:= TerniLapilliConsole new.
	
	game addObserver: console.
	
	game putXAt: 2@2.
	game putOAt: 1@1.
	
	lines := console lines.
	
	self assert: 'X marcó en 2@2' equals: (lines at:1).
	self assert: 'Estado: Jugando O' equals: (lines at:2).
	self assert: 'O marcó en 1@1' equals: (lines at:3).
	self assert: 'Estado: Jugando X' equals: (lines at:4).
! !

!TerniLapilliConsoleTest methodsFor: 'as yet unclassified' stamp: 'APç 11/8/2018 21:59:31'!
test03

	| lines |
	game := TerniLapilli new.
	

	console:= TerniLapilliConsole new.
	
	game addObserver: console.
	
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@3.
	game putOAt: 1@2.
	game putXAt:  3@1.
	
	lines := console lines.
	
	
	self assert:  'X marcó en 2@2' equals: (lines at:1).
	self assert:  'Estado: Jugando O' equals: (lines at:2).
	self assert:  'O marcó en 1@1' equals: (lines at:3).
	self assert:  'Estado: Jugando X' equals: (lines at:4).
	self assert:  'X marcó en 1@3' equals: (lines at:5).
	self assert:  'Estado: Jugando O' equals: (lines at:6).
	self assert:  'O marcó en 1@2' equals: (lines at:7).
	self assert:  'Estado: Jugando X' equals: (lines at:8).
	self assert:  'X marcó en 3@1' equals: (lines at:9).
	self assert:  'Estado: Juego terminado - ¡Ganó X!!' equals: (lines at:10).

! !

!TerniLapilliConsoleTest methodsFor: 'as yet unclassified' stamp: 'APç 11/8/2018 21:59:35'!
test04

	| lines |
	game := TerniLapilli new.
	

	console:= TerniLapilliConsole new.
	
	game addObserver: console.
	game putXAt: 3@3.
	game putOAt: 2@2.
	game putXAt: 1@1.
	game putOAt: 1@3.
	game putXAt: 1@2.
	game putOAt:  3@1.
	
	lines := console lines.
	
	
	self assert:  'X marcó en 3@3' equals: (lines at:1).
	self assert:  'Estado: Jugando O' equals: (lines at:2).	
	self assert:  'O marcó en 2@2' equals: (lines at:3).
	self assert:  'Estado: Jugando X' equals: (lines at:4).
	self assert:  'X marcó en 1@1' equals: (lines at:5).
	self assert:  'Estado: Jugando O' equals: (lines at:6).
	self assert:  'O marcó en 1@3' equals: (lines at:7).
	self assert:  'Estado: Jugando X' equals: (lines at:8).
	self assert:  'X marcó en 1@2' equals: (lines at:9).
	self assert:  'Estado: Jugando O' equals: (lines at:10).
	self assert:  'O marcó en 3@1' equals: (lines at:11).
	self assert:  'Estado: Juego terminado - ¡Ganó O!!' equals: (lines at:12).

! !

!TerniLapilliConsoleTest methodsFor: 'as yet unclassified' stamp: 'APç 11/8/2018 21:59:38'!
test05a

	| lines |
	game := TerniLapilli new.
	

	console:= TerniLapilliConsole new.
	
	game addObserver: console.
	
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@3.
	game putOAt: 3@1.
	game putXAt:  2@1.
	game putOAt: 2@3.
	game slideXFrom:  1@3  to: 1@2.


	lines := console lines.
	
	
	self assert:  'X marcó en 2@2' equals: (lines at:1).
	self assert:  'Estado: Jugando O' equals: (lines at:2).	
	self assert:  'O marcó en 1@1' equals: (lines at:3).
	self assert:  'Estado: Jugando X' equals: (lines at:4).
	self assert:  'X marcó en 1@3' equals: (lines at:5).
	self assert:  'Estado: Jugando O' equals: (lines at:6).
	self assert:  'O marcó en 3@1' equals: (lines at:7).
	self assert:  'Estado: Jugando X' equals: (lines at:8).
	self assert:  'X marcó en 2@1' equals: (lines at:9).
	self assert:  'Estado: Jugando O' equals: (lines at:10).
	self assert:  'O marcó en 2@3' equals: (lines at:11).
	self assert:  'Estado: Jugando X' equals: (lines at:12).
	self assert:  'X deslizó hasta 1@2 desde 1@3' equals: (lines at:13).
	self assert:  'Estado: Jugando O' equals: (lines at:14).

	

! !

!TerniLapilliConsoleTest methodsFor: 'as yet unclassified' stamp: 'APç 11/8/2018 21:59:42'!
test05b

	| lines |
	game := TerniLapilli new.
	

	console:= TerniLapilliConsole new.
	
	game addObserver: console.

	
	game putXAt: 2@2.
	game putOAt: 1@1.
	game putXAt: 1@3.
	game putOAt: 3@1.
	game putXAt:  2@1.
	game putOAt: 2@3.
	game slideXFrom:  1@3  to: 1@2.
	game slideOFrom:  3@1  to: 3@2.
	game slideXFrom:  2@2  to: 3@3.

	lines := console lines.
	
	
	self assert:  'X marcó en 2@2' equals: (lines at:1).
	self assert:  'Estado: Jugando O' equals: (lines at:2).	
	self assert:  'O marcó en 1@1' equals: (lines at:3).
	self assert:  'Estado: Jugando X' equals: (lines at:4).
	self assert:  'X marcó en 1@3' equals: (lines at:5).
	self assert:  'Estado: Jugando O' equals: (lines at:6).
	self assert:  'O marcó en 3@1' equals: (lines at:7).
	self assert:  'Estado: Jugando X' equals: (lines at:8).
	self assert:  'X marcó en 2@1' equals: (lines at:9).
	self assert:  'Estado: Jugando O' equals: (lines at:10).
	self assert:  'O marcó en 2@3' equals: (lines at:11).
	self assert:  'Estado: Jugando X' equals: (lines at:12).
	self assert:  'X deslizó hasta 1@2 desde 1@3' equals: (lines at:13).
	self assert:  'Estado: Jugando O' equals: (lines at:14).
	self assert:  'O deslizó hasta 3@2 desde 3@1' equals: (lines at:15).
	self assert:  'Estado: Jugando X' equals: (lines at:16).
	self assert:  'X deslizó hasta 3@3 desde 2@2' equals: (lines at:17).
	self assert:  'Estado: Jugando O' equals: (lines at:18).
	

! !
