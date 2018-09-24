!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: 'customerBook paulMcCartney johnLennon'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'apenas 9/20/2018 21:47:40'!
addAndSuspend: aCustomer To: aCustomerBook
	
	
	aCustomerBook addCustomerNamed: aCustomer.
	aCustomerBook suspendCustomerNamed: aCustomer.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'apenas 9/20/2018 22:04:02'!
can: aName beSuspendedIn: aCustomerBook afterAdding: anotherName


	self should: [ aCustomerBook suspendCustomerNamed: aName]
	 failWithError:CantSuspend  
	do: [ :anError | 
			self assert: aCustomerBook numberOfCustomers = 1.
			self assert: (aCustomerBook includesCustomerNamed: anotherName) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'apenas 9/20/2018 22:04:33'!
canTheCustomer: aName beSuspendedIn: aCustomerBook afterAdding: anotherName


	self should: [ aCustomerBook suspendCustomerNamed: aName]
	 failWithError:CantSuspend  
	do: [ :anError | 
			self assert: aCustomerBook numberOfCustomers = 1.
			self assert: (aCustomerBook includesCustomerNamed: anotherName) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'apenas 9/20/2018 22:02:26'!
is: aName in: aCustomerBook afterAdding: anotherName


	self should: [ aCustomerBook suspendCustomerNamed: aName]
	 failWithError:CantSuspend  
	do: [ :anError | 
			self assert: aCustomerBook numberOfCustomers = 1.
			self assert: (aCustomerBook includesCustomerNamed: anotherName) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GR 9/21/2018 22:42:36'!
setUp



	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	johnLennon := 'John Lennon'.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GR 9/24/2018 00:29:57'!
setUpJohn

	johnLennon := 'John Lennon'.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GR 9/24/2018 00:30:14'!
setUpPaul
	paulMcCartney := 'Paul McCartney'.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'apenas 9/20/2018 21:29:23'!
should: aClosureToTry failWithError: error do: aClosure



	[ aClosureToTry value.
		self fail]
		on: error 
		do: aClosure
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'apenas 9/20/2018 21:26:40'!
should: operationWithCustomerBlock lastLessThan: aTimeInMilliseconds

	|  millisecondsBeforeRunning millisecondsAfterRunning |

	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	operationWithCustomerBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (aTimeInMilliseconds * millisecond)
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GR 9/24/2018 00:30:35'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	self setUpJohn.
	
	self should: [ customerBook addCustomerNamed: 'John Lennon'] lastLessThan: 50
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GR 9/24/2018 00:30:48'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	self setUpPaul.
	customerBook addCustomerNamed: paulMcCartney.
	 
	self should: [customerBook removeCustomerNamed: paulMcCartney] lastLessThan: 100

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GR 9/24/2018 00:30:58'!
test03CanNotAddACustomerWithEmptyName 




	self should: [ customerBook addCustomerNamed: ''] 
	failWithError: Error 
	do:[:anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GR 9/24/2018 00:31:22'!
test04CanNotRemoveAnInvalidCustomer
	
	self setUpJohn.
	customerBook addCustomerNamed: johnLennon.
	
	self should: [customerBook removeCustomerNamed: 'Paul McCartney'] 
	failWithError: NotFound 
	do:[ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GR 9/24/2018 00:31:32'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	self setUpPaul.
	self addAndSuspend: paulMcCartney To: customerBook.
	
	self verifyNoActiveCustomersOf:customerBook withAmountOfSuspendedCustomers:1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GR 9/24/2018 00:31:40'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook


	self setUpPaul.
	self addAndSuspend: paulMcCartney To: customerBook.
	
	customerBook removeCustomerNamed: paulMcCartney.
	
	self verifyNoActiveCustomersOf:customerBook withAmountOfSuspendedCustomers:0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GR 9/24/2018 00:31:53'!
test07CanNotSuspendAnInvalidCustomer
	
	self setUpJohn.
	customerBook addCustomerNamed: johnLennon.
		
		
	self canTheCustomer:'Paul McCartney'  beSuspendedIn: customerBook afterAdding: johnLennon.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'GR 9/24/2018 00:32:03'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	self setUpJohn.
	self addAndSuspend: johnLennon To: customerBook.
	
	self canTheCustomer:johnLennon  beSuspendedIn: customerBook afterAdding: johnLennon.

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'apenas 9/20/2018 21:49:52'!
verifyNoActiveCustomersOf:aCustomerBook withAmountOfSuspendedCustomers: aNumber
	

	
	self assert: 0 equals: aCustomerBook numberOfActiveCustomers.
	self assert: aNumber equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: aNumber equals: aCustomerBook numberOfCustomers.
! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers suspended'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'HAW 9/19/2018 08:40:28'!
includesCustomerNamed: aName

	^(customers includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'HAW 9/19/2018 08:40:38'!
isEmpty
	
	^customers isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NicolasRinaldi 9/16/2018 21:55:33'!
initialize

	super initialize.
	customers := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'apenas 9/20/2018 20:23:08'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:57'!
numberOfActiveCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'apenas 9/20/2018 20:33:19'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'GR 9/21/2018 22:17:39'!
removeCustomer: aName fromGroup: aCollection 
 
	1 to: aCollection size do: 
	[ :index |
		aName = (aCollection at: index)
			ifTrue: [
				aCollection removeAt: index.
				^ aName
			] 
	].

! !

!CustomerBook methodsFor: 'customer management' stamp: 'GR 9/21/2018 22:50:17'!
removeCustomerNamed: aName 
 
	((self removeCustomer: aName fromGroup: customers) value = aName) ifTrue: [^aName].

	((self removeCustomer: aName fromGroup: suspended) value = aName) ifTrue: [^aName].
	"acá está el problema del huevo y la gallina que no pude arreglar del todo, haría falta un doble return (borrar comentario y fijarse si removerCustomer fromGroup es un buen nombre)"
	^ NotFound signal.! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:27:55'!
suspendCustomerNamed: aName 
	
	(customers includes: aName) ifFalse: [^CantSuspend signal].
	
	customers remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
