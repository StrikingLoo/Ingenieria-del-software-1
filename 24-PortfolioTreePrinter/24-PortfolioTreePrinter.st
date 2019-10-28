!classDefinition: #AccountTreeTest category: #'24-PortfolioTreePrinter'!
TestCase subclass: #AccountTreeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!AccountTreeTest methodsFor: 'testing' stamp: 'C. L. 10/27/2019 18:32:48'!
test01CanGenerateReportForReceptiveAccount
	| anAccount anAccountReporter |
	
	anAccount := ReceptiveAccount new.
	anAccountReporter := AccountTree with: anAccount.
	
	self assert: 'Cuenta anónima\n' equals: anAccountReporter report.! !

!AccountTreeTest methodsFor: 'testing' stamp: 'C. L. 10/27/2019 18:35:36'!
test02CanGenerateReportForEmptyPortfolio
	| aPortfolio anAccountReporter |
	
	aPortfolio := Portfolio with: (ReceptiveAccount named: 'Mi Cuenta') named: 'Mi Portfolio'.
	anAccountReporter := AccountTree with: aPortfolio.
	
	self assert: 'Mi Portfolio\n   Mi Cuenta\n' equals: anAccountReporter report.! !

!AccountTreeTest methodsFor: 'testing' stamp: 'C. L. 10/27/2019 19:22:59'!
test03CanGenerateReportForTwoLevelNesting
	| juanaPortfolio martaPortfolio anAccountReporter reportText |
	
	reportText := 'Marta\n',
					'   Juana\n',
					'      Mi cuenta\n',
					'   Mica\n'.
	
	juanaPortfolio := Portfolio with: (ReceptiveAccount named: 'Mi cuenta') named: 'Juana'.
	martaPortfolio := Portfolio with: juanaPortfolio with: (ReceptiveAccount named: 'Mica') named: 'Marta' .
	anAccountReporter := AccountTree with: martaPortfolio .
	
	self assert: reportText equals: anAccountReporter report.! !


!classDefinition: #PortfolioTest category: #'24-PortfolioTreePrinter'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:15'!
test08PortfolioTransasctionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #'24-PortfolioTreePrinter'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'C. L. 10/27/2019 13:56:42'!
test08TransferMovesMoneyBetweenAccounts 

	| sendingAccount receivingAccount |
	
	sendingAccount := ReceptiveAccount  new.
	Deposit register: 100 on: sendingAccount.
	
	receivingAccount := ReceptiveAccount new.
	TransferBetweenAccounts register: 30 from: sendingAccount to: receivingAccount .	

	self assert: 70 equals: sendingAccount balance .
	self assert: 30 equals: receivingAccount balance .! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'C. L. 10/27/2019 15:27:56'!
test09CanAccessFromTransferToCorrespondingAccountTransactions

	| sendingAccount receivingAccount transfer |
	
	sendingAccount := ReceptiveAccount  new.
	Deposit register: 100 on: sendingAccount.
	
	receivingAccount := ReceptiveAccount new.
	transfer := TransferBetweenAccounts register: 30 from: sendingAccount to: receivingAccount .	

	self assert: (transfer sendingTransaction) transfer equals: transfer.
	self assert: (transfer receivingTransaction) transfer equals: transfer.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'C. L. 10/27/2019 17:51:38'!
test10CanCreateNamedReceptiveAccount
	| anAccount |
	anAccount := ReceptiveAccount named: 'Cuenta de pepe'.
	
	self assert: anAccount accountName equals: 'Cuenta de pepe'.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'C. L. 10/27/2019 17:49:56'!
test11unnamedAccountHasDefaultName
	| anAccount |
	anAccount := ReceptiveAccount new.
	
	self assert: anAccount accountName equals: 'Cuenta anónima'.! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'C. L. 10/27/2019 17:52:42'!
test12CanCreateNamedPortfolio
	| aPortfolio |
	aPortfolio := Portfolio named: 'Portfolio de pepe'.
	
	self assert: aPortfolio accountName equals: 'Portfolio de pepe'.! !


!classDefinition: #SimpleBalanceReporterTest category: #'24-PortfolioTreePrinter'!
TestCase subclass: #SimpleBalanceReporterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!SimpleBalanceReporterTest methodsFor: 'as yet unclassified' stamp: 'C. L. 10/27/2019 18:28:27'!
test01CanGenerateReportForEmptyReceptiveAccount
	| anAccount anAccountReporter |
	
	anAccount := ReceptiveAccount new.
	anAccountReporter := SimpleBalanceReporter with: anAccount.
	
	self assert: 'Balance = 0\n' equals: anAccountReporter report.! !

!SimpleBalanceReporterTest methodsFor: 'as yet unclassified' stamp: 'C. L. 10/27/2019 18:28:27'!
test02CanGenerateReportForReceptiveAccountWithDeposit
	| anAccount anAccountReporter |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 10 on: anAccount.
	anAccountReporter := SimpleBalanceReporter with: anAccount.
	
	self assert: 'Depósito por 10.\nBalance = 10\n' equals: anAccountReporter report.! !

!SimpleBalanceReporterTest methodsFor: 'as yet unclassified' stamp: 'C. L. 10/27/2019 18:28:27'!
test03CanGenerateReportForReceptiveAccountWithDepositAndWithdraw
	| anAccount anAccountReporter |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 50 on: anAccount.
	Withdraw register: 10 on: anAccount.
	anAccountReporter := SimpleBalanceReporter with: anAccount.
	
	self assert: 'Depósito por 50.\nExtracción por 10.\nBalance = 40\n' equals: anAccountReporter report.! !

!SimpleBalanceReporterTest methodsFor: 'as yet unclassified' stamp: 'C. L. 10/27/2019 18:28:27'!
test04CanGenerateReportForEmptyPortfolio
	| aPortfolio anAccountReporter |
	
	aPortfolio := Portfolio new.
	anAccountReporter := SimpleBalanceReporter with: aPortfolio.
	
	self assert: 'Balance = 0\n' equals: anAccountReporter report.! !

!SimpleBalanceReporterTest methodsFor: 'as yet unclassified' stamp: 'C. L. 10/27/2019 18:28:27'!
test05reportForPortfolioWithAccountIsCoherentWithReceptiveAccountReport
	| aPortfolio anAccount accountReporter portfolioReporter |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 50 on: anAccount.
	accountReporter := SimpleBalanceReporter with: anAccount.
	
	aPortfolio := Portfolio new.
	aPortfolio add: anAccount .
	portfolioReporter := SimpleBalanceReporter with: aPortfolio.
	
	self assert: (accountReporter report) equals: (portfolioReporter report).! !

!SimpleBalanceReporterTest methodsFor: 'as yet unclassified' stamp: 'C. L. 10/27/2019 18:28:27'!
test06correctReportForPortfolioWithMoreThan1Account
	| aPortfolio account1 account2 portfolioReporter |
	
	account1 := ReceptiveAccount new.
	Deposit register: 50 on: account1.
	
	account2 := ReceptiveAccount new.
	Deposit register: 40 on: account2.
	
	aPortfolio := Portfolio new.
	aPortfolio add: account1.
	aPortfolio add: account2.
	portfolioReporter := SimpleBalanceReporter with: aPortfolio.
	
	self assert: 'Depósito por 50.\nDepósito por 40.\nBalance = 90\n' equals: (portfolioReporter report).! !

!SimpleBalanceReporterTest methodsFor: 'as yet unclassified' stamp: 'C. L. 10/27/2019 18:28:27'!
test07CanGenerateReportsForReceptiveAccountWithOutgoingTransfer
	| sendingAccount receivingAccount anAccountReporter |
	
	sendingAccount := ReceptiveAccount new.
	receivingAccount := ReceptiveAccount new.
	
	Deposit register: 50 on: sendingAccount.
	TransferBetweenAccounts register: 10 from: sendingAccount to: receivingAccount.
	anAccountReporter := SimpleBalanceReporter with: sendingAccount.
	
	self assert: 'Depósito por 50.\nSalida por transferencia de 10.\nBalance = 40\n' equals: anAccountReporter report.! !

!SimpleBalanceReporterTest methodsFor: 'as yet unclassified' stamp: 'C. L. 10/27/2019 18:28:27'!
test08CanGenerateReportsForReceptiveAccountWithIncomingTransfer
	| sendingAccount receivingAccount anAccountReporter |
	
	sendingAccount := ReceptiveAccount new.
	receivingAccount := ReceptiveAccount new.
	
	Deposit register: 50 on: sendingAccount.
	TransferBetweenAccounts register: 10 from: sendingAccount to: receivingAccount.
	anAccountReporter := SimpleBalanceReporter with: receivingAccount .
	
	self assert: 'Entrada por transferencia de 10.\nBalance = 10\n' equals: anAccountReporter report.! !


!classDefinition: #Account category: #'24-PortfolioTreePrinter'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'initialization' stamp: 'C. L. 10/27/2019 17:46:36'!
initializeNamed: aName
	name := aName.! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !

!Account methodsFor: 'composition' stamp: 'C. L. 10/27/2019 19:26:02'!
onAccountsDo
	self subclassResponsibility ! !


!Account methodsFor: 'account name' stamp: 'C. L. 10/27/2019 17:49:00'!
accountName
	^name! !


!Account methodsFor: 'report handler' stamp: 'C. L. 10/27/2019 19:42:46'!
handleReport: aReporter
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Account class' category: #'24-PortfolioTreePrinter'!
Account class
	instanceVariableNames: ''!

!Account class methodsFor: 'instance creation' stamp: 'C. L. 10/27/2019 17:50:39'!
named: aName
	^super new initializeNamed: aName! !

!Account class methodsFor: 'instance creation' stamp: 'C. L. 10/27/2019 17:51:03'!
new
	^self named: 'Cuenta anónima'! !


!classDefinition: #Portfolio category: #'24-PortfolioTreePrinter'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !

!Portfolio methodsFor: 'transactions' stamp: 'C. L. 10/27/2019 13:24:17'!
transactionsDo: aBlock
	^(self transactions collect: [:aTransaction | aBlock value: aTransaction.]).! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !

!Portfolio methodsFor: 'composition' stamp: 'C. L. 10/27/2019 19:10:33'!
onAccountsDo: aBlock
	^accounts collect: [:anAccount | aBlock value: anAccount.].! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'report handler' stamp: 'C. L. 10/27/2019 19:43:20'!
handleReport: aReporter
	^aReporter reportPortfolio: self.! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'24-PortfolioTreePrinter'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'C. L. 10/27/2019 18:37:08'!
with: anAccount named: aName

	^(self named: aName)
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'C. L. 10/27/2019 19:22:29'!
with: anAccount with: anotherAccount named: aName

	^(self named: aName)
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'24-PortfolioTreePrinter'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'C. L. 10/27/2019 11:11:28'!
transactionsDo: aBlock
	^transactions collect: [:aTransaction | aBlock value: aTransaction.].! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'report handler' stamp: 'C. L. 10/27/2019 19:43:55'!
handleReport: aReporter
	^aReporter reportReceptiveAccount: self! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'C. L. 10/27/2019 19:10:11'!
onAccountsDo: aBlock! !


!classDefinition: #AccountReporter category: #'24-PortfolioTreePrinter'!
Object subclass: #AccountReporter
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!AccountReporter methodsFor: 'initialization' stamp: 'C. L. 10/27/2019 18:00:01'!
initializeWith: anAccount
	account := anAccount.! !


!AccountReporter methodsFor: 'reporting' stamp: 'C. L. 10/27/2019 18:00:18'!
balanceReport
	^'Balance = ', (account balance asString), '\n'.! !

!AccountReporter methodsFor: 'reporting' stamp: 'C. L. 10/27/2019 20:04:13'!
reportBalance
	^self subclassResponsibility ! !


!AccountReporter methodsFor: 'reporting - accounts' stamp: 'C. L. 10/27/2019 19:44:36'!
reportPortfolio: aPortfolio
	self subclassResponsibility ! !

!AccountReporter methodsFor: 'reporting - accounts' stamp: 'C. L. 10/27/2019 19:45:46'!
reportReceptiveAccount: aReceptiveAccount
	self subclassResponsibility ! !


!AccountReporter methodsFor: 'reporting - transactions' stamp: 'C. L. 10/27/2019 18:21:42'!
reportDepositFor: aDeposit
	^'Depósito por ', (aDeposit value asString), '.\n'.! !

!AccountReporter methodsFor: 'reporting - transactions' stamp: 'C. L. 10/27/2019 18:21:53'!
reportTransferReceivedFor: aTransferReceived
	^'Entrada por transferencia de ', (aTransferReceived value asString), '.\n'.! !

!AccountReporter methodsFor: 'reporting - transactions' stamp: 'C. L. 10/27/2019 18:22:10'!
reportTransferSentFor: aTransferSent
	^'Salida por transferencia de ', (aTransferSent value asString), '.\n'.! !

!AccountReporter methodsFor: 'reporting - transactions' stamp: 'C. L. 10/27/2019 18:22:17'!
reportWithdrawFor: aWithdraw
	^'Extracción por ', (aWithdraw value asString), '.\n'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReporter class' category: #'24-PortfolioTreePrinter'!
AccountReporter class
	instanceVariableNames: ''!

!AccountReporter class methodsFor: 'instance creation' stamp: 'C. L. 10/27/2019 18:06:58'!
with: anAccount
	self new initializeWith: anAccount! !


!classDefinition: #AccountTree category: #'24-PortfolioTreePrinter'!
AccountReporter subclass: #AccountTree
	instanceVariableNames: 'initialSpaces'
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!AccountTree methodsFor: 'reporting' stamp: 'C. L. 10/27/2019 19:02:25'!
addSpaces: aLine
	| spacesAsString |
	spacesAsString := ''.
	1 to: initialSpaces do: [:index | spacesAsString := spacesAsString, ' '].
	^spacesAsString, aLine.! !

!AccountTree methodsFor: 'reporting' stamp: 'C. L. 10/27/2019 20:03:52'!
report
	| childrenReports |
	childrenReports := ''.
	account onAccountsDo: [ :aChild | childrenReports := childrenReports, (aChild handleReport: self)].
	^(self reportName), childrenReports, (self reportBalance).! !

!AccountTree methodsFor: 'reporting' stamp: 'C. L. 10/27/2019 19:51:50'!
reportAccount: anAccount
	| aReporter |
	aReporter := (self class) with: anAccount withSpaces: (initialSpaces + 3).
	^aReporter report.! !

!AccountTree methodsFor: 'reporting' stamp: 'C. L. 10/27/2019 20:05:12'!
reportBalance
	^''! !

!AccountTree methodsFor: 'reporting' stamp: 'C. L. 10/27/2019 19:35:52'!
reportName
	^ (self addSpaces: (account accountName, '\n')).! !

!AccountTree methodsFor: 'reporting' stamp: 'C. L. 10/27/2019 19:52:14'!
reportPortfolio: aPortfolio
	^(self reportAccount: aPortfolio).! !

!AccountTree methodsFor: 'reporting' stamp: 'C. L. 10/27/2019 19:53:43'!
reportReceptiveAccount: aReceptiveAccount
	^(self reportAccount: aReceptiveAccount).! !


!AccountTree methodsFor: 'initialization' stamp: 'C. L. 10/27/2019 18:02:29'!
initializeWithAccount: anAccount withSpaces: anAmountOfSpaces
	super initializeWith: anAccount.
	initialSpaces := anAmountOfSpaces .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTree class' category: #'24-PortfolioTreePrinter'!
AccountTree class
	instanceVariableNames: 'initialSpaces'!

!AccountTree class methodsFor: 'instance creation' stamp: 'C. L. 10/27/2019 18:05:39'!
with: anAccount
	^self with: anAccount withSpaces: 0.! !

!AccountTree class methodsFor: 'instance creation' stamp: 'C. L. 10/27/2019 18:09:39'!
with: anAccount withSpaces: anAmountOfSpaces
	^super new initializeWithAccount: anAccount withSpaces: anAmountOfSpaces .! !


!classDefinition: #SimpleBalanceReporter category: #'24-PortfolioTreePrinter'!
AccountReporter subclass: #SimpleBalanceReporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!SimpleBalanceReporter methodsFor: 'reporting' stamp: 'C. L. 10/27/2019 20:09:03'!
report
	| childrenReports childrenReportAsString |
	
	childrenReports := (account transactionsDo: [:aTransaction | aTransaction handleReportFor: self]).
	
	childrenReportAsString := ''.
	childrenReports do: [:aChildReport | childrenReportAsString := childrenReportAsString, aChildReport.].
	
	^childrenReportAsString, self reportBalance.! !

!SimpleBalanceReporter methodsFor: 'reporting' stamp: 'C. L. 10/27/2019 20:09:15'!
reportBalance
	^'Balance = ', (account balance asString), '\n'.! !

!SimpleBalanceReporter methodsFor: 'reporting' stamp: 'C. L. 10/27/2019 20:09:29'!
reportName
	^''.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SimpleBalanceReporter class' category: #'24-PortfolioTreePrinter'!
SimpleBalanceReporter class
	instanceVariableNames: ''!

!SimpleBalanceReporter class methodsFor: 'instance creation' stamp: 'C. L. 10/27/2019 10:40:47'!
with: anAccount
	^self new initializeWith: anAccount .! !


!classDefinition: #AccountTransaction category: #'24-PortfolioTreePrinter'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'report handler' stamp: 'C. L. 10/27/2019 17:14:58'!
handleReportFor: aReporter
	self subclassResponsibility .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'24-PortfolioTreePrinter'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'24-PortfolioTreePrinter'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'report handler' stamp: 'C. L. 10/27/2019 17:18:50'!
handleReportFor: aReporter
	^aReporter reportDepositFor: self.
	! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'24-PortfolioTreePrinter'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferReceived category: #'24-PortfolioTreePrinter'!
AccountTransaction subclass: #TransferReceived
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!TransferReceived methodsFor: 'value' stamp: 'C. L. 10/27/2019 15:13:09'!
value
	^(transfer value).! !


!TransferReceived methodsFor: 'initialization' stamp: 'C. L. 10/27/2019 14:13:21'!
initializeFor: aTransfer

	transfer := aTransfer ! !


!TransferReceived methodsFor: 'testing' stamp: 'C. L. 10/27/2019 15:28:19'!
transfer
	^transfer! !


!TransferReceived methodsFor: 'report handler' stamp: 'C. L. 10/27/2019 17:20:21'!
handleReportFor: aReporter
	^aReporter reportTransferReceivedFor: self.! !


!TransferReceived methodsFor: 'balance' stamp: 'C. L. 10/27/2019 14:44:09'!
affectBalance: aBalance
	| delta |
	delta := (self value).
	^aBalance + delta.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferReceived class' category: #'24-PortfolioTreePrinter'!
TransferReceived class
	instanceVariableNames: ''!

!TransferReceived class methodsFor: 'instance creation' stamp: 'C. L. 10/27/2019 14:12:15'!
for: aTransfer

	^ self new initializeFor: aTransfer ! !


!classDefinition: #TransferSent category: #'24-PortfolioTreePrinter'!
AccountTransaction subclass: #TransferSent
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!TransferSent methodsFor: 'initialization' stamp: 'C. L. 10/27/2019 14:13:34'!
initializeFor: aTransfer

	transfer := aTransfer ! !


!TransferSent methodsFor: 'balance' stamp: 'C. L. 10/27/2019 14:33:12'!
affectBalance: aBalance

	^aBalance - (self value).! !


!TransferSent methodsFor: 'testing' stamp: 'C. L. 10/27/2019 15:28:29'!
transfer
	^transfer! !


!TransferSent methodsFor: 'report handler' stamp: 'C. L. 10/27/2019 17:17:56'!
handleReportFor: aReporter
	^aReporter reportTransferSentFor: self.! !


!TransferSent methodsFor: 'value' stamp: 'C. L. 10/27/2019 15:13:15'!
value
	^(transfer value).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferSent class' category: #'24-PortfolioTreePrinter'!
TransferSent class
	instanceVariableNames: ''!

!TransferSent class methodsFor: 'instance creation' stamp: 'C. L. 10/27/2019 14:12:24'!
for: aTransfer

	^ self new initializeFor: aTransfer ! !


!classDefinition: #Withdraw category: #'24-PortfolioTreePrinter'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'report handler' stamp: 'C. L. 10/27/2019 17:20:08'!
handleReportFor: aReporter
	^aReporter reportWithdrawFor: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'24-PortfolioTreePrinter'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferBetweenAccounts category: #'24-PortfolioTreePrinter'!
Object subclass: #TransferBetweenAccounts
	instanceVariableNames: 'value sendingTransaction receivingTransaction'
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!TransferBetweenAccounts methodsFor: 'initialization' stamp: 'C. L. 10/27/2019 15:12:42'!
initializeFrom: aSendingTransaction to: aReceivingTransaction
	sendingTransaction := aSendingTransaction .
	receivingTransaction := aReceivingTransaction .! !

!TransferBetweenAccounts methodsFor: 'initialization' stamp: 'C. L. 10/27/2019 15:10:48'!
initializeWith: aValue
	value := aValue.! !


!TransferBetweenAccounts methodsFor: 'value' stamp: 'C. L. 10/27/2019 14:53:48'!
value
	^value.! !


!TransferBetweenAccounts methodsFor: 'testing' stamp: 'C. L. 10/27/2019 15:23:15'!
receivingTransaction
	^receivingTransaction ! !

!TransferBetweenAccounts methodsFor: 'testing' stamp: 'C. L. 10/27/2019 15:23:05'!
sendingTransaction
	^sendingTransaction ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferBetweenAccounts class' category: #'24-PortfolioTreePrinter'!
TransferBetweenAccounts class
	instanceVariableNames: ''!

!TransferBetweenAccounts class methodsFor: 'instance creation' stamp: 'C. L. 10/27/2019 15:11:47'!
register: aValue from: senderAccount to: receiverAccount

	| transaction sendingTransaction receivingTransaction |
	
	transaction := self for: aValue.
	
	sendingTransaction := TransferSent for: transaction.
	receivingTransaction := TransferReceived for: transaction.
	
	transaction initializeFrom: sendingTransaction to: receivingTransaction .
	
	senderAccount register: sendingTransaction.
	receiverAccount register: receivingTransaction.
	
	^ transaction! !


!TransferBetweenAccounts class methodsFor: 'instance creation - private' stamp: 'C. L. 10/27/2019 15:10:30'!
for: aValue
	^self new initializeWith: aValue.! !
