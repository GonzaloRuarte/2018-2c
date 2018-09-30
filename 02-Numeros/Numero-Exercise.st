!classDefinition: #NumeroTest category: #'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:26'!
test27EnteroSubstractsEnteroCorrectly

	self assert: two - one equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: #'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: #'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:45'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:47'!
invalidNumberTypeErrorDescription
	^ 'Tipo de numero invalido'! !


!classDefinition: #Entero category: #'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:08:01'!
* aMultiplier 
	
	self subclassResponsibility
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:07:35'!
+ anAdder 
	
	self subclassResponsibility! !

!Entero methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:08:28'!
- aSubtrahend 
	
	self subclassResponsibility! !

!Entero methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:25:09'!
/ aDivisor 
	
	self subclassResponsibility ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:16:19'!
// aDivisor 
	
	self subclassResponsibility! !

!Entero methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:32:42'!
addTheFraction: anAdder 
	
	self subclassResponsibility ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:38:03'!
addTheInteger: anAdder 
	
	self subclassResponsibility ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:42:19'!
divideTheFraction: aDivisor 
	
	self subclassResponsibility ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:44:05'!
divideTheInteger: aDivisor 
	
	self subclassResponsibility ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'ap 9/27/2018 23:29:02'!
fibonacci

	self subclassResponsibility 
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'GR 9/27/2018 23:51:19'!
greatestCommonDivisorWith: anEntero 
	
	self subclassResponsibility! !

!Entero methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:48:46'!
multiplyTheFraction: aMultiplier 
	
	self subclassResponsibility 
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:49:37'!
multiplyTheInteger: aMultiplier 
	
	self subclassResponsibility 
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:52:59'!
substractTheFraction: aSubtrahend 
	
	self subclassResponsibility ! !

!Entero methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:53:55'!
substractTheInteger: aSubtrahend 
	
	self subclassResponsibility ! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'GR 9/27/2018 23:39:07'!
initalizeWith: aValue 
	
	self subclassResponsibility! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'GR 9/27/2018 23:44:46'!
isNegative
	
	self subclassResponsibility ! !

!Entero methodsFor: 'testing' stamp: 'GR 9/27/2018 23:45:58'!
isOne
	
	self subclassResponsibility ! !

!Entero methodsFor: 'testing' stamp: 'GR 9/27/2018 23:46:01'!
isZero
	
	self subclassResponsibility ! !

!Entero methodsFor: 'testing' stamp: 'GR 9/28/2018 01:02:40'!
shouldNotBeOne

	self subclassResponsibility ! !

!Entero methodsFor: 'testing' stamp: 'GR 9/28/2018 01:01:14'!
shouldNotBeZero

	self subclassResponsibility ! !

!Entero methodsFor: 'testing' stamp: 'GR 9/29/2018 18:18:55'!
shouldNotDivideIfZero

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 9/23/2018 22:17:16'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no est?definido aqu?para enteros negativos'! !

!Entero class methodsFor: 'instance creation' stamp: 'GR 9/28/2018 16:56:46'!
with: aValue 
	
	|distinci?DeEntero|
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	distinci?DeEntero:=self subclasses detect:[:subclass | subclass isFor: aValue].
	
	^distinci?DeEntero new initalizeWith: aValue! !


!classDefinition: #Cero category: #'Numero-Exercise'!
Entero subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'arithmetic operations' stamp: 'GR 9/27/2018 23:34:24'!
* aMultiplier 
	
	^self! !

!Cero methodsFor: 'arithmetic operations' stamp: 'GR 9/27/2018 23:34:48'!
+ anAdder 
	
	^anAdder! !

!Cero methodsFor: 'arithmetic operations' stamp: 'GR 9/27/2018 23:54:22'!
- aSubtrahend 
	
	^ aSubtrahend negated.! !

!Cero methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:28:48'!
/ aDivisor 
	
	^aDivisor divideTheInteger: self! !

!Cero methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:16:05'!
// aDivisor 
	
	^self.! !

!Cero methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:33:10'!
addTheFraction: anAdder 
	
	^anAdder! !

!Cero methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:39:52'!
addTheInteger: anAdder 
	
	^anAdder! !

!Cero methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:43:42'!
divideTheFraction: aDivisor 
	
	self error: Entero canNotDivideByZeroErrorDescription! !

!Cero methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:44:47'!
divideTheInteger: aDivisor 
	
	self error: Entero canNotDivideByZeroErrorDescription! !

!Cero methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:22:19'!
fibonacci
	
	^Entero with: 1.
! !

!Cero methodsFor: 'arithmetic operations' stamp: 'GR 9/27/2018 23:51:57'!
greatestCommonDivisorWith: anEntero 
	
	^anEntero! !

!Cero methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:49:02'!
multiplyTheFraction: aMultiplier 
	
	^self! !

!Cero methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:49:51'!
multiplyTheInteger: aMultiplier 
	
	^self! !

!Cero methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:51:41'!
substractTheFraction: aSubtrahend 
	
	^aSubtrahend ! !

!Cero methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:54:07'!
substractTheInteger: aSubtrahend 
	
	^aSubtrahend ! !


!Cero methodsFor: 'testing' stamp: 'GR 9/27/2018 23:45:42'!
isNegative

	^false! !

!Cero methodsFor: 'testing' stamp: 'GR 9/27/2018 23:46:31'!
isOne

	^false! !

!Cero methodsFor: 'testing' stamp: 'GR 9/27/2018 23:46:23'!
isZero

	^true! !

!Cero methodsFor: 'testing' stamp: 'GR 9/28/2018 01:02:54'!
shouldNotBeOne! !

!Cero methodsFor: 'testing' stamp: 'GR 9/28/2018 01:00:44'!
shouldNotBeZero

	self error: 'una fraccion no puede ser cero' ! !

!Cero methodsFor: 'testing' stamp: 'GR 9/29/2018 18:18:55'!
shouldNotDivideIfZero

	self error: Entero canNotDivideByZeroErrorDescription! !


!Cero methodsFor: 'initialization' stamp: 'GR 9/27/2018 23:43:35'!
initalizeWith: aValue 
	
	value:=0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cero class' category: #'Numero-Exercise'!
Cero class
	instanceVariableNames: ''!

!Cero class methodsFor: 'as yet unclassified' stamp: 'ap 9/27/2018 23:27:53'!
isFor: aValue

	^0=aValue! !


!classDefinition: #MayoresAUno category: #'Numero-Exercise'!
Entero subclass: #MayoresAUno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!MayoresAUno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:02:25'!
* aMultiplier 
	
	^aMultiplier multiplyTheInteger: self.! !

!MayoresAUno methodsFor: 'arithmetic operations' stamp: 'GR 9/27/2018 23:48:42'!
+ anAdder 
	
	^anAdder addTheInteger: self! !

!MayoresAUno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:09:54'!
- aSubtrahend

^ aSubtrahend substractTheInteger: self.! !

!MayoresAUno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:24:52'!
/ aDivisor 
	
	^aDivisor divideTheInteger: self! !

!MayoresAUno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:23:01'!
// aDivisor 
	
	^Entero with: value // aDivisor integerValue.! !

!MayoresAUno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:32:20'!
addTheFraction: anAdder 
	
	| newNumerator |
	
	newNumerator := (self * anAdder denominator) + (anAdder numerator).
	
	^newNumerator / anAdder denominator ! !

!MayoresAUno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:37:41'!
addTheInteger: anAdder 
	
	^Entero with: value + anAdder integerValue! !

!MayoresAUno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:42:05'!
divideTheFraction: aDivisor 
	
	^ (aDivisor numerator) / (self * aDivisor denominator)! !

!MayoresAUno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:44:09'!
divideTheInteger: aDivisor 
	
	^Fraccion with: aDivisor over: self! !

!MayoresAUno methodsFor: 'arithmetic operations' stamp: 'GR 9/27/2018 23:09:27'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	^ (self - one) fibonacci + (self - two) fibonacci! !

!MayoresAUno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:22:43'!
greatestCommonDivisorWith: anEntero 
	
	^Entero with: (value gcd: anEntero integerValue)! !

!MayoresAUno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:49:09'!
multiplyTheFraction: aMultiplier 
	
	^(self * aMultiplier numerator) / (aMultiplier denominator)! !

!MayoresAUno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 16:34:30'!
multiplyTheInteger: aMultiplier 
	
	^Entero with: value * aMultiplier integerValue! !

!MayoresAUno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:51:45'!
substractTheFraction: aSubtrahend 
	
	| newNumerator |
	
	newNumerator := (aSubtrahend numerator) - (self * aSubtrahend denominator).
	
	^newNumerator / aSubtrahend denominator! !

!MayoresAUno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:54:10'!
substractTheInteger: aSubtrahend 
	
	^Entero with: aSubtrahend integerValue - value.! !


!MayoresAUno methodsFor: 'testing' stamp: 'GR 9/27/2018 23:45:33'!
isNegative

	^false! !

!MayoresAUno methodsFor: 'testing' stamp: 'GR 9/27/2018 23:47:05'!
isOne

	^false! !

!MayoresAUno methodsFor: 'testing' stamp: 'GR 9/27/2018 23:47:10'!
isZero

	^false! !

!MayoresAUno methodsFor: 'testing' stamp: 'GR 9/28/2018 01:03:01'!
shouldNotBeOne! !

!MayoresAUno methodsFor: 'testing' stamp: 'GR 9/28/2018 01:01:30'!
shouldNotBeZero! !

!MayoresAUno methodsFor: 'testing' stamp: 'GR 9/29/2018 18:18:55'!
shouldNotDivideIfZero! !


!MayoresAUno methodsFor: 'initialization' stamp: 'GR 9/27/2018 23:42:40'!
initalizeWith: aValue 
	
	value:=aValue! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MayoresAUno class' category: #'Numero-Exercise'!
MayoresAUno class
	instanceVariableNames: ''!

!MayoresAUno class methodsFor: 'as yet unclassified' stamp: 'GR 9/27/2018 23:14:50'!
isFor: aValue

	^1<aValue! !


!classDefinition: #Negativos category: #'Numero-Exercise'!
Entero subclass: #Negativos
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Negativos methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:02:30'!
* aMultiplier 
	
	^aMultiplier multiplyTheInteger: self.! !

!Negativos methodsFor: 'arithmetic operations' stamp: 'GR 9/27/2018 23:48:48'!
+ anAdder 
	
	^anAdder addTheInteger: self! !

!Negativos methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:10:01'!
- aSubtrahend

^ aSubtrahend substractTheInteger: self.! !

!Negativos methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:25:31'!
/ aDivisor 
	
	^aDivisor divideTheInteger: self! !

!Negativos methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:23:40'!
// aDivisor 
	
	^Entero with: value // aDivisor integerValue.! !

!Negativos methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:32:22'!
addTheFraction: anAdder 
	
	| newNumerator |
	
	newNumerator := (self * anAdder denominator) + (anAdder numerator).
	
	^newNumerator / anAdder denominator ! !

!Negativos methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:37:37'!
addTheInteger: anAdder 
	
	^Entero with: value + anAdder integerValue! !

!Negativos methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:42:38'!
divideTheFraction: aDivisor 
	
	^ (aDivisor numerator) / (self * aDivisor denominator)! !

!Negativos methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:44:11'!
divideTheInteger: aDivisor 
	
	^Fraccion with: aDivisor over: self! !

!Negativos methodsFor: 'arithmetic operations' stamp: 'GR 9/27/2018 23:12:44'!
fibonacci

	self error: Entero negativeFibonacciErrorDescription! !

!Negativos methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:23:54'!
greatestCommonDivisorWith: anEntero 
	
	^Entero with: (value gcd: anEntero integerValue)! !

!Negativos methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:49:13'!
multiplyTheFraction: aMultiplier 
	
	^(self * aMultiplier numerator) / (aMultiplier denominator)! !

!Negativos methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 16:34:02'!
multiplyTheInteger: aMultiplier 
	
	^Entero with: value * aMultiplier integerValue! !

!Negativos methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:51:47'!
substractTheFraction: aSubtrahend 
	
	| newNumerator |
	
	newNumerator := (aSubtrahend numerator) - (self * aSubtrahend denominator).
	
	^newNumerator / aSubtrahend denominator! !

!Negativos methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:54:13'!
substractTheInteger: aSubtrahend 
	
	^Entero with: aSubtrahend integerValue - value.! !


!Negativos methodsFor: 'testing' stamp: 'GR 9/27/2018 23:45:05'!
isNegative

	^true! !

!Negativos methodsFor: 'testing' stamp: 'GR 9/27/2018 23:47:25'!
isOne

	^false! !

!Negativos methodsFor: 'testing' stamp: 'GR 9/27/2018 23:47:29'!
isZero

	^false! !

!Negativos methodsFor: 'testing' stamp: 'GR 9/28/2018 01:03:09'!
shouldNotBeOne! !

!Negativos methodsFor: 'testing' stamp: 'GR 9/28/2018 01:01:34'!
shouldNotBeZero! !

!Negativos methodsFor: 'testing' stamp: 'GR 9/29/2018 18:18:55'!
shouldNotDivideIfZero! !


!Negativos methodsFor: 'initialization' stamp: 'GR 9/27/2018 23:42:23'!
initalizeWith: aValue 
	
	value:=aValue! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Negativos class' category: #'Numero-Exercise'!
Negativos class
	instanceVariableNames: ''!

!Negativos class methodsFor: 'as yet unclassified' stamp: 'GR 9/27/2018 23:14:59'!
isFor: aValue

	^0>aValue! !


!classDefinition: #Uno category: #'Numero-Exercise'!
Entero subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:02:40'!
* aMultiplier 
	
	^aMultiplier! !

!Uno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:46:52'!
+ anAdder 
	
	^anAdder addTheInteger: self! !

!Uno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:11:34'!
- aSubtrahend

^ aSubtrahend substractTheInteger: self.! !

!Uno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:25:35'!
/ aDivisor 
	
	^aDivisor divideTheInteger: self! !

!Uno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:18:53'!
// aDivisor 
	
	^Entero with: value // aDivisor integerValue.
	
	
! !

!Uno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:36:38'!
addTheFraction: anAdder 
	
	^anAdder denominator + anAdder numerator / anAdder denominator ! !

!Uno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:39:18'!
addTheInteger: anAdder 
	
	^Entero with: value + anAdder integerValue! !

!Uno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:43:00'!
divideTheFraction: aDivisor 
	
	^ aDivisor! !

!Uno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:44:29'!
divideTheInteger: aDivisor 
	
	^aDivisor! !

!Uno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:24:17'!
fibonacci
	
	^Entero with: 1.
! !

!Uno methodsFor: 'arithmetic operations' stamp: 'GR 9/27/2018 23:52:17'!
greatestCommonDivisorWith: anEntero 
	
	^self! !

!Uno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:49:22'!
multiplyTheFraction: aMultiplier 
	
	^aMultiplier! !

!Uno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:50:08'!
multiplyTheInteger: aMultiplier 
	
	^aMultiplier! !

!Uno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:52:36'!
substractTheFraction: aSubtrahend 
	
	^aSubtrahend numerator - aSubtrahend denominator / aSubtrahend denominator! !

!Uno methodsFor: 'arithmetic operations' stamp: 'GR 9/28/2018 00:54:29'!
substractTheInteger: aSubtrahend 
	
	^Entero with: aSubtrahend integerValue - value.! !


!Uno methodsFor: 'testing' stamp: 'GR 9/27/2018 23:45:39'!
isNegative

	^false! !

!Uno methodsFor: 'testing' stamp: 'GR 9/27/2018 23:47:44'!
isOne

	^true! !

!Uno methodsFor: 'testing' stamp: 'GR 9/27/2018 23:47:37'!
isZero

	^false! !

!Uno methodsFor: 'testing' stamp: 'GR 9/28/2018 01:03:19'!
shouldNotBeOne
	
	self error: 'una fraccion no puede tener denominador 1 porque sino es un entero'! !

!Uno methodsFor: 'testing' stamp: 'GR 9/28/2018 01:01:44'!
shouldNotBeZero! !

!Uno methodsFor: 'testing' stamp: 'GR 9/29/2018 18:18:55'!
shouldNotDivideIfZero! !


!Uno methodsFor: 'initialization' stamp: 'GR 9/27/2018 23:42:10'!
initalizeWith: aValue 
	
	value:=1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Uno class' category: #'Numero-Exercise'!
Uno class
	instanceVariableNames: ''!

!Uno class methodsFor: 'as yet unclassified' stamp: 'ap 9/27/2018 23:28:35'!
isFor: aValue

	^1=aValue! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'GR 9/25/2018 11:08:44'!
* aMultiplier 
	
	^aMultiplier multiplyTheFraction: self
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'GR 9/25/2018 10:57:50'!
+ anAdder 
	
	^anAdder addTheFraction: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'GR 9/25/2018 11:32:45'!
- aSubtrahend 
	
	^aSubtrahend substractTheFraction: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'GR 9/25/2018 11:26:11'!
/ aDivisor 
	
	^ aDivisor divideTheFraction: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'GR 9/25/2018 10:52:33'!
addTheFraction: anAdder 
	
	| newNumerator newDenominator |
	
	newNumerator := (numerator * anAdder denominator) + (denominator * anAdder numerator).
	newDenominator := denominator * anAdder denominator.
	
	^newNumerator / newDenominator ! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'GR 9/25/2018 11:00:44'!
addTheInteger: anAdder 
	
	| newNumerator |
	
	newNumerator := (numerator) + (denominator * anAdder).

	
	^newNumerator / denominator! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'GR 9/25/2018 11:25:41'!
divideTheFraction: aDivisor 
	
	^(denominator * aDivisor numerator) / (numerator * aDivisor denominator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'GR 9/25/2018 11:25:57'!
divideTheInteger: aDivisor 
	
	^ (denominator * aDivisor) / (numerator)! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'GR 9/25/2018 11:08:10'!
multiplyTheFraction: aMultiplier 
	
	^(numerator * aMultiplier numerator) / (denominator * aMultiplier denominator)
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'GR 9/25/2018 11:11:09'!
multiplyTheInteger: aMultiplier 
	
	^(numerator * aMultiplier) / denominator
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'GR 9/25/2018 11:32:55'!
substractTheFraction: aSubtrahend 
	
	| newNumerator newDenominator |
	
	newNumerator := (denominator * aSubtrahend numerator) - (numerator * aSubtrahend denominator).
	newDenominator := denominator * aSubtrahend denominator.
	
	^newNumerator / newDenominator 
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'GR 9/25/2018 11:49:03'!
substractTheInteger: aSubtrahend 
	
	| newNumerator |
	
	newNumerator := (denominator * aSubtrahend) - (numerator).
	
	^newNumerator / denominator 
! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'GR 9/28/2018 01:02:20'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator shouldNotBeZero.
	aDenominator shouldNotBeOne.
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: #'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'GR 9/29/2018 18:18:48'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor shouldNotDivideIfZero.
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue:[ ^aDividend negated / aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
	! !
