!classDefinition: #AccountTransaction category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransaction methodsFor: 'evaluating' stamp: 'HAW 10/18/2018 18:48:48'!
affectBalance: currentBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'evaluating' stamp: 'HernanWilkinson 7/14/2011 06:48'!
value

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'visitor - private' stamp: 'GR 10/19/2018 12:45:23'!
accept: aVisitor
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #CertificateOfDeposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #CertificateOfDeposit
	instanceVariableNames: 'value rate days'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!CertificateOfDeposit methodsFor: 'value' stamp: 'APç 10/18/2018 21:29:07'!
affectBalance: currentBalance

	^currentBalance - self value! !

!CertificateOfDeposit methodsFor: 'value' stamp: 'APç 10/18/2018 21:38:01'!
days

	^days! !

!CertificateOfDeposit methodsFor: 'value' stamp: 'APç 10/18/2018 21:37:53'!
rateAsPercentage

	^ rate * 100.! !

!CertificateOfDeposit methodsFor: 'value' stamp: 'APç 10/18/2018 21:21:46'!
value

	^ value! !

!CertificateOfDeposit methodsFor: 'value' stamp: 'APç 10/18/2018 21:32:56'!
valueOfEarnings

	^ value*(rate /360)*days ! !


!CertificateOfDeposit methodsFor: 'initialization' stamp: 'APç 10/18/2018 21:20:04'!
initializeWith: anAmount at: aRate during: aNumberOfDays

	value:= anAmount.
	rate:=aRate .
	days:=aNumberOfDays .! !


!CertificateOfDeposit methodsFor: 'visitor - private' stamp: 'ap 10/22/2018 21:56:56'!
accept: aVisitor
	
	aVisitor visitCertificateOfDeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CertificateOfDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
CertificateOfDeposit class
	instanceVariableNames: ''!

!CertificateOfDeposit class methodsFor: 'instance creation' stamp: 'APç 10/18/2018 21:21:14'!
register: anAmount during: aNumberOfDays at: anInteresRate on: anAccount

	|certificateOfDeposit|
	certificateOfDeposit:=self new initializeWith: anAmount at: anInteresRate during: aNumberOfDays.
	anAccount register: certificateOfDeposit.
	^certificateOfDeposit.

! !


!classDefinition: #Deposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HAW 10/18/2018 18:49:00'!
affectBalance: currentBalance

	^currentBalance + value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'visitor - private' stamp: 'ap 10/22/2018 21:57:00'!
accept: aVisitor
	
	aVisitor visitDeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'PortfolioTreePrinter-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 19:41'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #TransferLeg category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferLeg methodsFor: 'initialization' stamp: 'APç 10/18/2018 19:56:50'!
initializeWith:anAmount belongingTo: aTransfer

	value:=anAmount.
	transfer:=aTransfer. ! !


!TransferLeg methodsFor: 'value' stamp: 'APç 10/18/2018 19:51:32'!
affectBalance: currentBalance

	self subclassResponsibility ! !

!TransferLeg methodsFor: 'value' stamp: 'APç 10/18/2018 19:34:09'!
transfer

	^transfer. ! !

!TransferLeg methodsFor: 'value' stamp: 'APç 10/18/2018 20:26:04'!
value

	^transfer value. ! !


!TransferLeg methodsFor: 'visitor - private' stamp: 'ap 10/22/2018 21:57:04'!
accept: aVisitor
	
	aVisitor visitTransferLeg: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'APç 10/18/2018 19:55:25'!
register:anAmount on:fromAccount belongingTo: aTransfer


	| withdraw |
	
	withdraw := self new initializeWith:anAmount belongingTo: aTransfer.
	fromAccount register: withdraw.
		
	^ withdraw
! !


!classDefinition: #TransferDeposit category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferDeposit methodsFor: 'value' stamp: 'APç 10/18/2018 20:37:03'!
affectBalance: currentBalance

	^currentBalance + self value! !


!classDefinition: #TransferWithdraw category: #'PortfolioTreePrinter-Ejercicio'!
TransferLeg subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferWithdraw methodsFor: 'value' stamp: 'APç 10/18/2018 20:37:09'!
affectBalance: currentBalance

	^currentBalance - self value! !


!classDefinition: #Withdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HAW 10/18/2018 18:49:08'!
affectBalance: currentBalance

	^currentBalance - value! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/14/2011 05:54'!
value

	^ value ! !


!Withdraw methodsFor: 'visitor - private' stamp: 'ap 10/22/2018 21:57:12'!
accept: aVisitor
	
	aVisitor visitWithdraw: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/14/2011 05:32'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #AccountTransactionVisitor category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransactionVisitor
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransactionVisitor methodsFor: 'visiting' stamp: 'GR 10/19/2018 12:39:15'!
visitCertificateOfDeposit: aCertificateOfDeposit
	self subclassResponsibility ! !

!AccountTransactionVisitor methodsFor: 'visiting' stamp: 'GR 10/19/2018 12:40:12'!
visitDeposit: aDeposit
	self subclassResponsibility ! !

!AccountTransactionVisitor methodsFor: 'visiting' stamp: 'GR 10/19/2018 12:40:23'!
visitTransferLeg: aTransferLeg
	self subclassResponsibility ! !

!AccountTransactionVisitor methodsFor: 'visiting' stamp: 'GR 10/19/2018 12:40:35'!
visitWithdraw: aWithdraw
	self subclassResponsibility ! !


!AccountTransactionVisitor methodsFor: 'value' stamp: 'ap 10/22/2018 22:50:42'!
value

	self subclassResponsibility ! !


!AccountTransactionVisitor methodsFor: 'initialization' stamp: 'ap 10/22/2018 22:51:03'!
initializeOf: aReceptiveAccount

		self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransactionVisitor class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionVisitor class
	instanceVariableNames: ''!

!AccountTransactionVisitor class methodsFor: 'instance creation' stamp: 'ap 10/22/2018 22:53:32'!
of: aReceptiveAccount

	self subclassResponsibility ! !


!classDefinition: #AccountSummaryLinesVisitor category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionVisitor subclass: #AccountSummaryLinesVisitor
	instanceVariableNames: 'lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountSummaryLinesVisitor methodsFor: 'visiting' stamp: 'ap 10/22/2018 21:59:42'!
visitCertificateOfDeposit: aCertificateOfDeposit

	lines add: 'Plazo fijo por ', aCertificateOfDeposit value asString, ' durante ', aCertificateOfDeposit days asString, ' dias a una tna de ', aCertificateOfDeposit rateAsPercentage asString, '%'! !

!AccountSummaryLinesVisitor methodsFor: 'visiting' stamp: 'ap 10/22/2018 21:59:22'!
visitDeposit: aDeposit

	lines add: 'Deposito por ', aDeposit value asString! !

!AccountSummaryLinesVisitor methodsFor: 'visiting' stamp: 'ap 10/22/2018 21:59:36'!
visitTransferLeg: aTransferLeg

	lines add: 'Transferencia por ', (aTransferLeg affectBalance: 0) asString! !

!AccountSummaryLinesVisitor methodsFor: 'visiting' stamp: 'ap 10/22/2018 21:59:39'!
visitWithdraw: aWithdraw

	lines add: 'Extraccion por ', aWithdraw value asString! !


!AccountSummaryLinesVisitor methodsFor: 'value' stamp: 'ap 10/22/2018 20:31:42'!
value

	account visitTransactionsWith: self.
	
	^lines.! !


!AccountSummaryLinesVisitor methodsFor: 'initialization' stamp: 'ap 10/22/2018 21:56:39'!
initializeOf: aReceptiveAccount

	account:=aReceptiveAccount.
	lines:= OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummaryLinesVisitor class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountSummaryLinesVisitor class
	instanceVariableNames: ''!

!AccountSummaryLinesVisitor class methodsFor: 'instance creation' stamp: 'ap 10/22/2018 21:50:45'!
of: aReceptiveAccount

	^self new initializeOf: aReceptiveAccount! !


!classDefinition: #AccountTransferNetVisitor category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionVisitor subclass: #AccountTransferNetVisitor
	instanceVariableNames: 'net'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransferNetVisitor methodsFor: 'visiting' stamp: 'ap 10/22/2018 21:52:47'!
visitCertificateOfDeposit: aCertificateOfDeposit! !

!AccountTransferNetVisitor methodsFor: 'visiting' stamp: 'ap 10/22/2018 21:52:50'!
visitDeposit: aDeposit! !

!AccountTransferNetVisitor methodsFor: 'visiting' stamp: 'ap 10/22/2018 21:53:05'!
visitTransferLeg: aTransferLeg

	net:=aTransferLeg affectBalance: net! !

!AccountTransferNetVisitor methodsFor: 'visiting' stamp: 'ap 10/22/2018 21:53:20'!
visitWithdraw: aWithdraw! !


!AccountTransferNetVisitor methodsFor: 'initialization' stamp: 'ap 10/22/2018 21:56:24'!
initializeOf: aReceptiveAccount

	account:=aReceptiveAccount.
	net:=0! !


!AccountTransferNetVisitor methodsFor: 'value' stamp: 'ap 10/22/2018 22:02:15'!
value

	
	account visitTransactionsWith: self.
	^net.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransferNetVisitor class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransferNetVisitor class
	instanceVariableNames: ''!

!AccountTransferNetVisitor class methodsFor: 'instance creation' stamp: 'ap 10/22/2018 21:50:51'!
of: aReceptiveAccount

	^self new initializeOf: aReceptiveAccount! !


!classDefinition: #InvestmentEarningsVisitor category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionVisitor subclass: #InvestmentEarningsVisitor
	instanceVariableNames: 'earnings'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentEarningsVisitor methodsFor: 'visiting' stamp: 'ap 10/22/2018 21:54:38'!
visitCertificateOfDeposit: aCertificateOfDeposit

	earnings:= earnings + aCertificateOfDeposit valueOfEarnings ! !

!InvestmentEarningsVisitor methodsFor: 'visiting' stamp: 'ap 10/22/2018 21:54:02'!
visitDeposit: aDeposit
! !

!InvestmentEarningsVisitor methodsFor: 'visiting' stamp: 'ap 10/22/2018 21:54:04'!
visitTransferLeg: aTransferLeg
! !

!InvestmentEarningsVisitor methodsFor: 'visiting' stamp: 'ap 10/22/2018 21:54:07'!
visitWithdraw: aWithdraw
! !


!InvestmentEarningsVisitor methodsFor: 'value' stamp: 'ap 10/22/2018 22:02:32'!
value

	
	account visitTransactionsWith: self.
	^earnings .! !


!InvestmentEarningsVisitor methodsFor: 'initialization' stamp: 'ap 10/22/2018 21:56:20'!
initializeOf: aReceptiveAccount

	account:=aReceptiveAccount.
	earnings:=0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvestmentEarningsVisitor class' category: #'PortfolioTreePrinter-Ejercicio'!
InvestmentEarningsVisitor class
	instanceVariableNames: ''!

!InvestmentEarningsVisitor class methodsFor: 'instance creation' stamp: 'ap 10/22/2018 21:50:53'!
of: aReceptiveAccount

	^self new initializeOf: aReceptiveAccount! !


!classDefinition: #InvestmentNetVisitor category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransactionVisitor subclass: #InvestmentNetVisitor
	instanceVariableNames: 'net'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!InvestmentNetVisitor methodsFor: 'visiting' stamp: 'ap 10/22/2018 21:55:43'!
visitCertificateOfDeposit: aCertificateOfDeposit

	net := net + aCertificateOfDeposit value! !

!InvestmentNetVisitor methodsFor: 'visiting' stamp: 'ap 10/22/2018 21:55:48'!
visitDeposit: aDeposit
! !

!InvestmentNetVisitor methodsFor: 'visiting' stamp: 'ap 10/22/2018 21:55:51'!
visitTransferLeg: aTransferLeg
! !

!InvestmentNetVisitor methodsFor: 'visiting' stamp: 'ap 10/22/2018 21:55:55'!
visitWithdraw: aWithdraw
! !


!InvestmentNetVisitor methodsFor: 'value' stamp: 'ap 10/22/2018 22:02:25'!
value

	
	account visitTransactionsWith: self.
	^net.! !


!InvestmentNetVisitor methodsFor: 'initialization' stamp: 'ap 10/22/2018 21:56:08'!
initializeOf: aReceptiveAccount

	account:=aReceptiveAccount.
	net:=0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'InvestmentNetVisitor class' category: #'PortfolioTreePrinter-Ejercicio'!
InvestmentNetVisitor class
	instanceVariableNames: ''!

!InvestmentNetVisitor class methodsFor: 'instance creation' stamp: 'ap 10/22/2018 21:50:57'!
of: aReceptiveAccount

	^self new initializeOf: aReceptiveAccount! !


!classDefinition: #ReverseTreePrinterVisitor category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #ReverseTreePrinterVisitor
	instanceVariableNames: 'treePrinter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReverseTreePrinterVisitor methodsFor: 'initialization' stamp: 'ap 10/22/2018 22:46:02'!
initializeOf: aPortfolio with:aDictionary

	treePrinter := TreePrinterVisitor of: aPortfolio with: aDictionary! !


!ReverseTreePrinterVisitor methodsFor: 'value' stamp: 'ap 10/22/2018 22:46:23'!
value
	^treePrinter value reversed.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReverseTreePrinterVisitor class' category: #'PortfolioTreePrinter-Ejercicio'!
ReverseTreePrinterVisitor class
	instanceVariableNames: ''!

!ReverseTreePrinterVisitor class methodsFor: 'instance creation' stamp: 'ap 10/22/2018 22:09:21'!
of: aPortfolio with: aDictionary

	^self new initializeOf: aPortfolio with: aDictionary! !


!classDefinition: #SummarizingAccount category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
doesManage: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:32:05'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'visitor - private' stamp: 'ap 10/22/2018 22:52:17'!
accept: aVisitor

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'visitor - private' stamp: 'ap 10/22/2018 22:49:45'!
visitAccountsWith: aVisitor

		self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 19:19'!
initializeWithAll: aCollectionOfAccounts

	accounts := aCollectionOfAccounts   ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
anyManagedAccountManages: anAccount 

	^accounts anySatisfy: [ :managedAccount | (managedAccount doesManage: anAccount) or: [ anAccount doesManage: managedAccount ] ] ! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
doesManage: anAccount

	^ self = anAccount  or: [ self anyManagedAccountManages: anAccount ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:32:05'!
hasRegistered: aTransaction

	^ accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]  ! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 8/13/2017 17:47:44'!
balance

	^ accounts sum: [ :account | account balance ]
! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 9/25/2017 19:40:20'!
transactions 

	^ accounts 
		inject: OrderedCollection new 
		into: [ :transactions :account | transactions addAll: account transactions. transactions ]
	! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 10/18/2018 16:31:24'!
transactionsOf: anAccount 

	^ (self doesManage: anAccount)
		ifTrue: [ anAccount transactions ] 
		ifFalse: [ self error: self class accountNotManagedMessageDescription]
	! !


!Portfolio methodsFor: 'visitor - private' stamp: 'ap 10/22/2018 22:13:25'!
accept: aVisitor

	^aVisitor visitPortfolio: self! !

!Portfolio methodsFor: 'visitor - private' stamp: 'ap 10/22/2018 22:19:58'!
visitAccountsWith: aVisitor

 accounts do: [ :anAccount | (anAccount accept: aVisitor )]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'PortfolioTreePrinter-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:33:13'!
with: leftAccount with: rightAccount

	^ self withAll: (Array with: leftAccount with: rightAccount)! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:40:55'!
withAll: aCollectionOfAccounts

	self checkCreationPreconditions: aCollectionOfAccounts.
	
	^self new initializeWithAll: aCollectionOfAccounts ! !


!Portfolio class methodsFor: 'assertions' stamp: 'HAW 10/18/2018 16:31:24'!
check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts

	^ aCollectionOfAccounts do: [ :targetAccount | 
			(sourceAccount = targetAccount) not ifTrue: [ 
				(sourceAccount doesManage: targetAccount) ifTrue: [ self error: self accountAlreadyManagedErrorMessage ] ] ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkAccountsAreUnique: aCollectionOfAccounts

	aCollectionOfAccounts asSet size = aCollectionOfAccounts size
		ifFalse: [ self error: self accountAlreadyManagedErrorMessage ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkCreationPreconditions: aCollectionOfAccounts

	self checkAccountsAreUnique: aCollectionOfAccounts.
	self checkNoCircularReferencesIn: aCollectionOfAccounts! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
checkNoCircularReferencesIn: aCollectionOfAccounts

	aCollectionOfAccounts do: [ :sourceAccount | self check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts ]! !


!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:28'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:27'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!classDefinition: #ReceptiveAccount category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:31:24'!
doesManage: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/18/2018 16:32:05'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 10/18/2018 18:49:23'!
balance

	^ transactions inject: 0 into: [ :balance :transaction | transaction affectBalance: balance ]! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'visitor - private' stamp: 'ap 10/22/2018 22:16:57'!
accept: aVisitor

	^aVisitor visitReceptiveAccount: self! !

!ReceptiveAccount methodsFor: 'visitor - private' stamp: 'ap 10/22/2018 22:20:19'!
visitAccountsWith: aVisitor

 self accept: aVisitor.! !

!ReceptiveAccount methodsFor: 'visitor - private' stamp: 'ap 10/22/2018 22:01:28'!
visitTransactionsWith: aVisitor

 transactions do: [:aTransaction| aTransaction accept: aVisitor] .! !


!classDefinition: #Transfer category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Transfer methodsFor: 'value' stamp: 'APç 10/18/2018 19:39:57'!
depositLeg

	^depositLeg.! !

!Transfer methodsFor: 'value' stamp: 'APç 10/18/2018 18:54:51'!
value
	^value.! !

!Transfer methodsFor: 'value' stamp: 'APç 10/18/2018 19:40:01'!
withdrawLeg

	^withdrawLeg.! !


!Transfer methodsFor: 'initialization' stamp: 'APç 10/18/2018 20:43:32'!
initializeWith: anAmount from: fromAccount to: toAccount


	
	withdrawLeg:=TransferWithdraw register:anAmount on:fromAccount belongingTo: self.
	depositLeg:=TransferDeposit register: anAmount on: toAccount belongingTo: self.
	value:=anAmount.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'PortfolioTreePrinter-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'APç 10/18/2018 19:06:22'!
registerTransferOf: anAmount from: fromAccount to: toAccount

	^self new initializeWith: anAmount from:fromAccount to: toAccount.
	
	! !


!classDefinition: #TreePrinterVisitor category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #TreePrinterVisitor
	instanceVariableNames: 'portfolio dictionary indentation lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TreePrinterVisitor methodsFor: 'initialization' stamp: 'ap 10/22/2018 23:14:27'!
initializeOf: aPortfolio with:aDictionary

	portfolio:=aPortfolio.
	dictionary:=aDictionary.
	indentation:=''.
	lines:=OrderedCollection  new. ! !


!TreePrinterVisitor methodsFor: 'value' stamp: 'ap 10/22/2018 22:31:30'!
value

	portfolio accept: self.
	^lines! !


!TreePrinterVisitor methodsFor: 'visiting' stamp: 'ap 10/22/2018 23:06:51'!
visitPortfolio: aPortfolio 


	lines add: indentation,(dictionary at: aPortfolio).
	
	self doWithIndentation: [aPortfolio visitAccountsWith: self.].
	! !

!TreePrinterVisitor methodsFor: 'visiting' stamp: 'ap 10/22/2018 23:06:46'!
visitReceptiveAccount: aReceptiveAccount

	lines add: indentation,(dictionary at: aReceptiveAccount)! !


!TreePrinterVisitor methodsFor: 'indentation management' stamp: 'ap 10/22/2018 23:24:47'!
doWithIndentation: aBlock

	indentation:=indentation,' '.
	aBlock value.
	indentation:=indentation allButLast.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TreePrinterVisitor class' category: #'PortfolioTreePrinter-Ejercicio'!
TreePrinterVisitor class
	instanceVariableNames: ''!

!TreePrinterVisitor class methodsFor: 'instance creation' stamp: 'ap 10/22/2018 22:33:19'!
of: aPortfolio with:aDictionary


		^self new initializeOf: aPortfolio with: aDictionary .! !
