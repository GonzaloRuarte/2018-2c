!classDefinition: #TerniLapilliConsoleTest category: #'TerniLapilli-ConsoleTest'!
TestCase subclass: #TerniLapilliConsoleTest
	instanceVariableNames: 'game console viewer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-ConsoleTest'!

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/9/2018 00:26:48'!
test01

	| lines |
	game := TerniLapilli new.
	

	console:= TerniLapilliConsole new.
	
	game addObserver: console.
	
	game putXAt: 2@2.
	lines := console lines.
	
	self assert: 'X marcó en 2@2' equals: lines nextLine.
	self assert: 'Estado: Jugando O' equals: lines nextLine.! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/9/2018 00:42:25'!
test02

	| lines |
	game := TerniLapilli new.
	

	console:= TerniLapilliConsole new.
	
	game addObserver: console.
	
	game putXAt: 2@2.
	game putOAt: 1@1.
	
	lines := console lines.
	
	self assert: 'X marcó en 2@2' equals: lines nextLine.
	self assert: 'Estado: Jugando O' equals: lines nextLine.
	self assert: 'O marcó en 1@1' equals: lines nextLine.
	self assert: 'Estado: Jugando X' equals: lines nextLine.
! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/9/2018 00:42:53'!
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
	
	
	self assert:  'X marcó en 2@2' equals: lines nextLine.
	self assert:  'Estado: Jugando O' equals: lines nextLine.
	self assert:  'O marcó en 1@1' equals: lines nextLine.
	self assert:  'Estado: Jugando X' equals: lines nextLine.
	self assert:  'X marcó en 1@3' equals: lines nextLine.
	self assert:  'Estado: Jugando O' equals: lines nextLine.
	self assert:  'O marcó en 1@2' equals: lines nextLine.
	self assert:  'Estado: Jugando X' equals: lines nextLine.
	self assert:  'X marcó en 3@1' equals: lines nextLine.
	self assert:  'Estado: Juego terminado - ¡Ganó X!!' equals: lines nextLine.

! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/9/2018 00:43:15'!
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
	
	
	self assert:  'X marcó en 3@3' equals: lines nextLine.
	self assert:  'Estado: Jugando O' equals: lines nextLine.
	self assert:  'O marcó en 2@2' equals: lines nextLine.
	self assert:  'Estado: Jugando X' equals: lines nextLine.
	self assert:  'X marcó en 1@1' equals: lines nextLine.
	self assert:  'Estado: Jugando O' equals: lines nextLine.
	self assert:  'O marcó en 1@3' equals: lines nextLine.
	self assert:  'Estado: Jugando X' equals: lines nextLine.
	self assert:  'X marcó en 1@2' equals: lines nextLine.
	self assert:  'Estado: Jugando O' equals: lines nextLine.
	self assert:  'O marcó en 3@1' equals: lines nextLine.
	self assert:  'Estado: Juego terminado - ¡Ganó O!!' equals: lines nextLine.

! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/9/2018 00:43:40'!
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
	
	
	self assert:  'X marcó en 2@2' equals: lines nextLine.
	self assert:  'Estado: Jugando O' equals: lines nextLine.
	self assert:  'O marcó en 1@1' equals: lines nextLine.
	self assert:  'Estado: Jugando X' equals: lines nextLine.
	self assert:  'X marcó en 1@3' equals: lines nextLine.
	self assert:  'Estado: Jugando O' equals: lines nextLine.
	self assert:  'O marcó en 3@1' equals: lines nextLine.
	self assert:  'Estado: Jugando X' equals: lines nextLine.
	self assert:  'X marcó en 2@1' equals: lines nextLine.
	self assert:  'Estado: Jugando O' equals: lines nextLine.
	self assert:  'O marcó en 2@3' equals: lines nextLine.
	self assert:  'Estado: Jugando X' equals: lines nextLine.
	self assert:  'X deslizó hasta 1@2 desde 1@3' equals: lines nextLine.
	self assert:  'Estado: Jugando O' equals: lines nextLine.

	

! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/9/2018 00:44:11'!
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
	
	
	self assert:  'X marcó en 2@2' equals: lines nextLine.
	self assert:  'Estado: Jugando O' equals: lines nextLine.
	self assert:  'O marcó en 1@1' equals: lines nextLine.
	self assert:  'Estado: Jugando X' equals: lines nextLine.
	self assert:  'X marcó en 1@3' equals: lines nextLine.
	self assert:  'Estado: Jugando O' equals: lines nextLine.
	self assert:  'O marcó en 3@1' equals: lines nextLine.
	self assert:  'Estado: Jugando X' equals: lines nextLine.
	self assert:  'X marcó en 2@1' equals: lines nextLine.
	self assert:  'Estado: Jugando O' equals: lines nextLine.
	self assert:  'O marcó en 2@3' equals: lines nextLine.
	self assert:  'Estado: Jugando X' equals: lines nextLine.
	self assert:  'X deslizó hasta 1@2 desde 1@3' equals: lines nextLine.
	self assert:  'Estado: Jugando O' equals: lines nextLine.
	self assert:  'O deslizó hasta 3@2 desde 3@1' equals: lines nextLine.
	self assert:  'Estado: Jugando X' equals: lines nextLine.
	self assert:  'X deslizó hasta 3@3 desde 2@2' equals: lines nextLine.
	self assert:  'Estado: Jugando O' equals: lines nextLine.
	

! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/9/2018 21:23:09'!
test07

	game := TerniLapilli new.
	

	viewer:= TerniLapilliViewer new.
	
	game addObserver: viewer.
	
	game putXAt: 2@2.
	
	self assert:
' | | 
-----
 |X| 
-----
 | | 
Playing O' equals: viewer contents.! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/9/2018 21:33:41'!
test08

	game := TerniLapilli new.
	

	viewer:= TerniLapilliViewer new.
	
	game addObserver: viewer.
	
	game putXAt: 2@2;
			putOAt: 3@1.

	self assert:
' | | 
-----
 |X| 
-----
 | |O
Playing X' equals: viewer contents.! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/9/2018 21:42:15'!
test09

	game := TerniLapilli new.
	

	viewer:= TerniLapilliViewer new.
	
	game addObserver: viewer.
	
	game putXAt: 2@2;
			putOAt: 3@1;
			putXAt: 3@3;
			putOAt: 1@2;
			putXAt: 1@1.

	self assert:
' | |X
-----
O|X| 
-----
X| |O
X Won!!' equals: viewer contents.! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/9/2018 21:42:10'!
test10

	game := TerniLapilli new.
	

	viewer:= TerniLapilliViewer new.
	
	game addObserver: viewer.
	
	game putXAt: 2@2;
			putOAt: 3@1;
			putXAt: 3@3;
			putOAt: 2@1;
			putXAt: 3@2;
			putOAt: 1@1.

	self assert:
' | |X
-----
 |X|X
-----
O|O|O
O Won!!' equals: viewer contents.! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/9/2018 21:45:59'!
test11

	game := TerniLapilli new.
	

	viewer:= TerniLapilliViewer new.
	
	game addObserver: viewer.
	
	game putXAt: 2@2;
			putOAt: 3@1;
			putXAt: 3@3;
			putOAt: 2@1;
			putXAt: 3@2;
			putOAt: 1@2;
			slideXFrom: 2@2 to: 2@3. 

	self assert:
' |X|X
-----
O| |X
-----
 |O|O
Playing O' equals: viewer contents.! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/9/2018 21:46:42'!
test12

	game := TerniLapilli new.
	

	viewer:= TerniLapilliViewer new.
	
	game addObserver: viewer.
	
	game putXAt: 2@2;
			putOAt: 3@1;
			putXAt: 3@3;
			putOAt: 2@1;
			putXAt: 3@2;
			putOAt: 1@2;
			slideXFrom: 2@2 to: 2@3;
			slideOFrom: 1@2 to: 2@2. 

	self assert:
' |X|X
-----
 |O|X
-----
 |O|O
Playing X' equals: viewer contents.! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/9/2018 21:49:35'!
test13

	game := TerniLapilli new.
	

	viewer:= TerniLapilliViewer new.
	
	game addObserver: viewer.
	
	game putXAt: 3@1;
			putOAt: 3@3;
			putXAt: 2@1;
			putOAt: 3@2;
			putXAt: 1@2;
			putOAt: 2@2;
			slideXFrom: 1@2 to: 1@1.

	self assert:
' | |O
-----
 |O|O
-----
X|X|X
X Won!!' equals: viewer contents.! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/9/2018 21:49:58'!
test14

	game := TerniLapilli new.
	

	viewer:= TerniLapilliViewer new.
	
	game addObserver: viewer.
	
	game putXAt: 2@2;
			putOAt: 3@1;
			putXAt: 3@3;
			putOAt: 2@1;
			putXAt: 3@2;
			putOAt: 1@2;
			slideXFrom: 2@2 to: 2@3;
			slideOFrom: 1@2 to: 1@1. 

	self assert:
' |X|X
-----
 | |X
-----
O|O|O
O Won!!' equals: viewer contents.! !
