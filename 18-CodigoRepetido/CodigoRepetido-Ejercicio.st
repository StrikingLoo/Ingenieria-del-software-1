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

!CustomerBookTest methodsFor: 'testing' stamp: 'HernanWilkinson 5/9/2012 18:12'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LS 9/2/2019 19:18:07'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	
	johnLennon := 'John Lennon'.
	customerBook := self customerBookWith: johnLennon.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self thereAre: 1 customersIn: customerBook.
			self assertCustomerBook: customerBook hasName: johnLennon ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LS 9/2/2019 19:31:14'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	customerBook := self customerBookWith: paulMcCartney.
	
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self thereAre: 1 customersIn: customerBook.
	self thereAre: 0 activeCustomersIn: customerBook.
	self thereAre: 1 suspendedCustomersIn: customerBook.
	self assertCustomerBook: customerBook hasName: paulMcCartney.
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LS 9/2/2019 19:30:38'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	paulMcCartney := 'Paul McCartney'.
	
	customerBook := self customerBookWith: paulMcCartney.
	
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self thereAre: 0 activeCustomersIn: customerBook.
	self thereAre: 0 suspendedCustomersIn: customerBook.
	self thereAre: 0 customersIn: customerBook.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LS 9/2/2019 19:18:51'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |

	johnLennon := 'John Lennon'.
	customerBook := self customerBookWith: johnLennon.
	
	[ customerBook suspendCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self thereAre: 1 customersIn: customerBook.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'LS 9/2/2019 19:27:27'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |

	johnLennon := 'John Lennon'.
	customerBook := self customerBookWith: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: johnLennon.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self thereAre: 1 customersIn: customerBook.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!CustomerBookTest methodsFor: 'helpers' stamp: 'LS 9/2/2019 19:17:16'!
assertCustomerBook: customersBook hasName: customerName
    self assert: (customersBook includesCustomerNamed: customerName).! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'LS 9/2/2019 19:24:55'!
assertMillisecondTimeDeltaBetween: timeBefore and: timeAfter lessThan: millisecondsDelta
    self assert: (timeAfter-timeBefore) < (millisecondsDelta * millisecond)! !

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

!CustomerBookTest methodsFor: 'helpers' stamp: 'LS 9/2/2019 19:28:48'!
thereAre: count activeCustomersIn: customerBook
    self assert: customerBook numberOfActiveCustomers = count! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'LS 9/2/2019 19:17:04'!
thereAre: count customersIn: customerBook
    self assert: customerBook numberOfCustomers = count! !

!CustomerBookTest methodsFor: 'helpers' stamp: 'LS 9/2/2019 19:29:00'!
thereAre: count suspendedCustomersIn: customerBook
    self assert: customerBook numberOfSuspendedCustomers = count! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
removeCustomerNamed: aName 
 
	1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
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
