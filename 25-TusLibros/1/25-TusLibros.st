!classDefinition: #InvalidBookQuantityError category: #'25-TusLibros' stamp: 'C. L. 10/31/2019 15:16:08'!
Error subclass: #InvalidBookQuantityError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!


!classDefinition: #CartTest category: #'25-TusLibros' stamp: 'C. L. 10/31/2019 15:16:08'!
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


!classDefinition: #Cart category: #'25-TusLibros' stamp: 'C. L. 10/31/2019 15:16:08'!
Object subclass: #Cart
	instanceVariableNames: 'empty books'
	classVariableNames: ''
	poolDictionaries: ''
	category: '25-TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'C. L. 10/31/2019 15:07:20'!
initialize
	books := Dictionary new! !


!Cart methodsFor: 'as yet unclassified' stamp: 'C. L. 10/31/2019 15:14:27'!
addBook: aBookISBN withQuantity: aQuantity
	(aQuantity > 0) ifFalse: [InvalidBookQuantityError signal].
	books add: (aBookISBN->((self booksWithISBN: aBookISBN) + aQuantity )).! !

!Cart methodsFor: 'as yet unclassified' stamp: 'C. L. 10/31/2019 15:05:22'!
booksWithISBN: aBookISBN
	^books at: aBookISBN ifAbsent: [^0].! !

!Cart methodsFor: 'as yet unclassified' stamp: 'C. L. 10/31/2019 15:08:21'!
isEmpty
	^books isEmpty.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'C. L. 10/31/2019 15:02:16'!
listCart
	^books! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'25-TusLibros' stamp: 'C. L. 10/31/2019 15:16:08'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'C. L. 10/31/2019 14:33:19'!
new
	^super new initialize! !
