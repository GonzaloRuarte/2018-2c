!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value - private' stamp: 'GR 10/12/2018 00:44:26'!
weightInBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value - private' stamp: 'GR 10/12/2018 00:44:26'!
weightInBalance

	^ self value! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'value - private' stamp: 'GR 10/12/2018 00:44:26'!
weightInBalance

	^self value negated! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #SummarizingAccount category: #'Portfolio-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:28'!
doesManage: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'balance' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'testing - private' stamp: 'GR 10/13/2018 21:34:33'!
accountsAlsoManagedBy: anotherAccount ifNone: aCollaborationToEval

		self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing - private' stamp: 'GR 10/13/2018 21:33:38'!
managedAccounts
	
	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'GR 10/12/2018 19:00:33'!
balance

	^ accounts sum: [:anAccount| anAccount balance].! !


!Portfolio methodsFor: 'testing' stamp: 'GR 10/12/2018 18:58:14'!
doesManage: anAccount

	^self managedAccounts includes: anAccount

! !

!Portfolio methodsFor: 'testing' stamp: 'GR 10/12/2018 10:39:54'!
hasRegistered: aTransaction

	^self transactions includes: aTransaction ! !


!Portfolio methodsFor: 'testing - private' stamp: 'GR 10/13/2018 21:34:15'!
accountsAlsoManagedBy: anotherAccount ifNone: aCollaborationToEval

^(anotherAccount managedAccounts detect: [:account| (self doesManage: account)]
							ifNone: aCollaborationToEval)! !

!Portfolio methodsFor: 'testing - private' stamp: 'GR 10/12/2018 19:02:50'!
managedAccounts
	
	|anAccountCollection|
	
	anAccountCollection := OrderedCollection with: self.
	
	^self sendToAccounts: #managedAccounts andAddTo: anAccountCollection.! !

!Portfolio methodsFor: 'testing - private' stamp: 'GR 10/13/2018 20:22:49'!
sendToAccounts: aMessage andAddTo: aCollection


	
	accounts do:[:anAccount| aCollection addAll: (aMessage sendTo: anAccount) ].
	
	^aCollection! !


!Portfolio methodsFor: 'transactions' stamp: 'GR 10/12/2018 19:02:57'!
transactions 

	|transactionCollection|
	transactionCollection:= OrderedCollection  new.
	
	^self sendToAccounts: #transactions andAddTo: transactionCollection.! !

!Portfolio methodsFor: 'transactions' stamp: 'GR 10/12/2018 18:57:56'!
transactionsOf: anAccount 
	
	|account|
	account := self managedAccounts detect: [:anotherAccount| anotherAccount = anAccount] ifNone: [^self error: self class accountNotManagedMessageDescription ].
	^account transactions! !


!Portfolio methodsFor: 'initialization' stamp: 'GR 10/12/2018 19:00:49'!
initializeWith: aCollectionOfAccounts
	
	accounts := aCollectionOfAccounts.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'GR 10/13/2018 20:31:26'!
with: leftAccount with: rightAccount
	

		^self withAll: (OrderedCollection with: leftAccount with: rightAccount).
! !

!Portfolio class methodsFor: 'instance creation' stamp: 'GR 10/13/2018 21:33:07'!
withAll: aCollectionOfAccounts

	aCollectionOfAccounts do: [:anAccountInCollection| 
		aCollectionOfAccounts do: [:anotherAccountInCollection|
			anAccountInCollection accountsAlsoManagedBy: anotherAccountInCollection ifNone: [
			anotherAccountInCollection accountsAlsoManagedBy: anAccountInCollection ifNone: [
							^self basicNew initializeWith: aCollectionOfAccounts.
							]
							]
							]
		without: anAccountInCollection
							].
	^self error: self accountAlreadyManagedErrorMessage.
! !


!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/8/2018 16:08:43'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HAW 5/8/2018 16:08:53'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'GR 10/12/2018 18:43:52'!
balance

	^ self transactions inject: 0 into: [:aSum :aTransaction| aSum +aTransaction weightInBalance].! !


!ReceptiveAccount methodsFor: 'testing - private' stamp: 'GR 10/13/2018 21:39:35'!
accountsAlsoManagedBy: anotherAccount ifNone: aCollaborationToEval

	^aCollaborationToEval value! !

!ReceptiveAccount methodsFor: 'testing - private' stamp: 'GR 10/12/2018 18:58:57'!
managedAccounts
	
	^OrderedCollection with: self.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'GR 10/12/2018 09:58:51'!
doesManage: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'GR 10/12/2018 10:28:14'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
