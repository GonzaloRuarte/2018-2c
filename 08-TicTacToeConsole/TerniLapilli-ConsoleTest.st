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

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/9/2018 03:06:06'!
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

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/9/2018 11:51:34'!
test08

	game := TerniLapilli new.
	

	viewer:= TerniLapilliViewer new.
	
	game addObserver: viewer.
	
	game putXAt: 2@2;
			putOAt: 3@1.

	self assert:
'O| | 
-----
 |X| 
-----
 | | 
Playing O' equals: viewer contents.! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/9/2018 11:59:23'!
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
'O| |X
-----
O|X| 
-----
X| | 
X Won' equals: viewer contents.! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/9/2018 11:59:19'!
test10

	game := TerniLapilli new.
	

	viewer:= TerniLapilliViewer new.
	
	game addObserver: viewer.
	
	game putXAt: 2@2;
			putOAt: 3@1;
			putXAt: 3@3;
			putOAt: 1@2;
			putXAt: 2@1;
			putOAt: 1@1.

	self assert:
'O| |X
-----
O|X| 
-----
O|X| 
O Won' equals: viewer contents.! !
