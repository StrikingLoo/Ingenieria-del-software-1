!classDefinition: #BookstoreFacadeTest category: #TusLibros stamp: 'C. L. 11/18/2019 22:11:51'!
TestCase subclass: #BookstoreFacadeTest
	instanceVariableNames: 'exampleCatalog factory clock debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
!BookstoreFacadeTest commentStamp: '<historical>' prior: 0!
Puede un usuario tener mas de un carrito simultaneamente?  No!! Por suerte, deberiamos modelar cada carrito asociado a un solo usuario, mappeado por el orquestador.
Deberia el carrito conocer su ID y su usuario? No!! El orquestador conoce ambas propiedades del carrito y es el que se encarga de manejar tales interacciones.!


!BookstoreFacadeTest methodsFor: 'initialization' stamp: 'C. L. 11/18/2019 12:48:56'!
initialize
	factory := StoreTestObjectsFactory new.
	clock := FakeClock now: (DateAndTime now).
	debitBehavior := [ :anAmount :aCreditCard | ].! !


!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/18/2019 21:42:11'!
test01CreatingACartForANonExistingUserFails
	| bookstore aUserId aPassword |
	bookstore := factory bookstoreInterfaceWithClock: clock withMerchantProcessor: self.
	aUserId := 1234.
	aPassword := 'cambiame'.
	
	self should: [bookstore createCartFor: aUserId withPassword: aPassword]
		raise: (Error - MessageNotUnderstood)
		withMessageText: (BookstoreFacade nonExistentUserErrorMessage).! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/18/2019 12:51:01'!
test02CreatingACartForAUserWithAWrongPasswordFails
	| bookstore aUserId aWrongPassword |
	bookstore := factory bookstoreInterfaceWithClock: clock withMerchantProcessor: self.
	aUserId := factory aValidUser .
	aWrongPassword := 'cambiame'.
	
	self should: [bookstore createCartFor: aUserId withPassword: aWrongPassword]
		raise: (Error - MessageNotUnderstood)
		withMessageText: (BookstoreFacade wrongPasswordErrorMessage).! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/18/2019 22:07:02'!
test03ListingANonExistingCartRaisesAnError
	| bookstore aCartId |
	bookstore := factory bookstoreInterfaceWithClock: clock withMerchantProcessor: self.
	aCartId := 1234.
	
	self should: [bookstore listCart: aCartId]
		raise: (Error - MessageNotUnderstood)
		withMessageText: (BookstoreFacade invalidCartErrorMessage).! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/18/2019 12:51:01'!
test04ListingAnExistingCartWithoutBooksIsEmpty
	| bookstore aCartId |
	bookstore := factory bookstoreInterfaceWithClock: clock withMerchantProcessor: self.
	
	aCartId := bookstore createCartFor: (factory aValidUser) withPassword: (factory aValidPassword).
	self assert: (bookstore listCart: aCartId) isEmpty.! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/18/2019 12:51:01'!
test05ListingAnExistingCartWithABookShowsTheBook
	| bookstore aCartId |
	bookstore := factory bookstoreInterfaceWithClock: clock withMerchantProcessor: self.
	
	aCartId := bookstore createCartFor: (factory aValidUser) withPassword: (factory aValidPassword).
	bookstore add: 1 of: (factory itemSellByTheStore) to: aCartId.
	
	self assert: ((bookstore listCart: aCartId) includes: (factory itemSellByTheStore)).! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/18/2019 22:08:34'!
test06AddingABookToANonExistingCartRaisesAnError
	| bookstore aCartId |
	bookstore := factory bookstoreInterfaceWithClock: clock withMerchantProcessor: self.
	aCartId := 1234.
	
	self should: [bookstore add: 1 of: (factory itemSellByTheStore) to: aCartId]
		raise: (Error - MessageNotUnderstood)
		withMessageText: (BookstoreFacade invalidCartErrorMessage).! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/18/2019 12:51:01'!
test07AddingABookThatIsNotInTheCatalogFails
	| bookstore aCartId |
	bookstore := factory bookstoreInterfaceWithClock: clock withMerchantProcessor: self.
	
	aCartId := bookstore createCartFor: (factory aValidUser) withPassword: (factory aValidPassword).
	self should: [bookstore add: 1 of: (factory itemNotSellByTheStore) to: aCartId]
		raise: (Error - MessageNotUnderstood)
		withMessageText: ((Cart new) invalidItemErrorMessage).! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/18/2019 22:08:50'!
test08AddingABookToACartOnlyAffectsSaidCart
	| bookstore aCartIdWithBooks aCartIdWithoutBooks |
	bookstore := factory bookstoreInterfaceWithClock: clock withMerchantProcessor: self.
	
	aCartIdWithBooks := bookstore createCartFor: (factory aValidUser) withPassword: (factory aValidPassword).
	aCartIdWithoutBooks := bookstore createCartFor: (factory anotherValidUser) withPassword: (factory anotherValidPassword).
	bookstore add: 1 of: (factory itemSellByTheStore) to: aCartIdWithBooks.
	
	self assert: ((bookstore listCart: aCartIdWithBooks) includes: (factory itemSellByTheStore)).
	self deny: ((bookstore listCart: aCartIdWithoutBooks) includes: (factory itemSellByTheStore)).! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/18/2019 13:06:32'!
test09TryingToCheckoutANonExistentCartFails
	| bookstore aCreditCard |
	bookstore := factory bookstoreInterfaceWithClock: clock withMerchantProcessor: self.
	aCreditCard := factory notExpiredCreditCard.
	
	
	self should: [bookstore checkout: 1 through: aCreditCard]
		raise: (Error - MessageNotUnderstood)
		withMessageText: (BookstoreFacade invalidCartErrorMessage).! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/18/2019 22:09:09'!
test10TryingToCheckoutAnEmptyCartFails
	| bookstore aCartId aCreditCard |
	bookstore := factory bookstoreInterfaceWithClock: clock withMerchantProcessor: self.
	aCreditCard := factory notExpiredCreditCard.
	
	aCartId := bookstore createCartFor: (factory aValidUser) withPassword: (factory aValidPassword).
	self should: [bookstore checkout: aCartId through: aCreditCard]
		raise: (Error - MessageNotUnderstood)
		withMessageText: (Cashier cartCanNotBeEmptyErrorMessage).! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/18/2019 22:09:31'!
test11TryingToCheckoutWithExpiredCreditCardFails
	| bookstore aCartId aCreditCard |
	bookstore := factory bookstoreInterfaceWithClock: clock withMerchantProcessor: self.
	aCreditCard := factory expiredCreditCard.
	
	aCartId := bookstore createCartFor: (factory aValidUser) withPassword: (factory aValidPassword).
	bookstore add: 1 of: factory itemSellByTheStore to: aCartId.
	
	self should: [bookstore checkout: aCartId through: aCreditCard]
		raise: (Error - MessageNotUnderstood)
		withMessageText: (Cashier canNotChargeAnExpiredCreditCardErrorMessage).! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/18/2019 22:09:44'!
test12YouCannotListACheckedOutCart
	| bookstore aCartId aCreditCard |
	bookstore := factory bookstoreInterfaceWithClock: clock withMerchantProcessor: self.
	aCreditCard := factory notExpiredCreditCard.
	
	aCartId := bookstore createCartFor: (factory aValidUser) withPassword: (factory aValidPassword).
	bookstore add: 1 of: factory itemSellByTheStore to: aCartId.
	bookstore checkout: aCartId through: aCreditCard.
	
	self should: [bookstore listCart: aCartId]
		raise: (Error - MessageNotUnderstood)
		withMessageText: (BookstoreFacade invalidCartErrorMessage).! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/18/2019 22:10:01'!
test13ListPurchasesOfAnInvalidUserFails
	| bookstore |
	bookstore := factory bookstoreInterfaceWithClock: clock withMerchantProcessor: self.
	
	self should: [bookstore listPurchases: 'usuario invalido']
		raise: (Error - MessageNotUnderstood)
		withMessageText: (BookstoreFacade nonExistentUserErrorMessage ).! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/18/2019 22:10:13'!
test14ListPurchasesOfAUserWithoutPurchasesIsEmpty
	| bookstore |
	bookstore := factory bookstoreInterfaceWithClock: clock withMerchantProcessor: self.
	
	self assert: (bookstore listPurchases: (factory aValidUser)) isEmpty.! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/18/2019 22:10:24'!
test15ListPurchasesOfAUserWithAPurchaseContainsSaidPurchase
	| bookstore aCartId aUserId anItem userPurchases |
	anItem  := factory itemSellByTheStore.
	aUserId := factory aValidUser.
	
	bookstore := factory bookstoreInterfaceWithClock: clock withMerchantProcessor: self.
	aCartId := bookstore createCartFor: aUserId withPassword: (factory aValidPassword).
	
	bookstore add: 1 of: anItem to: aCartId.
	bookstore checkout: aCartId through: (factory notExpiredCreditCard).
	
	userPurchases := bookstore listPurchases: aUserId.
	
	self assert: (userPurchases includes: anItem).
	self assert: (userPurchases occurrencesOf: anItem) = 1.! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/18/2019 22:10:33'!
test16ListPurchasesOfAUserWithManyPurchasesContainsAllOfThem
	| bookstore aCartId anotherCartId aUserId anItem userPurchases |
	anItem  := factory itemSellByTheStore.
	aUserId := factory aValidUser.
	
	bookstore := factory bookstoreInterfaceWithClock: clock withMerchantProcessor: self.
	aCartId := bookstore createCartFor: aUserId withPassword: (factory aValidPassword).
	anotherCartId := bookstore createCartFor: aUserId withPassword: (factory aValidPassword).
	
	bookstore add: 1 of: anItem to: aCartId.
	bookstore add: 1 of: anItem to: anotherCartId.
	bookstore checkout: aCartId through: (factory notExpiredCreditCard).
	bookstore checkout: anotherCartId through: (factory notExpiredCreditCard).
	
	userPurchases := bookstore listPurchases: aUserId.
	
	self assert: (userPurchases includes: anItem).
	self assert: (userPurchases occurrencesOf: anItem) = 2.! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/18/2019 21:31:26'!
test17CheckoutForExpiredCartFails
	| bookstore aCartId |
	bookstore := factory bookstoreInterfaceWithClock: clock withMerchantProcessor: self.
	
	aCartId := bookstore createCartFor: (factory aValidUser) withPassword: (factory aValidPassword).
	bookstore add: 1 of: (factory itemSellByTheStore) to: aCartId.
	self goForwardInTime: (CartSession sessionDuration + (1 minutes)).
	
	self should: [bookstore checkout: aCartId through: (factory notExpiredCreditCard)]
		raise: (Error - MessageNotUnderstood)
		withMessageText: (CartSession expiredSessionErrorMessage).! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/18/2019 21:31:31'!
test18ListCartForExpiredCartFails
	| bookstore aCartId |
	bookstore := factory bookstoreInterfaceWithClock: clock withMerchantProcessor: self.
	
	aCartId := bookstore createCartFor: (factory aValidUser) withPassword: (factory aValidPassword).
	bookstore add: 1 of: (factory itemSellByTheStore) to: aCartId.
	self goForwardInTime: (CartSession sessionDuration + (1 minutes)).
	
	self should: [bookstore listCart: aCartId]
		raise: (Error - MessageNotUnderstood)
		withMessageText: (CartSession expiredSessionErrorMessage).! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/18/2019 22:10:55'!
test19AddingABookToExpiredCartFails
	| bookstore aCartId |
	bookstore := factory bookstoreInterfaceWithClock: clock withMerchantProcessor: self.
	
	aCartId := bookstore createCartFor: (factory aValidUser) withPassword: (factory aValidPassword).
	self goForwardInTime: (CartSession sessionDuration + (1 minutes)).
	
	self should: [bookstore add: 1 of: (factory itemSellByTheStore) to: aCartId]
		raise: (Error - MessageNotUnderstood)
		withMessageText: (CartSession expiredSessionErrorMessage).! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/18/2019 21:31:54'!
test20ListingCartUpdatesCartLastUsage
	| bookstore aCartId |
	bookstore := factory bookstoreInterfaceWithClock: clock withMerchantProcessor: self.
	
	aCartId := bookstore createCartFor: (factory aValidUser) withPassword: (factory aValidPassword).
	self goForwardInTime: (CartSession sessionDuration).
	bookstore listCart: aCartId.
	self goForwardInTime: (CartSession sessionDuration).
	
	self assert: (bookstore listCart: aCartId) isEmpty.! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/18/2019 22:11:10'!
test21AddingABookUpdatesCartLastUsage
	| bookstore aCartId |
	bookstore := factory bookstoreInterfaceWithClock: clock withMerchantProcessor: self.
	
	aCartId := bookstore createCartFor: (factory aValidUser) withPassword: (factory aValidPassword).
	self goForwardInTime: (CartSession sessionDuration).
	bookstore add: 1 of: (factory itemSellByTheStore) to: aCartId.
	self goForwardInTime: (CartSession sessionDuration).
	
	self assert: (bookstore listCart: aCartId) includes: (factory itemSellByTheStore).! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/18/2019 21:56:00'!
test22TheTotalOfPurchasesForAUserIsCorrect
	| bookstore aUserId aCartId total |
	aUserId := factory aValidUser.
	bookstore := factory bookstoreInterfaceWithClock: clock withMerchantProcessor: self.
	
	aCartId := bookstore createCartFor: aUserId withPassword: (factory aValidPassword).
	bookstore add: 1 of: (factory itemSellByTheStore) to: aCartId.
	total := bookstore checkout: aCartId through: (factory notExpiredCreditCard).
	
	self assert: total equals: (bookstore purchasesTotalFor: aUserId).! !

!BookstoreFacadeTest methodsFor: 'testing' stamp: 'C. L. 11/18/2019 22:11:25'!
test23TheTotalForACartIsCorrect
	| bookstore aUserId aCartId |
	aUserId := factory aValidUser.
	bookstore := factory bookstoreInterfaceWithClock: clock withMerchantProcessor: self.
	
	aCartId := bookstore createCartFor: aUserId withPassword: (factory aValidPassword).
	bookstore add: 1 of: (factory itemSellByTheStore) to: aCartId.
	
	self assert: (factory itemSellByTheStorePrice) equals: (bookstore cartTotalFor: aCartId).! !


!BookstoreFacadeTest methodsFor: 'merchant processor protocol' stamp: 'C. L. 11/18/2019 12:59:37'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!BookstoreFacadeTest methodsFor: 'time' stamp: 'C. L. 11/18/2019 12:09:30'!
goForwardInTime: aDuration 
	clock goForwardInTime: aDuration! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BookstoreFacadeTest class' category: #TusLibros stamp: 'C. L. 11/18/2019 22:11:51'!
BookstoreFacadeTest class
	instanceVariableNames: 'factory'!


!classDefinition: #CartTest category: #TusLibros stamp: 'C. L. 11/18/2019 22:11:51'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros stamp: 'C. L. 11/18/2019 22:11:51'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #BookstoreFacade category: #TusLibros stamp: 'C. L. 11/18/2019 22:11:51'!
Object subclass: #BookstoreFacade
	instanceVariableNames: 'catalog sessions validUsers lastCartId purchasesHistory clock merchantProcessor salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!BookstoreFacade methodsFor: 'interface' stamp: 'C. L. 11/18/2019 22:04:28'!
add: aQuantity of: anItem to: aCartId
	self assertValidCart: aCartId.
	(sessions at: aCartId) doToCart: [:cart | cart add: aQuantity of: anItem] withTimestamp: (clock now).! !

!BookstoreFacade methodsFor: 'interface' stamp: 'C. L. 11/18/2019 21:54:54'!
cartTotalFor: aCartId
	^(sessions at: aCartId) doToCart: [:cart | cart total] withTimestamp: (clock now).! !

!BookstoreFacade methodsFor: 'interface' stamp: 'C. L. 11/18/2019 21:56:29'!
checkout: aCartId through: aCreditCard
	| session userId cashier date block total |
	self assertValidCart: aCartId.
	session := sessions at: aCartId.
	userId := session userId.
	date := clock today.
	
	block := [:cart |
		cashier := Cashier
			toCheckout: cart
			charging: aCreditCard
			throught: merchantProcessor
			on: date
			registeringOn: salesBook.
		total := cashier checkOut.
	].
	session doToCart: block withTimestamp: (clock now).
	
	self addAllPurchasesIn: aCartId to: userId.
	sessions removeKey: aCartId.
	^total.! !

!BookstoreFacade methodsFor: 'interface' stamp: 'C. L. 11/18/2019 14:10:41'!
createCartFor: aUserId withPassword: aPassword
	| cartId |
	(validUsers includesKey: aUserId) ifFalse: [self error: (self class nonExistentUserErrorMessage)].
	(aPassword = (validUsers at: aUserId)) ifFalse: [self error: (self class wrongPasswordErrorMessage)].
	
	cartId := self nextCartId.
	sessions at: cartId put: (CartSession for: aUserId acceptingItemsOf: catalog withTimestamp: (clock now)).
	^cartId.! !

!BookstoreFacade methodsFor: 'interface' stamp: 'C. L. 11/18/2019 22:08:14'!
listCart: aCartId
	(sessions includesKey: aCartId) ifFalse: [self error: (self class invalidCartErrorMessage)].
	^(sessions at: aCartId) doToCart: [:cart | cart list] withTimestamp: (clock now).! !

!BookstoreFacade methodsFor: 'interface' stamp: 'C. L. 11/18/2019 00:11:41'!
listPurchases: aUserId 
	(validUsers includesKey: aUserId) ifFalse: [self error: (self class nonExistentUserErrorMessage)].
	^((purchasesHistory at: aUserId ifAbsent: (Bag new)) copy).! !

!BookstoreFacade methodsFor: 'interface' stamp: 'C. L. 11/18/2019 22:02:39'!
purchasesTotalFor: aUserId
	| purchases total |
	purchases := self listPurchases: aUserId.
	total := purchases inject: 0 into: [:acum :anItem | acum + (catalog at: anItem)].
	^total.! !


!BookstoreFacade methodsFor: 'cart id - private' stamp: 'C. L. 11/14/2019 21:10:48'!
nextCartId
	| idToReturn |
	idToReturn := lastCartId.
	lastCartId := lastCartId + 1.
	^idToReturn .! !

!BookstoreFacade methodsFor: 'cart id - private' stamp: 'C. L. 11/17/2019 23:45:32'!
userOfCart: aCartId
	^cartIdToUserId at: aCartId.! !


!BookstoreFacade methodsFor: 'initialization' stamp: 'C. L. 11/18/2019 14:09:56'!
initializeAcceptingItemsOf: aCatalog withUsers: users withMerchantProcessor: aMerchantProcessor withClock: aClock
	catalog := aCatalog.
	validUsers := users.
	
	sessions := Dictionary new.
	purchasesHistory := Dictionary new.
	cartIdToUserId := Dictionary new.
	
	lastCartId := 1.
	
	lastUsage := Dictionary new.
	salesBook := OrderedCollection new.
	
	clock:= aClock.
	merchantProcessor := aMerchantProcessor ! !


!BookstoreFacade methodsFor: 'checkout - private' stamp: 'C. L. 11/18/2019 14:18:37'!
addAllPurchasesIn: aCartId to: aUserId
	| session |
	session := sessions at: aCartId.
	
	self initializeIfAbsentFor: aUserId.
	session doToCart: [:cart | cart onItemsDo: [:anItem | (purchasesHistory at: aUserId) add: anItem].] withTimestamp: (clock now).! !

!BookstoreFacade methodsFor: 'checkout - private' stamp: 'C. L. 11/18/2019 00:10:31'!
initializeIfAbsentFor: aUserId
	(purchasesHistory includesKey: aUserId) ifFalse: [purchasesHistory at: aUserId put: (Bag new)].! !


!BookstoreFacade methodsFor: 'assertions' stamp: 'C. L. 11/18/2019 21:54:00'!
assertValidCart: aCartId
	(sessions includesKey: aCartId) ifFalse: [self error: (self class invalidCartErrorMessage)].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BookstoreFacade class' category: #TusLibros stamp: 'C. L. 11/18/2019 22:11:51'!
BookstoreFacade class
	instanceVariableNames: ''!

!BookstoreFacade class methodsFor: 'error messages' stamp: 'C. L. 11/14/2019 21:15:24'!
cartForUserAlreadyCreatedErrorMessage
	^'A cart is already created for this user'.! !

!BookstoreFacade class methodsFor: 'error messages' stamp: 'C. L. 11/18/2019 12:11:25'!
cartSessionExpiredErrorText
	^'This cart session has expired'! !

!BookstoreFacade class methodsFor: 'error messages' stamp: 'C. L. 11/17/2019 15:24:19'!
emptyCheckoutErrorMessage
	^'You cannot checkout an invalid cart'.! !

!BookstoreFacade class methodsFor: 'error messages' stamp: 'C. L. 11/17/2019 15:29:20'!
expiredCreditCardErrorMessage
	^'You cannot checkout a purchase with an expired credit card'.! !

!BookstoreFacade class methodsFor: 'error messages' stamp: 'C. L. 11/17/2019 15:35:35'!
invalidCartErrorMessage
	^'This cart does not exist in the database'.! !

!BookstoreFacade class methodsFor: 'error messages' stamp: 'C. L. 11/14/2019 20:12:33'!
nonExistentUserErrorMessage
	^'The user does not exist in the database'.! !

!BookstoreFacade class methodsFor: 'error messages' stamp: 'C. L. 11/14/2019 20:12:52'!
wrongPasswordErrorMessage
	^'The password is incorrect'.! !


!BookstoreFacade class methodsFor: 'instance creation' stamp: 'C. L. 11/18/2019 12:57:37'!
acceptingItemsOf: aCatalog withUsers: users withMerchantProcessor: aMerchantProcessor withClock: aClock
	^self new initializeAcceptingItemsOf: aCatalog withUsers: users withMerchantProcessor: aMerchantProcessor withClock: aClock! !


!classDefinition: #Cart category: #TusLibros stamp: 'C. L. 11/18/2019 22:11:51'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'C. L. 11/17/2019 14:24:58'!
list
	^items copy.! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'enumerating' stamp: 'C. L. 11/17/2019 23:54:23'!
onItemsDo: aBlock
	items do: aBlock.! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros stamp: 'C. L. 11/18/2019 22:11:51'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartSession category: #TusLibros stamp: 'C. L. 11/18/2019 22:11:51'!
Object subclass: #CartSession
	instanceVariableNames: 'userId cart lastUsage'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartSession methodsFor: 'initialization' stamp: 'C. L. 11/18/2019 14:06:15'!
initializeFor: aUserId acceptingItemsOf: aCatalog withTimestamp: aTimestamp
	cart := Cart acceptingItemsOf: aCatalog .
	userId := aUserId .
	lastUsage := aTimestamp .! !


!CartSession methodsFor: 'do on cart' stamp: 'C. L. 11/18/2019 21:37:30'!
assertSessionNotExpiredOn: aTimestamp
	(aTimestamp - lastUsage > (self class sessionDuration)) ifTrue: [self error: (self class expiredSessionErrorMessage)].! !

!CartSession methodsFor: 'do on cart' stamp: 'C. L. 11/18/2019 14:13:35'!
doToCart: aBlock withTimestamp: aTimestamp
	self assertSessionNotExpiredOn: aTimestamp.
	lastUsage := aTimestamp .
	^(aBlock value: cart).! !


!CartSession methodsFor: 'query' stamp: 'C. L. 11/18/2019 14:06:32'!
userId
	^userId! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: #TusLibros stamp: 'C. L. 11/18/2019 22:11:51'!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'error messages' stamp: 'C. L. 11/18/2019 14:09:10'!
expiredSessionErrorMessage
	^'This session is expired'.! !


!CartSession class methodsFor: 'session duration' stamp: 'C. L. 11/18/2019 21:30:57'!
sessionDuration
	^(30 minutes).! !


!CartSession class methodsFor: 'instance creation' stamp: 'C. L. 11/18/2019 14:05:39'!
for: aUserId acceptingItemsOf: aCatalog withTimestamp: aTimestamp
	^self new initializeFor: aUserId acceptingItemsOf: aCatalog withTimestamp: aTimestamp! !


!classDefinition: #Cashier category: #TusLibros stamp: 'C. L. 11/18/2019 22:11:51'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros stamp: 'C. L. 11/18/2019 22:11:51'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros stamp: 'C. L. 11/18/2019 22:11:51'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros stamp: 'C. L. 11/18/2019 22:11:51'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #FakeClock category: #TusLibros stamp: 'C. L. 11/18/2019 22:11:51'!
Object subclass: #FakeClock
	instanceVariableNames: 'currentTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!FakeClock methodsFor: 'query' stamp: 'C. L. 11/18/2019 12:05:49'!
now
	^currentTime.! !

!FakeClock methodsFor: 'query' stamp: 'C. L. 11/18/2019 12:06:06'!
today
	^(self now date).! !


!FakeClock methodsFor: 'initialization' stamp: 'C. L. 11/18/2019 12:06:56'!
initializeNow: aTime
	currentTime := aTime! !


!FakeClock methodsFor: 'time manipulation' stamp: 'C. L. 11/18/2019 12:10:40'!
goForwardInTime: aTimeSpan
	currentTime := currentTime + aTimeSpan.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FakeClock class' category: #TusLibros stamp: 'C. L. 11/18/2019 22:11:51'!
FakeClock class
	instanceVariableNames: ''!

!FakeClock class methodsFor: 'as yet unclassified' stamp: 'C. L. 11/18/2019 12:10:15'!
now: aTime
	^self new initializeNow: aTime.! !


!classDefinition: #Sale category: #TusLibros stamp: 'C. L. 11/18/2019 22:11:51'!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros stamp: 'C. L. 11/18/2019 22:11:51'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros stamp: 'C. L. 11/18/2019 22:11:51'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'bookstore' stamp: 'C. L. 11/17/2019 14:17:38'!
aValidPassword
	^'una contrasenia'.! !

!StoreTestObjectsFactory methodsFor: 'bookstore' stamp: 'C. L. 11/17/2019 14:21:54'!
aValidUser
	^'un usuario'.! !

!StoreTestObjectsFactory methodsFor: 'bookstore' stamp: 'C. L. 11/17/2019 14:17:30'!
anotherValidPassword
	^'otra contrasenia'.! !

!StoreTestObjectsFactory methodsFor: 'bookstore' stamp: 'C. L. 11/17/2019 14:22:04'!
anotherValidUser
	^'otro usuario'.! !

!StoreTestObjectsFactory methodsFor: 'bookstore' stamp: 'C. L. 11/18/2019 12:59:03'!
bookstoreInterfaceWithClock: aClock withMerchantProcessor: aMerchantProcessor 
	^BookstoreFacade
		acceptingItemsOf: self defaultCatalog
		withUsers: self defaultUsers
		withMerchantProcessor: aMerchantProcessor
		withClock: aClock.! !

!StoreTestObjectsFactory methodsFor: 'bookstore' stamp: 'C. L. 11/17/2019 14:22:24'!
defaultUsers
	| users |
	users := Dictionary new.
	users at: self aValidUser put: self aValidPassword.
	users at: self anotherValidUser put: self anotherValidPassword.
	^users.! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
