!classDefinition: #DuplicatedAccountError category: #'Portfolio-Ejercicio'!
Error subclass: #DuplicatedAccountError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!


!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'L S 10/17/2019 19:06:07'!
test01PortfolioWithEmptyAccountHasNoAmount
    |zeroAmountPortfolio|
    
    zeroAmountPortfolio := Portfolio new.

    zeroAmountPortfolio add: (ReceptiveAccount new).
    self assert: zeroAmountPortfolio balance equals: 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'L S 10/17/2019 19:17:53'!
test02PortfolioWithOneAccountComputesBalanceRight
    |zeroAmountPortfolio anAccount|
    
    zeroAmountPortfolio := Portfolio new.
    anAccount := self accountWithBalance: 100.

    zeroAmountPortfolio add: (anAccount).

    self assert: zeroAmountPortfolio balance equals: 100.! !

!PortfolioTest methodsFor: 'tests' stamp: 'L S 10/17/2019 19:18:04'!
test03PortfolioWithAccountsComputesBalanceRight
    |zeroAmountPortfolio anAccount anotherAccount|
    
    zeroAmountPortfolio := Portfolio new.
    anAccount := self accountWithBalance: 100.

    anotherAccount := self accountWithBalance: 100 .

    zeroAmountPortfolio add: (anAccount).
    zeroAmountPortfolio add: (anotherAccount).

    self assert: zeroAmountPortfolio balance equals: 200.! !

!PortfolioTest methodsFor: 'tests' stamp: 'L S 10/17/2019 19:18:13'!
test04PortfolioWithPortfoliosComputesBalanceRight
    |aPortfolio aSecondPortfolio anAccount anotherAccount|
    
    aPortfolio := Portfolio new.
    aSecondPortfolio := Portfolio new.

    anAccount := self accountWithBalance: 100.

    anotherAccount := self accountWithBalance: 100 .

    aPortfolio add: (anAccount).
    aSecondPortfolio add: (anotherAccount).
    aPortfolio add: aSecondPortfolio .

    self assert: aPortfolio balance equals: 200.! !

!PortfolioTest methodsFor: 'tests' stamp: 'L S 10/17/2019 19:28:09'!
test05PortfolioWithAccountHasTransaction
    |aPortfolio anAccount withdrawal |
    
    aPortfolio := Portfolio new.
    anAccount := ReceptiveAccount new.
    
    withdrawal := Withdraw for: 10.
    anAccount withdraw: withdrawal.
    aPortfolio add: (anAccount).

    self assert: (aPortfolio hasRegistered: withdrawal )! !

!PortfolioTest methodsFor: 'tests' stamp: 'L S 10/17/2019 20:23:22'!
test06PortfolioCannotRepeatAccounts
    |aPortfolio anAccount |
    
    aPortfolio := Portfolio new.
    anAccount := ReceptiveAccount new.

    aPortfolio add: anAccount.
    self should: [aPortfolio add: anAccount ]  raise: DuplicatedAccountError! !

!PortfolioTest methodsFor: 'tests' stamp: 'L S 10/17/2019 20:46:03'!
test07PortfolioCannotRepeatAccountsAmongPortfolios
    |aPortfolio anotherPortfolio anAccount |
    
    aPortfolio := Portfolio new.
    anotherPortfolio := Portfolio new.
    anAccount := ReceptiveAccount new.

    aPortfolio add: anAccount.
    anotherPortfolio add: anAccount.
    self should: [aPortfolio add: anotherPortfolio ]  raise: DuplicatedAccountError.! !


!PortfolioTest methodsFor: 'utils' stamp: 'L S 10/17/2019 19:17:18'!
accountWithBalance: aBalance
    |anAccount|
    anAccount := ReceptiveAccount new.
    Deposit register: 100 on: anAccount .
    ^anAccount ! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'L S 10/17/2019 20:00:08'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'L S 10/17/2019 18:49:42'!
registerOn: anAccount
    
    self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'L S 10/17/2019 18:49:00'!
registerOn: anAccount
    
    anAccount deposit: self! !

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


!Withdraw methodsFor: 'value' stamp: 'L S 10/17/2019 18:48:33'!
registerOn: anAccount
    
    anAccount withdraw: self! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Holding category: #'Portfolio-Ejercicio'!
Object subclass: #Holding
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Holding methodsFor: 'as yet unclassified' stamp: 'L S 10/17/2019 20:14:46'!
add: aHoldee
    self subclassResponsibility ! !

!Holding methodsFor: 'as yet unclassified' stamp: 'L S 10/17/2019 20:14:59'!
balance
    self subclassResponsibility ! !

!Holding methodsFor: 'as yet unclassified' stamp: 'L S 10/17/2019 20:15:11'!
children
    self subclassResponsibility ! !

!Holding methodsFor: 'as yet unclassified' stamp: 'L S 10/17/2019 20:15:48'!
hasRegistered: aTransaction

    self subclassResponsibility ! !

!Holding methodsFor: 'as yet unclassified' stamp: 'L S 10/17/2019 20:16:00'!
initialize
    self subclassResponsibility ! !

!Holding methodsFor: 'as yet unclassified' stamp: 'L S 10/17/2019 20:16:11'!
transactions
    self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Holding subclass: #Portfolio
	instanceVariableNames: 'holdees'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'L S 10/17/2019 20:43:48'!
add: aHoldee
    (self childrenAccounts includes: aHoldee) ifTrue: [DuplicatedAccountError signal].
    (aHoldee childrenAccounts anySatisfy: [:child | self childrenAccounts includes: child ]) ifTrue: [DuplicatedAccountError signal].
    holdees add: aHoldee.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'L S 10/17/2019 20:44:00'!
balance
    ^ holdees sum: [ :aHoldee | aHoldee balance ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'L S 10/17/2019 20:42:19'!
childrenAccounts
    |successors|
    successors := OrderedCollection new.
    holdees collect: [:aHoldee | successors addAll: (aHoldee childrenAccounts)].
    ^successors! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'L S 10/17/2019 19:30:26'!
hasRegistered: aTransaction
    ^ self transactions anySatisfy: [:anotherTransaction | anotherTransaction = aTransaction ]! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'L S 10/17/2019 19:05:24'!
initialize
    holdees := OrderedCollection new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'L S 10/17/2019 19:35:03'!
transactions
    |totalTransactions|
    totalTransactions := OrderedCollection new.
    holdees collect: [:aHoldee | totalTransactions addAll: aHoldee transactions ] .
    ^ totalTransactions! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Holding subclass: #ReceptiveAccount
	instanceVariableNames: 'withdrawals deposits'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'L S 10/17/2019 18:51:44'!
initialize

	deposits := OrderedCollection new.
	withdrawals := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'L S 10/17/2019 18:50:48'!
deposit: aTransaction
    deposits add: aTransaction! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'L S 10/17/2019 18:51:23'!
register: aTransaction

	aTransaction registerOn: self
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'L S 10/17/2019 18:53:13'!
transactions 

	^ (withdrawals, deposits)! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'L S 10/17/2019 18:51:01'!
withdraw: aTransaction
    withdrawals add: aTransaction! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'L S 10/17/2019 18:55:25'!
balance
      |accountBalance|
	accountBalance := deposits sum: [ :aTransaction | aTransaction value ] ifEmpty: [ 0 ].
	accountBalance := accountBalance - (withdrawals sum: [ :aTransaction | aTransaction value ] ifEmpty: [ 0 ]).
	^accountBalance ! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'L S 10/17/2019 18:52:27'!
hasRegistered: aTransaction

	^ (withdrawals includes: aTransaction) or: (deposits includes: aTransaction)
! !


!ReceptiveAccount methodsFor: 'deletable' stamp: 'L S 10/17/2019 20:44:59'!
childrenAccounts
    |children|
    children := OrderedCollection new.
    children add: self.
    ^children! !
