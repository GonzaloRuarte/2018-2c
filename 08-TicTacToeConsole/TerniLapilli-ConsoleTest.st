!classDefinition: #TerniLapilliConsoleTest category: #'TerniLapilli-ConsoleTest'!
TestCase subclass: #TerniLapilliConsoleTest
	instanceVariableNames: 'game console viewer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-ConsoleTest'!

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/10/2018 16:15:13'!
test01ConsoleShouldLogXPlacement

	| lines |
	game := TerniLapilli new.
	

	console:= TerniLapilliConsole new.
	
	game addObserver: console.
	
	game putXAt: 2@2.
	lines := console lines.
	
	self assert: 'X marcó en 2@2' equals: lines nextLine.
	self assert: 'Estado: Jugando O' equals: lines nextLine.! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/10/2018 16:15:30'!
test02ConsoleShouldLogOPlacement

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

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/10/2018 16:16:17'!
test03ConsoleShouldLogWhenXWins

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

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/10/2018 16:16:34'!
test04ConsoleShouldLogWhenOWins

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

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/10/2018 16:17:25'!
test05ConsoleShouldLogXSlide

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

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/10/2018 16:17:38'!
test06ConsoleShouldLogOSlide

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

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/10/2018 16:27:47'!
test07ViewerShouldDisplayXPlacement

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
Playing O' equals: viewer displayBoard.! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/10/2018 16:27:49'!
test08ViewerShouldDisplayOPlacement

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
Playing X' equals: viewer displayBoard.! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/10/2018 16:27:52'!
test09ViewerShouldDisplayProperStateWhenXWins

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
X Won!!' equals: viewer displayBoard.! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/10/2018 16:27:55'!
test10ViewerShouldDisplayProperStateWhenOWins

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
O Won!!' equals: viewer displayBoard.! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/10/2018 16:27:59'!
test11ViewerShouldDisplayXSlide

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
Playing O' equals: viewer displayBoard.! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/10/2018 16:28:02'!
test12ViewerShouldDisplayOSlide

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
Playing X' equals: viewer displayBoard.! !
