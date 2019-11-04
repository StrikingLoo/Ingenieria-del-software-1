!classDefinition: #InvalidBookQuantityError category: #'25-TusLibros'!
Error subclass: #InvalidBookQuantityError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!


!classDefinition: #CartTest category: #'25-TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!

!CartTest methodsFor: 'testing' stamp: 'C. L. 10/31/2019 14:24:57'!
test01CartIsEmptyWhenCreated
	| aCart |
	aCart := Cart new.
	
	self assert: (aCart isEmpty).! !

!CartTest methodsFor: 'testing' stamp: 'C. L. 10/31/2019 14:29:37'!
test02CartIsNotEmptyWhenABookIsAdded
	| aCart |
	
	aCart := Cart new.
	aCart addBook: 1234567890 withQuantity: 1.
	
	self deny: (aCart isEmpty).! !

!CartTest methodsFor: 'testing' stamp: 'C. L. 10/31/2019 14:46:25'!
test03CartContainsBookWhenABookIsAdded
	| aCart bookISBN |
	bookISBN := 1234567890.
	
	aCart := Cart new.
	aCart addBook: bookISBN withQuantity: 1.
	
	self assert: ((aCart listCart at: bookISBN) = 1).! !

!CartTest methodsFor: 'testing' stamp: 'C. L. 10/31/2019 15:00:20'!
test04CartContainsBothBooksWhenTwoDifferentBooksAreAdded
	| aCart bookISBN1 bookISBN2 |
	bookISBN1 := 1234567890.
	bookISBN2 := 9876543210.
	
	aCart := Cart new.
	aCart addBook: bookISBN1 withQuantity: 1.
	aCart addBook: bookISBN2 withQuantity: 1.
	
	self assert: ((aCart listCart at: bookISBN1) = 1).
	self assert: ((aCart listCart at: bookISBN2) = 1).! !

!CartTest methodsFor: 'testing' stamp: 'C. L. 10/31/2019 15:01:22'!
test05CartContainsBothBooksWhenTwoEqualBooksAreAdded
	| aCart bookISBN |
	bookISBN := 1234567890.
	
	aCart := Cart new.
	aCart addBook: bookISBN withQuantity: 1.
	aCart addBook: bookISBN withQuantity: 1.
	
	self assert: ((aCart listCart at: bookISBN) = 2).! !

!CartTest methodsFor: 'testing' stamp: 'C. L. 10/31/2019 15:09:48'!
test06CartContainsAllBooksWhenMultipleBooksAreAddedSimultaneously
	| aCart bookISBN |
	bookISBN := 1234567890.
	
	aCart := Cart new.
	aCart addBook: bookISBN withQuantity: 2.
	
	self assert: ((aCart listCart at: bookISBN) = 2).! !

!CartTest methodsFor: 'testing' stamp: 'C. L. 10/31/2019 15:13:48'!
test07CartRaisesInvalidQuantityErrorWhenTryingToAddLessThan1Book
	| aCart bookISBN |
	bookISBN := 1234567890.
	
	aCart := Cart new.
	self should: [aCart addBook: bookISBN withQuantity: 0] raise: InvalidBookQuantityError .! !

!CartTest methodsFor: 'testing' stamp: 'L S 11/4/2019 19:59:22'!
test08CartCheckOutInvalidCCTransaction
    |mockCC aCart aLedger transactionResult|
    mockCC := CreditCard withNumber: '12345678124' expiresOn: 2022@09 withOwner: 'Owner McOwnerface'.
    aCart := Cart new.
    aCart addBook: 1234567890 withQuantity: 1.
    aLedger := TransactionsLedger new.
    transactionResult := aCart checkOutWith: mockCC writeTo: aLedger .

    self assert: transactionResult equals: 1@'invalid CC'.
    self assert: (aLedger transactionCount ) equals: 0! !

!CartTest methodsFor: 'testing' stamp: 'L S 11/4/2019 19:56:29'!
test09CartCheckOutOKTransaction
    |mockCC aCart aLedger transactionResult|
    mockCC := CreditCard withNumber: '123456781234' expiresOn: 2022@09 withOwner: 'Owner McOwnerface'.
    aCart := Cart new.
    aCart addBook: 1234567890 withQuantity: 1.
    aLedger := TransactionsLedger new.
    transactionResult := aCart checkOutWith: mockCC writeTo: aLedger .

    self assert: transactionResult equals: 0@1.
    self assert: (aLedger transactionCount ) equals: 1! !

!CartTest methodsFor: 'testing' stamp: 'L S 11/4/2019 20:15:52'!
test10listPurchasesWithOneBook
    |mockCC aCart aLedger transactionResult purchasesList|
    mockCC := CreditCard withNumber: '123456781234' expiresOn: 2022@09 withOwner: 'Owner McOwnerface'.
    aCart := Cart new.
    aCart addBook: 1234567890 withQuantity: 1.
    aLedger := TransactionsLedger new.
    transactionResult := aCart checkOutWith: mockCC writeTo: aLedger .

    purchasesList := aLedger listPurchases .
    self assert: (purchasesList at: 1234567890) equals: 1
! !

!CartTest methodsFor: 'testing' stamp: 'L S 11/4/2019 20:16:50'!
test11listPurchasesWithTwoBooks
    |mockCC aCart aLedger transactionResult purchasesList|
    mockCC := CreditCard withNumber: '123456781234' expiresOn: 2022@09 withOwner: 'Owner McOwnerface'.
    aCart := Cart new.
    aCart addBook: 1234567890 withQuantity: 2.
    aLedger := TransactionsLedger new.
    transactionResult := aCart checkOutWith: mockCC writeTo: aLedger .

    purchasesList := aLedger listPurchases .
    self assert: (purchasesList at: 1234567890) equals: 2
! !

!CartTest methodsFor: 'testing' stamp: 'L S 11/4/2019 20:20:20'!
test12listPurchasesWithTwoDifferentBooks
    |mockCC aCart aLedger transactionResult purchasesList|
    mockCC := CreditCard withNumber: '123456781234' expiresOn: 2022@09 withOwner: 'Owner McOwnerface'.
    aCart := Cart new.
    aCart addBook: 1234567890 withQuantity: 1.

    aCart addBook: 1234567880 withQuantity: 1.
    aLedger := TransactionsLedger new.
    transactionResult := aCart checkOutWith: mockCC writeTo: aLedger .

    purchasesList := aLedger listPurchases .
    self assert: (purchasesList at: 1234567890) equals: 1.
    self assert: (purchasesList at: 1234567880) equals: 1.
    self assert: (aLedger transactionCount ) equals: 1.
! !


!classDefinition: #CreditCardTest category: #'25-TusLibros'!
TestCase subclass: #CreditCardTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'L S 11/4/2019 19:49:18'!
test01CardWithLessThan12DigitsInvalid
    |cc| 
    cc := CreditCard withNumber: '1234' expiresOn: 2017@01  withOwner: 'Nombre Apellido'.
    self assert: cc isValid equals: false! !

!CreditCardTest methodsFor: 'as yet unclassified' stamp: 'L S 11/4/2019 19:55:18'!
test02CardWithEmptyCardHolderNameInvalid
    |cc| 
    cc := CreditCard withNumber: '123412341234' expiresOn: 2017@01  withOwner: ''.
    self assert: cc isValid equals: false.! !


!classDefinition: #Cart category: #'25-TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'empty books'
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'C. L. 10/31/2019 15:07:20'!
initialize
	books := Dictionary new! !


!Cart methodsFor: 'checkOut' stamp: 'L S 11/4/2019 19:59:11'!
checkOutWith: aCard writeTo: aLedger
    (aCard isValid ) ifTrue:  [
	 aLedger register: books.
      ^0@(aLedger transactionCount)
     ] ifFalse: [
       ^1@'invalid CC'
     ]
    ! !


!Cart methodsFor: 'cartState' stamp: 'C. L. 10/31/2019 15:14:27'!
addBook: aBookISBN withQuantity: aQuantity
	(aQuantity > 0) ifFalse: [InvalidBookQuantityError signal].
	books add: (aBookISBN->((self booksWithISBN: aBookISBN) + aQuantity )).! !

!Cart methodsFor: 'cartState' stamp: 'C. L. 10/31/2019 15:05:22'!
booksWithISBN: aBookISBN
	^books at: aBookISBN ifAbsent: [^0].! !

!Cart methodsFor: 'cartState' stamp: 'C. L. 10/31/2019 15:08:21'!
isEmpty
	^books isEmpty.! !

!Cart methodsFor: 'cartState' stamp: 'C. L. 10/31/2019 15:02:16'!
listCart
	^books! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'25-TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'C. L. 10/31/2019 14:33:19'!
new
	^super new initialize! !


!classDefinition: #CreditCard category: #'25-TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'ccn cced cco'
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'L S 11/4/2019 19:15:59'!
initialize
    ! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'L S 11/4/2019 19:18:27'!
initializeWithNumber: aCCN expiresOn: anED withOwner: aCCO
    ccn := aCCN .
    cco := aCCO.
    cced := anED .
! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'L S 11/4/2019 19:51:48'!
isValid
    (ccn size ~= 12) ifTrue: [^false].
    (cco size = 0) ifTrue: [^false].
    ^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'25-TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'L S 11/4/2019 19:34:42'!
withNumber: aCCN expiresOn: anED withOwner: aCCO
    ^self new initializeWithNumber: aCCN expiresOn: anED withOwner: aCCO! !


!classDefinition: #TransactionsLedger category: #'25-TusLibros'!
Object subclass: #TransactionsLedger
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!

!TransactionsLedger methodsFor: 'as yet unclassified' stamp: 'L S 11/4/2019 19:29:12'!
initialize

	transactions := OrderedCollection new.! !

!TransactionsLedger methodsFor: 'as yet unclassified' stamp: 'L S 11/4/2019 20:18:52'!
listPurchases
    |bookCounts|
    bookCounts := Dictionary new.
    transactions collect: [:cartContents| cartContents keys collect: [:key | bookCounts at: key put: ((bookCounts at: key ifAbsent: 0 )+(cartContents at: key)) ]].
    ^bookCounts! !

!TransactionsLedger methodsFor: 'as yet unclassified' stamp: 'L S 11/4/2019 19:38:57'!
register: aTransaction
    transactions add: aTransaction ! !

!TransactionsLedger methodsFor: 'as yet unclassified' stamp: 'L S 11/4/2019 19:40:47'!
transactionCount
    ^transactions size! !
