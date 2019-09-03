!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'L S 9/2/2019 19:45:38'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self doingThis: [:book | book addCustomerNamed: 'John Lennon'.
	     ] toObject: customerBook takesLessMillisecondsThan: 50
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'L S 9/2/2019 19:45:49'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self customerBookWith: paulMcCartney.
	  
	self doingThis: [:book | book removeCustomerNamed: paulMcCartney
		] toObject: customerBook takesLessMillisecondsThan: 100! !

!CustomerBookTest methodsFor: 'testing' stamp: 'L S 9/2/2019 20:43:02'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self try: [ customerBook addCustomerNamed: ''. self fail ]
		ifCatch: Error 
		thenDo: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'L s 9/2/2019 21:29:51'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
	
	johnLennon := 'John Lennon'.
	customerBook := self customerBookWith: johnLennon.
	
	self shouldStillHave: johnLennon 
	AfterDoing: [ customerBook removeCustomerNamed: 'Paul McCartney'. self fail ]
      to: customerBook andCatching: NotFound.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'L S 9/2/2019 20:37:46'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self customerBookWith: paulMcCartney.
	
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self book: customerBook hasTotalCustomers: 1 withActive: 0 andSuspended: 1.
	
	self assertCustomerBook: customerBook hasName: paulMcCartney.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'L S 9/2/2019 20:38:00'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	
	customerBook := self customerBookWith: paulMcCartney.
	
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self book: customerBook hasTotalCustomers: 0 withActive: 0 andSuspended: 0.
	
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'L s 9/2/2019 21:28:56'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |

	johnLennon := 'John Lennon'.
	customerBook := self customerBookWith: johnLennon.
	
	self shouldStillHave: johnLennon 
	AfterDoing: [ customerBook suspendCustomerNamed: 'Paul McCartney'. self fail ]
      to: customerBook andCatching: CantSuspend.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'L s 9/2/2019 21:28:22'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |

	johnLennon := 'John Lennon'.
	customerBook := self customerBookWith: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self shouldStillHave: johnLennon 
	AfterDoing: [ customerBook suspendCustomerNamed: johnLennon. self fail ]
      to: customerBook andCatching: CantSuspend.
! !


!CustomerBookTest methodsFor: 'helpers' stamp: 'LS 9/2/2019 19:17:16'!
assertCustomerBook: customersBook hasName: customerName
    self assert: (customersBook includesCustomerNamed: customerName).! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'LS 9/2/2019 19:24:55'!
assertMillisecondTimeDeltaBetween: timeBefore and: timeAfter lessThan: millisecondsDelta
    self assert: (timeAfter-timeBefore) < (millisecondsDelta * millisecond)! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'L S 9/2/2019 20:36:34'!
book: book hasTotalCustomers: totalCount withActive: activeCount andSuspended: suspendedCount
      self thereAre: totalCount customersIn: book.
	self thereAre: activeCount activeCustomersIn: book.
	self thereAre: suspendedCount suspendedCustomersIn: book.! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'LS 9/2/2019 18:52:15'!
currentTimeMilliseconds
    ^Time millisecondClockValue * millisecond! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'L S 9/2/2019 19:34:23'!
customerBookWith: customerName
    | customerBook |
			
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: customerName.
	^customerBook! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'L S 9/2/2019 19:41:43'!
doingThis: oneArgumentClosure toObject: receiver takesLessMillisecondsThan: millisecondDelta
     
      |timeBefore timeAfter|

      timeBefore := self currentTimeMilliseconds.
	oneArgumentClosure value: receiver.
	timeAfter := self currentTimeMilliseconds.
	
	self assertMillisecondTimeDeltaBetween: timeBefore and: timeAfter lessThan: millisecondDelta! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'L s 9/2/2019 21:26:04'!
shouldStillHave: customerName After: aClosure to: customerBook andCatching: anError
    aClosure on: anError do: [ :theError | 
			self thereAre: 1 customersIn: customerBook.
			self assertCustomerBook: customerBook hasName: customerName ]! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'L s 9/2/2019 21:26:51'!
shouldStillHave: customerName AfterDoing: aClosure to: customerBook andCatching: anError
    aClosure on: anError do: [ :theError | 
			self thereAre: 1 customersIn: customerBook.
			self assertCustomerBook: customerBook hasName: customerName ]! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'LS 9/2/2019 19:28:48'!
thereAre: count activeCustomersIn: customerBook
    self assert: customerBook numberOfActiveCustomers = count! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'LS 9/2/2019 19:17:04'!
thereAre: count customersIn: customerBook
    self assert: customerBook numberOfCustomers = count! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'LS 9/2/2019 19:29:00'!
thereAre: count suspendedCustomersIn: customerBook
    self assert: customerBook numberOfSuspendedCustomers = count! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'L S 9/2/2019 20:41:46'!
try: aClosure ifCatch: anError thenDo: anotherClosure
    aClosure on: anError do: anotherClosure! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'L s 9/2/2019 21:19:28'!
includesCustomerNamed: aName

	^(self isActive: aName) or: ( self isSuspended: aName )! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'L s 9/2/2019 21:19:51'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'L S 9/2/2019 20:46:09'!
isActive: customerName
	^active includes: customerName! !

!CustomerBook methodsFor: 'customer management' stamp: 'L S 9/2/2019 20:46:28'!
isSuspended: customerName
	^suspended includes: customerName! !

!CustomerBook methodsFor: 'customer management' stamp: 'L s 9/2/2019 21:10:29'!
numberOfActiveCustomers
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'L S 9/2/2019 20:46:58'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'L s 9/2/2019 21:07:16'!
remove: customerName from: customerSet
	^customerSet select: [:nameInSet| nameInSet ~~ customerName]! !

!CustomerBook methodsFor: 'customer management' stamp: 'L s 9/2/2019 21:19:59'!
removeCustomerNamed: aName 
	
	(self includesCustomerNamed: aName) ifTrue: [
		active := self remove: aName from: active.
		suspended := self remove: aName from: suspended.
		^aName
		].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'L s 9/2/2019 21:12:43'!
suspendCustomerNamed: aName 
	
	(self isActive: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/2/2019 14:41:10'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists.'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/2/2019 14:41:16'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty.'! !
