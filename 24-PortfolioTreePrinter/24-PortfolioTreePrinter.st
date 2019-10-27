!classDefinition: #AccountReporterTest category: #'24-PortfolioTreePrinter'!
TestCase subclass: #AccountReporterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!AccountReporterTest methodsFor: 'as yet unclassified' stamp: 'C. L. 10/27/2019 11:25:12'!
test01CanGenerateBalanceReportForEmptyReceptiveAccount
	| anAccount anAccountReporter |
	
	anAccount := ReceptiveAccount new.
	anAccountReporter := AccountReporter with: anAccount.
	
	self assert: 'Balance = 0' equals: anAccountReporter report.! !

!AccountReporterTest methodsFor: 'as yet unclassified' stamp: 'C. L. 10/27/2019 11:25:21'!
test02CanGenerateReportForReceptiveAccountWithDeposit
	| anAccount anAccountReporter |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 10 on: anAccount.
	anAccountReporter := AccountReporter with: anAccount.
	
	self assert: 'Depósito por 10.\nBalance = 10' equals: anAccountReporter report.! !

!AccountReporterTest methodsFor: 'as yet unclassified' stamp: 'C. L. 10/27/2019 11:25:30'!
test03CanGenerateReportForReceptiveAccountWithDepositAndWithdraw
	| anAccount anAccountReporter |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 50 on: anAccount.
	Withdraw register: 10 on: anAccount.
	anAccountReporter := AccountReporter with: anAccount.
	
	self assert: 'Depósito por 50.\nExtracción por 10.\nBalance = 40' equals: anAccountReporter report.! !

!AccountReporterTest methodsFor: 'as yet unclassified' stamp: 'C. L. 10/27/2019 11:31:15'!
test04CanGenerateReportForEmptyPortfolio
	| aPortfolio anAccountReporter |
	
	aPortfolio := Portfolio new.
	anAccountReporter := AccountReporter with: aPortfolio.
	
	self assert: 'Balance = 0' equals: anAccountReporter report.! !

!AccountReporterTest methodsFor: 'as yet unclassified' stamp: 'C. L. 10/27/2019 11:43:02'!
test05reportForPortfolioWithAccountIsCoherentWithReceptiveAccountReport
	| aPortfolio anAccount accountReporter portfolioReporter |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 50 on: anAccount.
	accountReporter := AccountReporter with: anAccount.
	
	aPortfolio := Portfolio new.
	aPortfolio add: anAccount .
	portfolioReporter := AccountReporter with: aPortfolio.
	
	self assert: (accountReporter report) equals: (portfolioReporter report).! !

!AccountReporterTest methodsFor: 'as yet unclassified' stamp: 'C. L. 10/27/2019 13:28:41'!
test06correctReportForPortfolioWithMoreThan1Account
	| aPortfolio account1 account2 portfolioReporter |
	
	account1 := ReceptiveAccount new.
	Deposit register: 50 on: account1.
	
	account2 := ReceptiveAccount new.
	Deposit register: 40 on: account2.
	
	aPortfolio := Portfolio new.
	aPortfolio add: account1.
	aPortfolio add: account2.
	portfolioReporter := AccountReporter with: aPortfolio.
	
	self assert: 'Depósito por 50.\nDepósito por 40.\nBalance = 90' equals: (portfolioReporter report).! !

!AccountReporterTest methodsFor: 'as yet unclassified' stamp: 'C. L. 10/27/2019 15:35:24'!
test07CanGenerateReportsForReceptiveAccountWithOutgoingTransfer
	| sendingAccount receivingAccount anAccountReporter |
	
	sendingAccount := ReceptiveAccount new.
	receivingAccount := ReceptiveAccount new.
	
	Deposit register: 50 on: sendingAccount.
	TransferBetweenAccounts register: 10 from: sendingAccount to: receivingAccount.
	anAccountReporter := AccountReporter with: sendingAccount.
	
	self assert: 'Depósito por 50.\nSalida por transferencia de 10.\nBalance = 40' equals: anAccountReporter report.! !

!AccountReporterTest methodsFor: 'as yet unclassified' stamp: 'C. L. 10/27/2019 15:35:58'!
test08CanGenerateReportsForReceptiveAccountWithIncomingTransfer
	| sendingAccount receivingAccount anAccountReporter |
	
	sendingAccount := ReceptiveAccount new.
	receivingAccount := ReceptiveAccount new.
	
	Deposit register: 50 on: sendingAccount.
	TransferBetweenAccounts register: 10 from: sendingAccount to: receivingAccount.
	anAccountReporter := AccountReporter with: receivingAccount .
	
	self assert: 'Entrada por transferencia de 10.\nBalance = 10' equals: anAccountReporter report.! !


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


!classDefinition: #Account category: #'24-PortfolioTreePrinter'!
Object subclass: #Account
	instanceVariableNames: ''
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


!Account methodsFor: 'reportHandler' stamp: 'C. L. 10/27/2019 11:28:35'!
handleBalanceReport
	^'Balance = ', (self balance asString).! !

!Account methodsFor: 'reportHandler' stamp: 'C. L. 10/27/2019 11:03:14'!
handleReport
	self subclassResponsibility .! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


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


!Portfolio methodsFor: 'composition' stamp: 'C. L. 10/27/2019 11:54:49'!
accountsDo: aBlock
	^accounts collect: [:anAccount | aBlock value: anAccount.].! !

!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'reportHandler' stamp: 'C. L. 10/27/2019 13:23:55'!
handleReport
	| childrenReports childrenReportAsString |
	
	childrenReports := (self transactionsDo: [:aTransaction | aTransaction handleReport]).
	
	childrenReportAsString := ''.
	childrenReports do: [:aChildReport | childrenReportAsString := childrenReportAsString, aChildReport.].
	
	^childrenReportAsString, self handleBalanceReport.! !


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

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
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


!ReceptiveAccount methodsFor: 'reportHandler' stamp: 'C. L. 10/27/2019 11:30:27'!
handleReport
	| transactionsReport transactionsReportAsString balanceReportAsString|
	transactionsReport := self transactionsDo: [:aTransaction | aTransaction handleReport].
	
	transactionsReportAsString := ''.
	transactionsReport do: [:aTransactionReport | transactionsReportAsString := transactionsReportAsString, aTransactionReport.].
	
	balanceReportAsString := self handleBalanceReport .
	
	^transactionsReportAsString, balanceReportAsString.! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!classDefinition: #AccountReporter category: #'24-PortfolioTreePrinter'!
Object subclass: #AccountReporter
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-PortfolioTreePrinter'!

!AccountReporter methodsFor: 'reporting' stamp: 'C. L. 10/27/2019 10:55:04'!
report
	^account handleReport.! !


!AccountReporter methodsFor: 'initialization' stamp: 'C. L. 10/27/2019 10:41:33'!
initializeWith: anAccount
	account := anAccount.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountReporter class' category: #'24-PortfolioTreePrinter'!
AccountReporter class
	instanceVariableNames: ''!

!AccountReporter class methodsFor: 'instance creation' stamp: 'C. L. 10/27/2019 10:40:47'!
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


!AccountTransaction methodsFor: 'reportHandler' stamp: 'C. L. 10/27/2019 10:53:29'!
handleReport
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


!Deposit methodsFor: 'reportHandler' stamp: 'C. L. 10/27/2019 11:21:24'!
handleReport
	^'Depósito por ', (value asString), '.\n'.! !


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


!TransferReceived methodsFor: 'reportHandler' stamp: 'C. L. 10/27/2019 15:39:38'!
handleReport
	^'Entrada por transferencia de ', (self value asString), '.\n'.! !


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


!TransferSent methodsFor: 'reportHandler' stamp: 'C. L. 10/27/2019 15:41:56'!
handleReport
	^'Salida por transferencia de ', (self value asString), '.\n'.! !


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


!Withdraw methodsFor: 'reportHandler' stamp: 'C. L. 10/27/2019 11:23:38'!
handleReport
	^'Extracción por ', (value asString), '.\n'.! !

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

!TransferBetweenAccounts class methodsFor: 'instance creation' stamp: 'C. L. 10/27/2019 15:10:30'!
for: aValue
	^self new initializeWith: aValue.! !

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

