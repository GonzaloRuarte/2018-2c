!classDefinition: #TerniLapilliConsoleTest category: #'TerniLapilli-ConsoleTest'!
TestCase subclass: #TerniLapilliConsoleTest
	instanceVariableNames: 'game console viewer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TerniLapilli-ConsoleTest'!

!TerniLapilliConsoleTest methodsFor: 'assertions' stamp: 'GR 11/12/2018 11:44:35'!
assertXSlideProperlyLoggedOn: aConsoleLog
	self skip: 12 linesOn: aConsoleLog.
	self assert:  'X deslizó hasta 2@3 desde 2@2' equals: aConsoleLog nextLine.
	self assert:  'Estado: Jugando O' equals: aConsoleLog nextLine.! !


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

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/12/2018 11:41:44'!
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
	
	self skip: 10 linesOn: lines.
	self assert:  'O marcó en 3@1' equals: lines nextLine.
	self assert:  'Estado: Juego terminado - ¡Ganó O!!' equals: lines nextLine.

! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/12/2018 11:35:53'!
test05ConsoleShouldLogXSlide

	| lines |
	game := TerniLapilli new.
	

	console:= TerniLapilliConsole new.
	
	game addObserver: console.
	
	self allTokensPlacedAndFirstXSlide.


	lines := console lines.

	self assertXSlideProperlyLoggedOn: lines.

	

! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/12/2018 11:34:46'!
test06ConsoleShouldLogOSlide

	| lines |
	game := TerniLapilli new.
	

	console:= TerniLapilliConsole new.
	
	game addObserver: console.

	self allTokensPlacedAndFirstXSlide.
	game slideOFrom: 1@2 to: 2@2. 

	lines := console lines.
	
	self assertXSlideProperlyLoggedOn: lines.
	self assert:  'O deslizó hasta 2@2 desde 1@2' equals: lines nextLine.
	self assert:  'Estado: Jugando X' equals: lines nextLine.
	

! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/12/2018 11:10:05'!
test07InitialViewerShouldBeEmpty

	game := TerniLapilli new.
	

	viewer:= TerniLapilliViewer new.
	
	game putXAt: 2@2.

	
	game addObserver: viewer.
	self assert:
' | | 
-----
 | | 
-----
 | | ' equals: viewer displayBoard.! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/12/2018 11:11:32'!
test08ViewerShouldDisplayXPlacement

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

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/12/2018 11:10:22'!
test09ViewerShouldDisplayOPlacement

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

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/12/2018 11:11:09'!
test10ViewerShouldDisplayProperStateWhenXWins

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

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/12/2018 11:11:00'!
test11ViewerShouldDisplayProperStateWhenOWins

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

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/12/2018 11:23:56'!
test12ViewerShouldDisplayXSlide

	game := TerniLapilli new.
	

	viewer:= TerniLapilliViewer new.
	
	game addObserver: viewer.
	
	self allTokensPlacedAndFirstXSlide.

	self assert:
' |X|X
-----
O| |X
-----
 |O|O
Playing O' equals: viewer displayBoard.! !

!TerniLapilliConsoleTest methodsFor: 'testing' stamp: 'GR 11/12/2018 11:23:51'!
test13ViewerShouldDisplayOSlide

	game := TerniLapilli new.
	

	viewer:= TerniLapilliViewer new.
	
	game addObserver: viewer.
	
	self allTokensPlacedAndFirstXSlide.
	game slideOFrom: 1@2 to: 2@2. 

	self assert:
' |X|X
-----
 |O|X
-----
 |O|O
Playing X' equals: viewer displayBoard.! !


!TerniLapilliConsoleTest methodsFor: 'setup' stamp: 'GR 11/12/2018 11:24:41'!
allTokensPlacedAndFirstXSlide
	
	game putXAt: 2@2;
			putOAt: 3@1;
			putXAt: 3@3;
			putOAt: 2@1;
			putXAt: 3@2;
			putOAt: 1@2;			
			slideXFrom: 2@2 to: 2@3.! !

!TerniLapilliConsoleTest methodsFor: 'setup' stamp: 'GR 11/12/2018 11:48:20'!
skip: anAmountToSkip linesOn: aConsoleLog
	
	1 to: anAmountToSkip do: [:anArgument | aConsoleLog nextLine].! !
