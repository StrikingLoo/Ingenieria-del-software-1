!classDefinition: #BookOutsideOfCatalogError category: #'25-TusLibros'!
Error subclass: #BookOutsideOfCatalogError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!


!classDefinition: #DuplicateUserError category: #'25-TusLibros'!
Error subclass: #DuplicateUserError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!


!classDefinition: #ExpiredCreditCardError category: #'25-TusLibros'!
Error subclass: #ExpiredCreditCardError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!


!classDefinition: #InvalidAddToCatalogError category: #'25-TusLibros'!
Error subclass: #InvalidAddToCatalogError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!


!classDefinition: #InvalidBookQuantityInCartError category: #'25-TusLibros'!
Error subclass: #InvalidBookQuantityInCartError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!


!classDefinition: #InvalidCartIDError category: #'25-TusLibros'!
Error subclass: #InvalidCartIDError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!


!classDefinition: #InvalidCheckoutError category: #'25-TusLibros'!
Error subclass: #InvalidCheckoutError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!


!classDefinition: #BookstoreOrchestratorTest category: #'25-TusLibros'!
TestCase subclass: #BookstoreOrchestratorTest
	instanceVariableNames: 'exampleCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!
!BookstoreOrchestratorTest commentStamp: '<historical>' prior: 0!
Puede un usuario tener mas de un carrito simultaneamente?  No!! Por suerte, deberiamos modelar cada carrito asociado a un solo usuario, mappeado por el orquestador.
Deberia el carrito conocer su ID y su usuario? No!! El orquestador conoce ambas propiedades del carrito y es el que se encarga de manejar tales interacciones.!


!BookstoreOrchestratorTest methodsFor: 'as yet unclassified' stamp: 'L S 11/7/2019 19:46:18'!
initialize
	| aCatalog |
	aCatalog := PriceCatalog new.
	
	aCatalog add: 1234567890 withPrice: 50.
	aCatalog add: 9876543210 withPrice: 100.
	
	exampleCatalog := aCatalog.! !

!BookstoreOrchestratorTest methodsFor: 'as yet unclassified' stamp: 'L S 11/7/2019 19:51:28'!
test01OrchestratorKnowsCatalog
    |orchestrator|
    orchestrator := BookstoreOrchestrator withCatalog: exampleCatalog.

    self assert: (orchestrator cartsInProcess ) equals: 0! !

!BookstoreOrchestratorTest methodsFor: 'as yet unclassified' stamp: 'L S 11/7/2019 20:10:58'!
test02OrchestratorHasOneCart
    |orchestrator|
    orchestrator := BookstoreOrchestrator withCatalog: exampleCatalog.
    orchestrator addCart: Cart new forUser: 1234.
    self assert: (orchestrator cartsInProcess ) equals: 1.! !

!BookstoreOrchestratorTest methodsFor: 'as yet unclassified' stamp: 'L S 11/7/2019 20:11:33'!
test03AwareOfUsersOnline
    |orchestrator|
    orchestrator := BookstoreOrchestrator withCatalog: exampleCatalog.
    orchestrator addCart: Cart new forUser: 1234.
    self assert: (orchestrator isOnlineUser: 1234 )! !

!BookstoreOrchestratorTest methodsFor: 'as yet unclassified' stamp: 'L S 11/7/2019 20:16:34'!
test04UserCannotHaveTwoCarts
    |orchestrator|
    orchestrator := BookstoreOrchestrator withCatalog: exampleCatalog.
    orchestrator addCart: Cart new forUser: 1234.
    self should: [orchestrator addCart: Cart new forUser: 1234] raise: DuplicateUserError . ! !

!BookstoreOrchestratorTest methodsFor: 'as yet unclassified' stamp: 'L S 11/7/2019 20:34:50'!
test05CanAddBookToCart
    |orchestrator|
    orchestrator := BookstoreOrchestrator withCatalog: exampleCatalog.
    orchestrator addCart: (Cart withCatalog: exampleCatalog ) forUser: 1234.
    orchestrator add: 1 instancesOfBook: 1234567890 toCartId: 1 .
    self assert: ((orchestrator listCart: 1) size) equals: 1! !


!classDefinition: #CartTest category: #'25-TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'exampleCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!

!CartTest methodsFor: 'initialization' stamp: 'C. L. 11/7/2019 12:58:15'!
initialize
	| aCatalog |
	aCatalog := PriceCatalog new.
	
	aCatalog add: 1234567890 withPrice: 50.
	aCatalog add: 9876543210 withPrice: 100.
	
	exampleCatalog := aCatalog.! !


!CartTest methodsFor: 'testing' stamp: 'C. L. 11/7/2019 12:46:57'!
test01CartIsEmptyWhenCreated
	| aCart |
	aCart := Cart withCatalog: exampleCatalog.
	
	self assert: (aCart isEmpty).! !

!CartTest methodsFor: 'testing' stamp: 'C. L. 11/7/2019 12:48:18'!
test02CartIsNotEmptyWhenABookIsAdded
	| aCart |
	
	aCart := Cart withCatalog: exampleCatalog.
	aCart addBook: 1234567890 withQuantity: 1.
	
	self deny: (aCart isEmpty).! !

!CartTest methodsFor: 'testing' stamp: 'C. L. 11/7/2019 12:48:29'!
test03CartContainsBookWhenABookIsAdded
	| aCart bookISBN |
	bookISBN := 1234567890.
	
	aCart := Cart withCatalog: exampleCatalog.
	aCart addBook: bookISBN withQuantity: 1.
	
	self assert: ((aCart listCart at: bookISBN) = 1).! !

!CartTest methodsFor: 'testing' stamp: 'C. L. 11/7/2019 12:48:37'!
test04CartContainsBothBooksWhenTwoDifferentBooksAreAdded
	| aCart bookISBN1 bookISBN2 |
	bookISBN1 := 1234567890.
	bookISBN2 := 9876543210.
	
	aCart := Cart withCatalog: exampleCatalog.
	aCart addBook: bookISBN1 withQuantity: 1.
	aCart addBook: bookISBN2 withQuantity: 1.
	
	self assert: ((aCart listCart at: bookISBN1) = 1).
	self assert: ((aCart listCart at: bookISBN2) = 1).! !

!CartTest methodsFor: 'testing' stamp: 'C. L. 11/7/2019 12:48:43'!
test05CartContainsBothBooksWhenTwoEqualBooksAreAdded
	| aCart bookISBN |
	bookISBN := 1234567890.
	
	aCart := Cart withCatalog: exampleCatalog.
	aCart addBook: bookISBN withQuantity: 1.
	aCart addBook: bookISBN withQuantity: 1.
	
	self assert: ((aCart listCart at: bookISBN) = 2).! !

!CartTest methodsFor: 'testing' stamp: 'C. L. 11/7/2019 12:48:48'!
test06CartContainsAllBooksWhenMultipleBooksAreAddedSimultaneously
	| aCart bookISBN |
	bookISBN := 1234567890.
	
	aCart := Cart withCatalog: exampleCatalog.
	aCart addBook: bookISBN withQuantity: 2.
	
	self assert: ((aCart listCart at: bookISBN) = 2).! !

!CartTest methodsFor: 'testing' stamp: 'C. L. 11/7/2019 12:49:23'!
test07CartRaisesInvalidQuantityErrorWhenTryingToAddLessThan1Book
	| aCart bookISBN |
	bookISBN := 1234567890.
	
	aCart := Cart withCatalog: exampleCatalog.
	self should: [aCart addBook: bookISBN withQuantity: 0] raise: InvalidBookQuantityInCartError .! !

!CartTest methodsFor: 'testing' stamp: 'C. L. 11/7/2019 12:52:58'!
test08TryingToAddABookOutsideOfTheCatalogRaisesAnError
	| aCart bookISBNOutsideTheCatalog |
	bookISBNOutsideTheCatalog := 1112223330.
	
	aCart := Cart withCatalog: exampleCatalog.
	self should: [aCart addBook: bookISBNOutsideTheCatalog withQuantity: 1] raise: BookOutsideOfCatalogError .! !

!CartTest methodsFor: 'testing' stamp: 'C. L. 11/7/2019 13:04:52'!
test09TotalOfPurchasesIsZeroForAnEmptyCart
	| aCart |
	aCart := Cart withCatalog: exampleCatalog.
	self assert: 0 equals: (aCart total).! !

!CartTest methodsFor: 'testing' stamp: 'C. L. 11/7/2019 13:07:28'!
test10TotalOfPurchasesIsCorrectForACartWithABook
	| aCart aBookISBN |
	aBookISBN := 1234567890.
	aCart := Cart withCatalog: exampleCatalog.
	aCart addBook: aBookISBN withQuantity: 1.
	self assert: (exampleCatalog priceOf: aBookISBN) equals: (aCart total).! !

!CartTest methodsFor: 'testing' stamp: 'C. L. 11/7/2019 13:21:19'!
test11TotalOfPurchasesIsCorrectForACartWithManyEqualBooks
	| aCart aBookISBN |
	aBookISBN := 1234567890.
	aCart := Cart withCatalog: exampleCatalog.
	aCart addBook: aBookISBN withQuantity: 2.
	self assert: ((exampleCatalog priceOf: aBookISBN) * 2) equals: (aCart total).! !


!classDefinition: #CreditCardTest category: #'25-TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: 'factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!

!CreditCardTest methodsFor: 'initialization' stamp: 'C. L. 11/7/2019 16:00:42'!
initialize
	factory := TestObjectsFactory new.! !


!CreditCardTest methodsFor: 'testing' stamp: 'C. L. 11/7/2019 16:01:05'!
test01CardWithWrongDigitNumberCannotBeCreated

	self should: [
		CreditCard withNumber: '12341234123' expiresOn: (factory aMonthOfYear) withOwner: 'Nombre Apellido'
	] raise: Error description: 'Invalid Credit Card Number'.
	
	self should: [
		CreditCard withNumber: '1234123412345' expiresOn: (factory aMonthOfYear) withOwner: 'Nombre Apellido'
	] raise: Error description: 'Invalid Credit Card Number'.! !

!CreditCardTest methodsFor: 'testing' stamp: 'C. L. 11/7/2019 16:01:13'!
test02CardWithEmptyOwnerNameCannotBeCreated

	self should: [
		CreditCard withNumber: '123412341234' expiresOn: (factory aMonthOfYear) withOwner: ''
	] raise: Error description: 'Invalid Card Owner Name'.! !

!CreditCardTest methodsFor: 'testing' stamp: 'C. L. 11/7/2019 16:01:23'!
test03CardIsNotExpiredInExpirationMonth
	| cc |
	cc := CreditCard withNumber: '123412341234' expiresOn: (factory aMonthOfYear) withOwner: 'Nombre Apellido'.
	self deny: (cc isExpiredOn: (factory firstDayOfMonth)).! !

!CreditCardTest methodsFor: 'testing' stamp: 'C. L. 11/7/2019 16:01:32'!
test04CardIsExpiredBeforeExpirationMonth
	| cc |
	cc := CreditCard withNumber: '123412341234' expiresOn: (factory aMonthOfYear) withOwner: 'Nombre Apellido'.
	self assert: (cc isExpiredOn: (factory lastDayOfPreviousMonth )).! !


!classDefinition: #PriceCatalogTest category: #'25-TusLibros'!
TestCase subclass: #PriceCatalogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!

!PriceCatalogTest methodsFor: 'as yet unclassified' stamp: 'C. L. 11/7/2019 12:36:32'!
test01AskingForThePriceOfANonExistingProductCausesAnInvalidProductError
	| aPriceCatalog |
	aPriceCatalog := PriceCatalog new.
	self should: [
		aPriceCatalog priceOf: 'Product'
	] raise: InvalidAddToCatalogError.! !

!PriceCatalogTest methodsFor: 'as yet unclassified' stamp: 'C. L. 11/7/2019 12:29:25'!
test02AskingForThePriceOfAnExistingProductShowsTheCorrectPrice
	| aPriceCatalog |
	aPriceCatalog := PriceCatalog new.
	aPriceCatalog add: 'Product' withPrice: 50.
	
	self assert: 50 equals: (aPriceCatalog priceOf: 'Product').! !

!PriceCatalogTest methodsFor: 'as yet unclassified' stamp: 'C. L. 11/7/2019 12:36:32'!
test03AddingAProductWithANegativePriceCausesAnInvalidAddError
	| aPriceCatalog |
	aPriceCatalog := PriceCatalog new.
	self should: [aPriceCatalog add: 'Product' withPrice: -1] raise: InvalidAddToCatalogError .
	! !


!classDefinition: #StoreCashierTest category: #'25-TusLibros'!
TestCase subclass: #StoreCashierTest
	instanceVariableNames: 'exampleCatalog factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!

!StoreCashierTest methodsFor: 'initialization' stamp: 'C. L. 11/7/2019 16:02:19'!
initialize
	| aCatalog |
	aCatalog := PriceCatalog new.
	
	aCatalog add: 1234567890 withPrice: 50.
	aCatalog add: 9876543210 withPrice: 100.
	
	exampleCatalog := aCatalog.
	
	factory := TestObjectsFactory new.! !


!StoreCashierTest methodsFor: 'testing' stamp: 'C. L. 11/7/2019 16:48:34'!
test01CashierRaisesAnErrorWhenTryingToCheckoutAnEmptyCart
	| aCart aCreditCard aMerchantProcessor aCashier |
	aMerchantProcessor := FakeSuccessfulMerchantProcessor.
	aCart := Cart withCatalog: exampleCatalog .
	aCreditCard := CreditCard withNumber: '123412341234' expiresOn: (factory aMonthOfYear ) withOwner: 'Nombre Apellido'.
	aCashier := StoreCashier toCheckout: aCart payingWith: aCreditCard on: (factory firstDayOfMonth ) with: aMerchantProcessor.
	self should: [
		aCashier checkout
	] raise: Error description: 'Cannot Checkout Empty Cart'.! !

!StoreCashierTest methodsFor: 'testing' stamp: 'C. L. 11/7/2019 16:30:01'!
test02ComputesTotalCorrectlyWhenCheckingOutCart
	| aCart aCreditCard aCashier aSuccessfulMerchantProcessor |
	
	aSuccessfulMerchantProcessor := FakeSuccessfulMerchantProcessor new.
	aCart := Cart withCatalog: exampleCatalog .
	aCart addBook: 1234567890 withQuantity: 1.
	aCreditCard := CreditCard withNumber: '123412341234' expiresOn: (factory aMonthOfYear ) withOwner: 'Nombre Apellido'.
	aCashier := StoreCashier toCheckout: aCart payingWith: aCreditCard on: (factory firstDayOfMonth ) with: aSuccessfulMerchantProcessor.
	
	self assert: aCart total equals: aCashier total.! !

!StoreCashierTest methodsFor: 'testing' stamp: 'C. L. 11/7/2019 16:45:50'!
test03CashierCannotCheckoutWithExpiredCreditCard
	| aCart aCreditCard aCashier aSuccessfulMerchantProcessor |
	
	aSuccessfulMerchantProcessor := FakeSuccessfulMerchantProcessor new.
	aCart := Cart withCatalog: exampleCatalog .
	aCart addBook: 1234567890 withQuantity: 1.
	aCreditCard := CreditCard withNumber: '123412341234' expiresOn: (factory aMonthOfYear ) withOwner: 'Nombre Apellido'.
	aCashier := StoreCashier toCheckout: aCart payingWith: aCreditCard on: (factory lastDayOfPreviousMonth ) with: aSuccessfulMerchantProcessor.
	self should: [aCashier checkout] raise: Error description: 'Expired Credit Card'.! !

!StoreCashierTest methodsFor: 'testing' stamp: 'C. L. 11/7/2019 16:42:43'!
test04CashierCancelsValidOperationWhenMerchantProcessorFails
	| aCart aCreditCard aCashier aMerchantProcessorThatFails |
	
	aMerchantProcessorThatFails := FakeFailingMerchantProcessor new.
	aCart := Cart withCatalog: exampleCatalog .
	aCart addBook: 1234567890 withQuantity: 1.
	aCreditCard := CreditCard withNumber: '123412341234' expiresOn: (factory aMonthOfYear ) withOwner: 'Nombre Apellido'.
	aCashier := StoreCashier toCheckout: aCart payingWith: aCreditCard on: (factory firstDayOfMonth) with: aMerchantProcessorThatFails.
	self should: [ aCashier checkout ] raise: Error description: 'Error in Merchant Processor'.! !

!StoreCashierTest methodsFor: 'testing' stamp: 'C. L. 11/7/2019 16:51:32'!
test05CanCheckoutValidOperationWhenMerchantProcessorSucceeds
	| aCart aCreditCard aCashier aMerchantProcessorThatFails |
	
	aMerchantProcessorThatFails := FakeSuccessfulMerchantProcessor new.
	aCart := Cart withCatalog: exampleCatalog .
	aCart addBook: 1234567890 withQuantity: 1.
	aCreditCard := CreditCard withNumber: '123412341234' expiresOn: (factory aMonthOfYear ) withOwner: 'Nombre Apellido'.
	aCashier := StoreCashier toCheckout: aCart payingWith: aCreditCard on: (factory firstDayOfMonth) with: aMerchantProcessorThatFails.
	self shouldnt: [ aCashier checkout ] raise: Error description: 'Error in Merchant Processor'.! !


!classDefinition: #BookstoreOrchestrator category: #'25-TusLibros'!
Object subclass: #BookstoreOrchestrator
	instanceVariableNames: 'carts priceCatalog users'
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!

!BookstoreOrchestrator methodsFor: 'as yet unclassified' stamp: 'L S 11/7/2019 20:30:53'!
add: aQuantity instancesOfBook: aBookISBN toCartId: cartID
    |cart|
    cart := (self cart: cartID).
    cart addBook: aBookISBN withQuantity: aQuantity
    

    ! !

!BookstoreOrchestrator methodsFor: 'as yet unclassified' stamp: 'L S 11/7/2019 20:16:23'!
addCart: aCart forUser: userID
    "seria mejor poder meter una lista de tuplas, pero no encuentro tuplas en smalltalk"
    (self isOnlineUser: userID ) ifTrue: [DuplicateUserError signal].
    carts add: aCart.
    users add: userID! !

!BookstoreOrchestrator methodsFor: 'as yet unclassified' stamp: 'L S 11/7/2019 20:27:58'!
cart: aCartID
    |cart|
    cart := carts at: aCartID ifAbsent: [InvalidCartIDError signal].
    ^cart

    ! !

!BookstoreOrchestrator methodsFor: 'as yet unclassified' stamp: 'L S 11/7/2019 19:49:46'!
cartsInProcess
    ^(carts size)! !

!BookstoreOrchestrator methodsFor: 'as yet unclassified' stamp: 'L S 11/7/2019 20:10:38'!
initializeWithCatalog: aCatalog
	carts := OrderedCollection new.
	users := OrderedCollection new.
	priceCatalog := aCatalog.
	! !

!BookstoreOrchestrator methodsFor: 'as yet unclassified' stamp: 'L S 11/7/2019 20:12:49'!
isOnlineUser: aUserID
    ^(users select: [:anotherUserID| anotherUserID = aUserID ]) size = 1! !

!BookstoreOrchestrator methodsFor: 'as yet unclassified' stamp: 'L S 11/7/2019 20:29:25'!
listCart: aCartID
    ^(self cart: aCartID ) listCart .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BookstoreOrchestrator class' category: #'25-TusLibros'!
BookstoreOrchestrator class
	instanceVariableNames: ''!

!BookstoreOrchestrator class methodsFor: 'as yet unclassified' stamp: 'L S 11/7/2019 19:44:29'!
withCatalog: aCatalog
	^super new initializeWithCatalog: aCatalog.! !


!classDefinition: #Cart category: #'25-TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'books priceCatalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'C. L. 11/7/2019 12:47:57'!
initializeWithCatalog: aCatalog
	books := Dictionary new.
	priceCatalog := aCatalog.! !


!Cart methodsFor: 'checkOut' stamp: 'L S 11/4/2019 21:01:51'!
checkOutWith: aCard writeTo: aLedger
    (aCard validate = 'Valid CC' ) ifTrue:  [
	 aLedger register: books.
      ^0@(aLedger transactionCount)
     ] ifFalse: [
       ^1@(aCard validate)
     ]
    ! !


!Cart methodsFor: 'cartState' stamp: 'C. L. 11/7/2019 12:56:41'!
addBook: aBookISBN withQuantity: aQuantity
	(aQuantity > 0) ifFalse: [InvalidBookQuantityInCartError signal].
	(priceCatalog includesProduct: aBookISBN) ifFalse: [BookOutsideOfCatalogError signal].
	books add: (aBookISBN->((self booksWithISBN: aBookISBN) + aQuantity )).! !

!Cart methodsFor: 'cartState' stamp: 'C. L. 11/7/2019 12:10:14'!
booksWithISBN: aBookISBN
	^(self listCart) at: aBookISBN ifAbsent: [^0].! !

!Cart methodsFor: 'cartState' stamp: 'C. L. 10/31/2019 15:08:21'!
isEmpty
	^books isEmpty.! !

!Cart methodsFor: 'cartState' stamp: 'C. L. 10/31/2019 15:02:16'!
listCart
	^books! !

!Cart methodsFor: 'cartState' stamp: 'C. L. 11/7/2019 13:22:01'!
total
	^((books keys) inject: 0 into: [:acum :aProductName |
		(self booksWithISBN: aProductName ) * (priceCatalog priceOf: aProductName) + acum.
	]).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'25-TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'C. L. 11/7/2019 12:47:29'!
withCatalog: aCatalog
	^super new initializeWithCatalog: aCatalog.! !


!classDefinition: #CreditCard category: #'25-TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'cardNumber expirationMonthOfYear owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'C. L. 11/7/2019 12:00:00'!
initializeWithNumber: aCCN expiresOn: anED withOwner: aCCO
    cardNumber := aCCN .
    owner := aCCO.
    expirationMonthOfYear := anED .
! !


!CreditCard methodsFor: 'card information' stamp: 'C. L. 11/7/2019 15:55:16'!
isExpiredOn: aDate
	^(aDate < (expirationMonthOfYear start date)).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'25-TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'C. L. 11/7/2019 15:41:12'!
withNumber: aCCN expiresOn: anED withOwner: aCCO
	(aCCN size = 12) ifFalse: [self error: 'Invalid Card Number'].
	(aCCO isEmpty) ifTrue: [self error: 'Invalid Card Owner Name'].
	^self new initializeWithNumber: aCCN expiresOn: anED withOwner: aCCO! !


!classDefinition: #FakeMerchantProcessor category: #'25-TusLibros'!
Object subclass: #FakeMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!

!FakeMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'C. L. 11/7/2019 16:38:50'!
doPurchaseOf: aCart payingWith: aCreditCard
	self subclassResponsibility ! !


!classDefinition: #FakeFailingMerchantProcessor category: #'25-TusLibros'!
FakeMerchantProcessor subclass: #FakeFailingMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!

!FakeFailingMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'C. L. 11/7/2019 16:56:18'!
doPurchaseOf: aCart payingWith: aCreditCard
	^('Error in Merchant Processor').! !


!classDefinition: #FakeSuccessfulMerchantProcessor category: #'25-TusLibros'!
FakeMerchantProcessor subclass: #FakeSuccessfulMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!

!FakeSuccessfulMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'C. L. 11/7/2019 16:56:25'!
doPurchaseOf: aCart payingWith: aCreditCard
	^('OK').! !


!classDefinition: #PriceCatalog category: #'25-TusLibros'!
Object subclass: #PriceCatalog
	instanceVariableNames: 'productToPrice'
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!

!PriceCatalog methodsFor: 'price info' stamp: 'C. L. 11/7/2019 12:57:10'!
includesProduct: aProduct
	^productToPrice includesKey: aProduct .! !

!PriceCatalog methodsFor: 'price info' stamp: 'C. L. 11/7/2019 12:36:32'!
priceOf: aProduct
	^productToPrice at: aProduct ifAbsent: [InvalidAddToCatalogError signal].! !


!PriceCatalog methodsFor: 'adding products' stamp: 'C. L. 11/7/2019 12:36:32'!
add: aProduct withPrice: aPrice
	(aPrice < 0) ifTrue: [InvalidAddToCatalogError signal].
	productToPrice at: aProduct put: aPrice ! !


!PriceCatalog methodsFor: 'initialization' stamp: 'C. L. 11/7/2019 12:31:03'!
initialize
	productToPrice := Dictionary new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PriceCatalog class' category: #'25-TusLibros'!
PriceCatalog class
	instanceVariableNames: ''!

!PriceCatalog class methodsFor: 'as yet unclassified' stamp: 'C. L. 11/7/2019 12:31:34'!
new
	^super new initialize.! !


!classDefinition: #StoreCashier category: #'25-TusLibros'!
Object subclass: #StoreCashier
	instanceVariableNames: 'cart creditCard date merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!

!StoreCashier methodsFor: 'initialization' stamp: 'C. L. 11/7/2019 16:27:34'!
initializeToCheckout: aCart payingWith: aCreditCard on: aDate with: aMerchantProcessor 
	cart := aCart.
	creditCard := aCreditCard. 
	date := aDate.
	merchantProcessor := aMerchantProcessor! !


!StoreCashier methodsFor: 'checkout information' stamp: 'C. L. 11/7/2019 14:56:32'!
total
	^cart total.! !


!StoreCashier methodsFor: 'as yet unclassified' stamp: 'C. L. 11/7/2019 16:56:46'!
checkout
	| response |
	
	(cart isEmpty) ifTrue: [self error: 'Cannot Checkout Empty Cart'].
	(creditCard isExpiredOn: date) ifTrue: [self error: 'Expirated Credit Card'].
	
	response := merchantProcessor doPurchaseOf: cart payingWith: creditCard .
	(response = 'OK') ifFalse: [self error: response].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StoreCashier class' category: #'25-TusLibros'!
StoreCashier class
	instanceVariableNames: ''!

!StoreCashier class methodsFor: 'instance creation' stamp: 'C. L. 11/7/2019 16:46:13'!
toCheckout: aCart payingWith: aCreditCard on: aDate with: aMerchantProcessor 
	^self new initializeToCheckout: aCart payingWith: aCreditCard on: aDate with: aMerchantProcessor .! !


!classDefinition: #TestObjectsFactory category: #'25-TusLibros'!
Object subclass: #TestObjectsFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!

!TestObjectsFactory methodsFor: 'dates' stamp: 'C. L. 11/7/2019 15:59:28'!
aMonthOfYear
	| aDate |
	aDate := Date today.
	^(aDate month).! !

!TestObjectsFactory methodsFor: 'dates' stamp: 'C. L. 11/7/2019 15:59:44'!
firstDayOfMonth
	^(self aMonthOfYear start date).! !

!TestObjectsFactory methodsFor: 'dates' stamp: 'C. L. 11/7/2019 16:00:00'!
lastDayOfPreviousMonth
	^(self firstDayOfMonth previous).! !
