!classDefinition: #BookstoreFacadeTest category: #TusLibros!
TestCase subclass: #BookstoreFacadeTest
	instanceVariableNames: 'exampleCatalog factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!
!BookstoreFacadeTest commentStamp: '<historical>' prior: 0!
Puede un usuario tener mas de un carrito simultaneamente?  No!! Por suerte, deberiamos modelar cada carrito asociado a un solo usuario, mappeado por el orquestador.
Deberia el carrito conocer su ID y su usuario? No!! El orquestador conoce ambas propiedades del carrito y es el que se encarga de manejar tales interacciones.!


!BookstoreFacadeTest methodsFor: 'as yet unclassified' stamp: 'L S 11/11/2019 19:09:53'!
test01ANewBookstoreHasNoOnlineCarts
    |bookstore|
    bookstore := factory createBookstore .
    self assert: (bookstore onlineCarts ) equals: 0! !

!BookstoreFacadeTest methodsFor: 'as yet unclassified' stamp: 'L S 11/11/2019 19:18:00'!
test02BookstoreWithAnAddedCartHasOneCart
    |bookstore|

    bookstore := factory createBookstore.
    bookstore addCart: (factory createCart) forUser: 1234 .
    self assert: (bookstore onlineCarts ) equals: 1.! !

!BookstoreFacadeTest methodsFor: 'as yet unclassified' stamp: 'L S 11/11/2019 20:11:08'!
test03AfterCreatingACartForAUserItBecomesOnline
    |bookstore|
    bookstore := factory createBookstore .
    bookstore addCart: (factory createCart ) forUser: 1234.
    self assert: (bookstore isOnlineUser: 1234 )! !

!BookstoreFacadeTest methodsFor: 'as yet unclassified' stamp: 'L S 11/11/2019 18:39:24'!
test04UserCannotHaveTwoCarts
    |bookstore|
    bookstore := factory createBookstore .
    bookstore addCart: (factory createCart ) forUser: 1234.
    self should: [bookstore addCart: Cart new forUser: 1234] raise: Error description: (BookstoreFacade duplicateUserErrorMessage) . ! !

!BookstoreFacadeTest methodsFor: 'as yet unclassified' stamp: 'L S 11/11/2019 18:20:16'!
test05CanAddBookToCart
    |bookstore|
    bookstore := factory createBookstore .
    bookstore addCart: (factory createCart ) forUser: 1234.
    bookstore add: 1 instancesOfBook: (factory itemSellByTheStore) toCartId: 1 .
    self assert: ((bookstore listCart: 1) size) equals: 1! !

!BookstoreFacadeTest methodsFor: 'as yet unclassified' stamp: 'L S 11/11/2019 21:09:15'!
test06ThereIsOneLessOnlineCartAfterCheckout
    |bookstore cartID aCreditCard aMerchantProcessor |
    aCreditCard := factory notExpiredCreditCard .
    aMerchantProcessor := MockedMerchantProcessor new.

    bookstore := factory createBookstore .
    cartID := bookstore addCart: (factory createCart ) forUser: 1234.
    bookstore add: 1 instancesOfBook: (factory itemSellByTheStore) toCartId: cartID.
    bookstore checkout: cartID charging: aCreditCard through: aMerchantProcessor.
    self assert: (bookstore onlineCarts ) equals: 0.
    self deny: (bookstore isOnlineUser: 1234) .! !

!BookstoreFacadeTest methodsFor: 'as yet unclassified' stamp: 'L S 11/11/2019 21:12:15'!
test07TotalForUserIsComputedAfterCheckout
    |bookstore cartID aCreditCard aMerchantProcessor |
    aCreditCard := factory notExpiredCreditCard .
    aMerchantProcessor := MockedMerchantProcessor new.

    bookstore := factory createBookstore .
    cartID := bookstore addCart: (factory createCart ) forUser: 1234.
    bookstore add: 1 instancesOfBook: (factory itemSellByTheStore) toCartId: cartID.
    bookstore checkout: cartID charging: aCreditCard through: aMerchantProcessor.
    self assert: (factory itemSellByTheStorePrice ) equals: (bookstore totalAmountFor: 1234 ).! !

!BookstoreFacadeTest methodsFor: 'as yet unclassified' stamp: 'L S 11/11/2019 21:27:58'!
test08TotalForUserIsComputedAfterManyCheckouts
    |bookstore cartID aCreditCard aMerchantProcessor |
    aCreditCard := factory notExpiredCreditCard .
    aMerchantProcessor := MockedMerchantProcessor new.

    bookstore := factory createBookstore .
    cartID := bookstore addCart: (factory createCart ) forUser: 1234.
    bookstore add: 1 instancesOfBook: (factory itemSellByTheStore) toCartId: cartID.
    bookstore checkout: cartID charging: aCreditCard through: aMerchantProcessor.
    
    cartID := bookstore addCart: (factory createCart ) forUser: 1234.
    bookstore add: 1 instancesOfBook: (factory itemSellByTheStore) toCartId: cartID.
    bookstore checkout: cartID charging: aCreditCard through: aMerchantProcessor.

    self assert: 2*(factory itemSellByTheStorePrice ) equals: (bookstore totalAmountFor: 1234 ).! !

!BookstoreFacadeTest methodsFor: 'as yet unclassified' stamp: 'L S 11/11/2019 21:59:05'!
test09PurchaseHistoryForUserIsComputedAfterSingleCheckout
    |bookstore cartID aCreditCard aMerchantProcessor |
    aCreditCard := factory notExpiredCreditCard .
    aMerchantProcessor := MockedMerchantProcessor new.

    bookstore := factory createBookstore .
    cartID := bookstore addCart: (factory createCart ) forUser: 1234.
    bookstore add: 1 instancesOfBook: (factory itemSellByTheStore) toCartId: cartID.
    bookstore checkout: cartID charging: aCreditCard through: aMerchantProcessor.

    self assert: ((bookstore purchaseHistoryFor: 1234) keys) includes: (factory itemSellByTheStore ).! !


!BookstoreFacadeTest methodsFor: 'initialization' stamp: 'L S 11/11/2019 18:07:45'!
initialize
	factory := StoreTestObjectsFactory new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BookstoreFacadeTest class' category: #TusLibros!
BookstoreFacadeTest class
	instanceVariableNames: ''!

!BookstoreFacadeTest class methodsFor: 'instance creation' stamp: 'L S 11/11/2019 18:08:18'!
new
	^super new initialize.! !


!classDefinition: #CartTest category: #TusLibros!
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


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'L S 11/11/2019 21:04:19'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: (MockedMerchantProcessor new)
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'L S 11/11/2019 21:04:25'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: (MockedMerchantProcessor new)
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'L S 11/11/2019 21:04:31'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: (MockedMerchantProcessor new)
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'L S 11/11/2019 21:04:38'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: (MockedMerchantProcessor new)
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'L S 11/11/2019 20:59:56'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].

	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: (MockedMerchantProcessor withDebitBehavior: debitBehavior )
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'L S 11/11/2019 21:01:08'!
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
		throught: (MockedMerchantProcessor withDebitBehavior: debitBehavior )
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


!classDefinition: #BookstoreFacade category: #TusLibros!
Object subclass: #BookstoreFacade
	instanceVariableNames: 'priceCatalog onlineCarts cartsToUsers userPurchasesNetSum lastCartID userPurchasesHistory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!BookstoreFacade methodsFor: 'checkout' stamp: 'L S 11/11/2019 21:58:50'!
checkout: aCartID charging: aCreditCard through: aMerchantProcessor
    | userID cart cartsHistory |
    userID := cartsToUsers at: aCartID.
    cart := onlineCarts at: aCartID.

    onlineCarts removeKey: aCartID .
    userPurchasesNetSum at: ( userID ) put: ((userPurchasesNetSum at: userID ifAbsent: [0]) + cart total).
    cartsHistory := (userPurchasesHistory at: userID ifAbsent: [OrderedCollection new]).
    cartsHistory add: cart.
    userPurchasesHistory at: userID  put: ( cartsHistory ). 
    cartsToUsers removeKey: aCartID .
    ! !


!BookstoreFacade methodsFor: 'as yet unclassified' stamp: 'L S 11/11/2019 19:11:17'!
add: aQuantity instancesOfBook: aBookISBN toCartId: aCartID
    | cart |
    cart := (self cart: aCartID).
    cart add: aQuantity of: aBookISBN .
    

    ! !

!BookstoreFacade methodsFor: 'as yet unclassified' stamp: 'L S 11/11/2019 19:36:05'!
addCart: aCart forUser: userID
    | thisCartID |
    "seria mejor poder meter una lista de tuplas, pero no encuentro tuplas en smalltalk"
    (self isOnlineUser: userID ) ifTrue: [self error: (self class duplicateUserErrorMessage ) ].
    thisCartID := self nextCartID.

    onlineCarts at: thisCartID put: aCart.
    cartsToUsers at: thisCartID put: userID.
    ^thisCartID.! !

!BookstoreFacade methodsFor: 'as yet unclassified' stamp: 'L S 11/11/2019 18:51:25'!
cart: aCartID
    |cart|
    cart := onlineCarts at: aCartID ifAbsent: [self error: (self class invalidCartIDErrorMessage)].
    ^cart

    ! !

!BookstoreFacade methodsFor: 'as yet unclassified' stamp: 'L S 11/11/2019 21:33:28'!
initializeWithCatalog: aCatalog
	onlineCarts := Dictionary new.
	cartsToUsers := Dictionary new.
	userPurchasesNetSum := Dictionary new.
	userPurchasesHistory := Dictionary new.
	lastCartID := 1.
      priceCatalog := aCatalog.
	! !

!BookstoreFacade methodsFor: 'as yet unclassified' stamp: 'L S 11/11/2019 19:28:26'!
isOnlineUser: aUserID
    ^(cartsToUsers values select: [:anotherUserID| anotherUserID = aUserID ]) size = 1! !

!BookstoreFacade methodsFor: 'as yet unclassified' stamp: 'L S 11/11/2019 18:24:02'!
listCart: aCartID
    ^(self cart: aCartID ) list .! !

!BookstoreFacade methodsFor: 'as yet unclassified' stamp: 'L S 11/11/2019 21:23:34'!
nextCartID
	| cartID |
	cartID := lastCartID.
	lastCartID := (lastCartID + 1).
	^cartID.! !

!BookstoreFacade methodsFor: 'as yet unclassified' stamp: 'L S 11/11/2019 19:09:45'!
onlineCarts
    ^(onlineCarts size)! !

!BookstoreFacade methodsFor: 'as yet unclassified' stamp: 'L S 11/11/2019 21:49:26'!
purchaseHistoryFor: aUserID
    |cartHistory cartsAsDictionaries totalPurchasesHistory|
    cartHistory := userPurchasesHistory at: aUserID ifAbsent: [OrderedCollection new].
    cartsAsDictionaries := cartHistory collect: [:aCart | aCart asDictionary ].
    totalPurchasesHistory := Dictionary new.
    cartsAsDictionaries collect: [:aDictionary | aDictionary keysAndValuesDo: [:key :value | totalPurchasesHistory at: key put: 
		(totalPurchasesHistory at: key ifAbsent: [0]) + value
		]
	].
    ^totalPurchasesHistory 
    ! !

!BookstoreFacade methodsFor: 'as yet unclassified' stamp: 'L S 11/11/2019 21:25:15'!
totalAmountFor: aUserID
    ^userPurchasesNetSum at: aUserID ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BookstoreFacade class' category: #TusLibros!
BookstoreFacade class
	instanceVariableNames: ''!

!BookstoreFacade class methodsFor: 'as yet unclassified' stamp: 'L S 11/7/2019 19:44:29'!
withCatalog: aCatalog
	^super new initializeWithCatalog: aCatalog.! !


!BookstoreFacade class methodsFor: 'error messages' stamp: 'L S 11/11/2019 18:13:04'!
duplicateUserErrorMessage
	^'There cannot be multiple carts for the same user'! !

!BookstoreFacade class methodsFor: 'error messages' stamp: 'L S 11/11/2019 18:44:26'!
invalidCartIDErrorMessage
	^'CartID does not exist'! !


!classDefinition: #Cart category: #TusLibros!
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


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'as yet unclassified' stamp: 'L S 11/11/2019 22:00:04'!
asDictionary
    ^(items )! !

!Cart methodsFor: 'as yet unclassified' stamp: 'L S 11/11/2019 21:42:17'!
list
    ^items ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
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

!classDefinition: 'Cashier class' category: #TusLibros!
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


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !



!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #MockedMerchantProcessor category: #TusLibros!
Object subclass: #MockedMerchantProcessor
	instanceVariableNames: 'debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MockedMerchantProcessor methodsFor: 'initialization' stamp: 'L S 11/11/2019 21:04:01'!
initialize
	debitBehavior := [:amount :creditCard |]! !

!MockedMerchantProcessor methodsFor: 'initialization' stamp: 'L S 11/11/2019 20:57:50'!
initializeWithDebitBehavior: aClause
	debitBehavior := aClause! !


!MockedMerchantProcessor methodsFor: 'debit' stamp: 'L S 11/11/2019 20:56:20'!
debit: anAmount from: aCreditCard 
	^debitBehavior value: anAmount value: aCreditCard .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MockedMerchantProcessor class' category: #TusLibros!
MockedMerchantProcessor class
	instanceVariableNames: ''!

!MockedMerchantProcessor class methodsFor: 'instance creation' stamp: 'L S 11/11/2019 20:57:22'!
withDebitBehavior: aClause
	^self new initializeWithDebitBehavior: aClause.! !


!classDefinition: #Sale category: #TusLibros!
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

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'L S 11/11/2019 20:03:35'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
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


!StoreTestObjectsFactory methodsFor: 'bookstore' stamp: 'L S 11/11/2019 18:39:24'!
createBookstore
	^BookstoreFacade withCatalog: (self defaultCatalog)! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
