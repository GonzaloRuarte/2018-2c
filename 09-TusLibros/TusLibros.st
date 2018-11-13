!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'as yet unclassified' stamp: 'APç 11/12/2018 21:15:52'!
test01CartIsEmptyWhenCreated

	cart:=Cart withCatalogue: (OrderedCollection with: '1' ).
	
	self assert: cart isEmpty.	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'APç 11/12/2018 21:16:01'!
test02CartIsNotEmptyWhenBooksAreAdded

	cart:=Cart withCatalogue: (OrderedCollection with: '1' ).
	cart add: '1' amount: 2. 
	self deny: cart isEmpty.	! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'APç 11/12/2018 21:16:08'!
test03CantAddBookFromOtherEditorial

	cart:=Cart withCatalogue: OrderedCollection new.
	
	self should: [cart add: '5694' amount: 1.] raise: Error withExceptionDo:
	[:anError| 
		self assert: cart isEmpty.
		self assert: anError messageText equals: 'The book you are trying to add doesn t belong to this editorial' ].! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'APç 11/12/2018 21:16:13'!
test04CantAddLessThan1BooksToCart

	cart:=Cart withCatalogue: (OrderedCollection with: 1).
	
	self should: [cart add: '1' amount: 0.] raise: Error withExceptionDo:
	[:anError| 
		self assert: cart isEmpty.
		self assert: anError messageText equals: 'The amount of books cannot be lesser than one'].! !

!CartTest methodsFor: 'as yet unclassified' stamp: 'APç 11/12/2018 21:16:22'!
test05BookAmountMustBeAnInteger

	cart:=Cart withCatalogue: (OrderedCollection with: '1').
	
	self should: [cart add: '1' amount: 1.5.] raise: Error withExceptionDo:
	[:anError| 
		self assert: cart isEmpty.
		self assert: anError messageText equals: 'The amount of books must be an integer'].! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'books editorialBooks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'APç 11/12/2018 21:13:57'!
initializeWithCatalogue: aBookCatalogue

	books:= Dictionary new.	
	editorialBooks:= aBookCatalogue.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'APç 11/12/2018 20:27:57'!
isEmpty

	^books keys isEmpty .! !


!Cart methodsFor: 'adding' stamp: 'APç 11/12/2018 21:12:40'!
add: aISBN amount: aBookAmount

	(aBookAmount < 1) ifTrue:[self error: self class bookAmountShouldNotBeLesserThanOne ].
	(aBookAmount isInteger) ifFalse:[self error: self class bookAmountShouldBeAnInteger ].

	(editorialBooks includes: aISBN) ifTrue: [
	books at: aISBN put: aBookAmount] ifFalse: [self error: self class bookBelongsToOtherEditorialErrorMessage ].
	 
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'APç 11/12/2018 21:13:57'!
withCatalogue: aBookCollection

	^self new initializeWithCatalogue: aBookCollection ! !


!Cart class methodsFor: 'exceptions' stamp: 'APç 11/12/2018 21:12:12'!
bookAmountShouldBeAnInteger

	^'The amount of books must be an integer'! !

!Cart class methodsFor: 'exceptions' stamp: 'APç 11/12/2018 21:07:46'!
bookAmountShouldNotBeLesserThanOne

	^'The amount of books cannot be lesser than one'! !

!Cart class methodsFor: 'exceptions' stamp: 'APç 11/12/2018 20:18:39'!
bookBelongsToOtherEditorialErrorMessage

	^'The book you are trying to add doesn t belong to this editorial'! !
