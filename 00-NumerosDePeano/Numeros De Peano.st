!classDefinition: #I category: #'Numeros De Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Numeros De Peano'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'G R 9/7/2018 16:15:15'!
* OtroNumeroDePeano
	"comment stating purpose of message"

	| |
	^OtroNumeroDePeano! !

!I class methodsFor: 'as yet unclassified' stamp: 'APç 9/6/2018 21:40:25'!
+ otroNumeroDePeano

	^otroNumeroDePeano next! !

!I class methodsFor: 'as yet unclassified' stamp: 'G R 9/11/2018 11:39:24'!
- unNumeroDePeano

	self error: 'No se puede restar un numero mayor o igual'! !

!I class methodsFor: 'as yet unclassified' stamp: 'ap 9/13/2018 22:23:59'!
/ OtroNumeroDePeano
	"comment stating purpose of message"

	(OtroNumeroDePeano = I) ifTrue: [^self].
	
	^self error: 'Dividendo debe ser multiplo del divisor'
	
	
	
! !

!I class methodsFor: 'as yet unclassified' stamp: 'APç 9/6/2018 21:26:02'!
next
	"comment stating purpose of message"

	^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'AP 9/11/2018 00:35:59'!
restameDe: unNumeroDePeano
	
	^ unNumeroDePeano previous! !


!classDefinition: #II category: #'Numeros De Peano'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Numeros De Peano'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'G R 9/10/2018 23:36:42'!
* OtroNumeroDePeano


	^(self previous * OtroNumeroDePeano) + OtroNumeroDePeano! !

!II class methodsFor: 'as yet unclassified' stamp: 'APç 9/6/2018 21:49:18'!
+ unNumeroDePEano

	^ self previous + unNumeroDePEano next! !

!II class methodsFor: 'as yet unclassified' stamp: 'G R 9/10/2018 23:31:30'!
- unNumeroDePeano
	
	^unNumeroDePeano restameDe: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'ap 9/13/2018 22:23:23'!
/ OtroNumeroDePeano
	"comment stating purpose of message"

	(OtroNumeroDePeano = I) ifTrue: [^self].
	(OtroNumeroDePeano = self) ifTrue: [^I].
	(self menorOIgualA: OtroNumeroDePeano) ifTrue: [self error: 'Dividendo debe ser multiplo del divisor'].
	^(((self - OtroNumeroDePeano)/OtroNumeroDePeano) + I )! !

!II class methodsFor: 'as yet unclassified' stamp: 'ap 9/13/2018 22:24:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'G R 9/11/2018 11:56:04'!
menorOIgualA: otroNumeroDePeano
	otroNumeroDePeano = I ifTrue: [^false].
	^(self = otroNumeroDePeano or: (self menorOIgualA: otroNumeroDePeano previous))	! !

!II class methodsFor: 'as yet unclassified' stamp: 'APç 9/6/2018 21:46:24'!
next

	next ifNil:
	[
		next:=self cloneNamed: self name , 'I'.
		next prev: self
	].

	^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'APç 9/6/2018 21:45:33'!
prev: prev

	previous:=prev! !

!II class methodsFor: 'as yet unclassified' stamp: 'APç 9/6/2018 21:44:37'!
previous
	"comment stating purpose of message"

	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'ap 9/13/2018 22:21:42'!
restameDe: unNumeroDePeano
		
	^unNumeroDePeano previous - self previous! !


!classDefinition: #III category: #'Numeros De Peano'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Numeros De Peano'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'as yet unclassified' stamp: 'G R 9/11/2018 00:04:28'!
* OtroNumeroDePeano


	^(self previous * OtroNumeroDePeano) + OtroNumeroDePeano! !

!III class methodsFor: 'as yet unclassified' stamp: 'G R 9/11/2018 00:04:28'!
+ unNumeroDePEano

	^ self previous + unNumeroDePEano next! !

!III class methodsFor: 'as yet unclassified' stamp: 'G R 9/11/2018 00:04:28'!
- unNumeroDePeano
	
	^unNumeroDePeano restameDe: self! !

!III class methodsFor: 'as yet unclassified' stamp: 'ap 9/13/2018 22:23:32'!
/ OtroNumeroDePeano
	"comment stating purpose of message"

	(OtroNumeroDePeano = I) ifTrue: [^self].
	(OtroNumeroDePeano = self) ifTrue: [^I].
	(self menorOIgualA: OtroNumeroDePeano) ifTrue: [self error: 'Dividendo debe ser multiplo del divisor'].
	^(((self - OtroNumeroDePeano)/OtroNumeroDePeano) + I )! !

!III class methodsFor: 'as yet unclassified' stamp: 'ap 9/13/2018 22:24:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'G R 9/11/2018 11:56:23'!
menorOIgualA: otroNumeroDePeano
	otroNumeroDePeano = I ifTrue: [^false].
	^(self = otroNumeroDePeano or: (self menorOIgualA: otroNumeroDePeano previous))	! !

!III class methodsFor: 'as yet unclassified' stamp: 'G R 9/11/2018 00:04:29'!
next

	next ifNil:
	[
		next:=self cloneNamed: self name , 'I'.
		next prev: self
	].

	^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'G R 9/11/2018 00:04:29'!
prev: prev

	previous:=prev! !

!III class methodsFor: 'as yet unclassified' stamp: 'G R 9/11/2018 00:04:29'!
previous
	"comment stating purpose of message"

	^previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'ap 9/13/2018 22:21:49'!
restameDe: unNumeroDePeano
	
	
	^unNumeroDePeano previous - self previous! !


!classDefinition: #IIII category: #'Numeros De Peano'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Numeros De Peano'!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'G R 9/11/2018 00:04:29'!
* OtroNumeroDePeano


	^(self previous * OtroNumeroDePeano) + OtroNumeroDePeano! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'G R 9/11/2018 00:04:29'!
+ unNumeroDePEano

	^ self previous + unNumeroDePEano next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'G R 9/11/2018 00:04:29'!
- unNumeroDePeano
	
	^unNumeroDePeano restameDe: self! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ap 9/13/2018 22:23:41'!
/ OtroNumeroDePeano
	"comment stating purpose of message"

	(OtroNumeroDePeano = I) ifTrue: [^self].
	(OtroNumeroDePeano = self) ifTrue: [^I].
	(self menorOIgualA: OtroNumeroDePeano) ifTrue: [self error: 'Dividendo debe ser multiplo del divisor'].
	^(((self - OtroNumeroDePeano)/OtroNumeroDePeano) + I )! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ap 9/13/2018 22:24:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'G R 9/11/2018 11:56:31'!
menorOIgualA: otroNumeroDePeano
	otroNumeroDePeano = I ifTrue: [^false].
	^(self = otroNumeroDePeano or: (self menorOIgualA: otroNumeroDePeano previous))	! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'G R 9/11/2018 00:04:29'!
next

	next ifNil:
	[
		next:=self cloneNamed: self name , 'I'.
		next prev: self
	].

	^next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'G R 9/11/2018 00:04:29'!
prev: prev

	previous:=prev! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'G R 9/11/2018 00:04:29'!
previous
	"comment stating purpose of message"

	^previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'ap 9/13/2018 22:21:57'!
restameDe: unNumeroDePeano
	
	
	^unNumeroDePeano previous - self previous! !


!classDefinition: #IIIII category: #'Numeros De Peano'!
DenotativeObject subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: #'Numeros De Peano'!
IIIII class
	instanceVariableNames: 'next previous'!

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ap 9/13/2018 22:20:19'!
* OtroNumeroDePeano


	^(self previous * OtroNumeroDePeano) + OtroNumeroDePeano! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ap 9/13/2018 22:20:19'!
+ unNumeroDePEano

	^ self previous + unNumeroDePEano next! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ap 9/13/2018 22:20:19'!
- unNumeroDePeano
	
	^unNumeroDePeano restameDe: self! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ap 9/13/2018 22:23:51'!
/ OtroNumeroDePeano
	"comment stating purpose of message"

	(OtroNumeroDePeano = I) ifTrue: [^self].
	(OtroNumeroDePeano = self) ifTrue: [^I].
	(self menorOIgualA: OtroNumeroDePeano) ifTrue: [self error: 'Dividendo debe ser multiplo del divisor'].
	^(((self - OtroNumeroDePeano)/OtroNumeroDePeano) + I )! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ap 9/13/2018 22:24:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIII.! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ap 9/13/2018 22:20:19'!
menorOIgualA: otroNumeroDePeano
	otroNumeroDePeano = I ifTrue: [^false].
	^(self = otroNumeroDePeano or: (self menorOIgualA: otroNumeroDePeano previous))	! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ap 9/13/2018 22:20:20'!
next

	next ifNil:
	[
		next:=self cloneNamed: self name , 'I'.
		next prev: self
	].

	^next! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ap 9/13/2018 22:20:20'!
prev: prev

	previous:=prev! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ap 9/13/2018 22:20:20'!
previous
	"comment stating purpose of message"

	^previous! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'ap 9/13/2018 22:22:03'!
restameDe: unNumeroDePeano
	
	
	^unNumeroDePeano previous - self previous! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!