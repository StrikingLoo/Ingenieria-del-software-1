!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'L s 9/19/2019 16:10:52'!
test01EmptyStringFails

    |myStorage finder sentences|

    myStorage := OOStack new.
    finder := SentenceFinderByPrefix new.
    finder sentences: myStorage .
    self should: [sentences := finder find: ''] raise: Error
    
    ! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'L s 9/19/2019 15:48:18'!
test02NoSentencesMatch

    |myStorage finder sentences|

    myStorage := OOStack new.
    myStorage push: 'a sentence'.
    myStorage push: 'another sentence'.
    finder := SentenceFinderByPrefix new.
    finder sentences: myStorage .
    sentences := finder find: 'z'.
    self assert: sentences isEmpty.
    ! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'L s 9/19/2019 15:48:18'!
test03ThreeSentencesMatch

    |myStorage finder sentences|

    myStorage := OOStack new.
    myStorage push: 'a sentence'.
    myStorage push: 'another sentence'.
    myStorage push: 'a last sentence'.
    finder := SentenceFinderByPrefix new.
    finder sentences: myStorage .
    sentences := finder find: 'a'.
    self assert: sentences size = 3.
    ! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'L s 9/19/2019 16:14:09'!
test04MatchingIsCaseSensitive

    |myStorage finder sentences|

    myStorage := OOStack new.
    myStorage push: 'a sentence'.
    myStorage push: 'Another sentence'.
    myStorage push: 'A last sentence'.

    finder := SentenceFinderByPrefix new.
    finder sentences: myStorage .
    sentences := finder find: 'A'.
    self assert: sentences size = 2.
    ! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'L s 9/19/2019 16:15:36'!
test05StorageIsImmutable

    |myStorage finder sentences|

    myStorage := OOStack new.
    myStorage push: 'a sentence'.
    myStorage push: 'Another sentence'.
    myStorage push: 'A last sentence'.

    finder := SentenceFinderByPrefix new.
    finder sentences: myStorage .
    sentences := finder find: 'O'.
    self assert: sentences size = 0.
    self assert: finder size ~= 0.! !


!classDefinition: #EmptyStack category: #'Stack-Exercise'!
Object subclass: #EmptyStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyStack methodsFor: 'as yet unclassified' stamp: 'L s 9/16/2019 20:44:24'!
isEmpty
    ^true! !

!EmptyStack methodsFor: 'as yet unclassified' stamp: 'L s 9/16/2019 21:17:49'!
pop
    ^self error: (OOStack new class stackEmptyErrorDescription)! !

!EmptyStack methodsFor: 'as yet unclassified' stamp: 'L s 9/16/2019 20:26:16'!
size
    ^0! !

!EmptyStack methodsFor: 'as yet unclassified' stamp: 'L s 9/16/2019 21:18:04'!
top
    ^self error: (OOStack new class stackEmptyErrorDescription)! !


!classDefinition: #NonEmptyStack category: #'Stack-Exercise'!
Object subclass: #NonEmptyStack
	instanceVariableNames: 'storage'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NonEmptyStack methodsFor: 'as yet unclassified' stamp: 'L s 9/16/2019 20:47:51'!
initialize
    storage := OrderedCollection new.! !

!NonEmptyStack methodsFor: 'as yet unclassified' stamp: 'L s 9/16/2019 20:44:29'!
isEmpty
    ^false! !

!NonEmptyStack methodsFor: 'as yet unclassified' stamp: 'L s 9/16/2019 20:23:24'!
pop
    | elem |
    elem := storage last.
    storage removeLast.
    
    ^elem.! !

!NonEmptyStack methodsFor: 'as yet unclassified' stamp: 'L s 9/16/2019 20:46:53'!
push: aThing
    storage addLast: aThing.! !

!NonEmptyStack methodsFor: 'as yet unclassified' stamp: 'L s 9/16/2019 20:26:26'!
size
    ^storage size! !

!NonEmptyStack methodsFor: 'as yet unclassified' stamp: 'L s 9/16/2019 20:27:20'!
top
    ^storage last! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'storage'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'L s 9/16/2019 20:42:43'!
initialize
    storage  := EmptyStack new. ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'L s 9/16/2019 20:40:05'!
isEmpty
    ^(storage isEmpty) ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'L s 9/16/2019 20:43:56'!
pop
    |elem|
    (storage size = 1) ifTrue: [
	elem := storage pop.
	storage := EmptyStack new.
	^elem
	].
    ^storage pop
    
    ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'L s 9/16/2019 20:43:48'!
push: aThing
    (storage size = 0) ifTrue: [
	storage := NonEmptyStack new.
	].
    storage push: aThing.
    ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'L s 9/16/2019 20:36:36'!
size
    ^storage size! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'L s 9/16/2019 20:56:40'!
top
    ^storage top! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'storage'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'L s 9/19/2019 16:20:03'!
does: candidateSentence startWith: aPrefix
    ^(candidateSentence size >= aPrefix size) and: (candidateSentence copyFrom: 1 to: aPrefix size) = aPrefix! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'L s 9/19/2019 16:20:25'!
find: aPrefix
    | selectedSentences candidateSentence reservoir |

    (aPrefix = '') ifTrue: [^self error: 'Empty prefix not valid' ].
    selectedSentences := OrderedCollection new.
    reservoir := OOStack new.
    [storage isEmpty ] whileFalse: [
	    candidateSentence := storage pop.
	
	    (self does: candidateSentence startWith: aPrefix ) ifTrue: 
			[selectedSentences add: candidateSentence].

	    reservoir push: candidateSentence.
	].

    storage := reservoir.
    ^ selectedSentences ! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'L s 9/16/2019 21:45:38'!
initialize
    storage := OOStack new.
! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'L s 9/19/2019 15:49:50'!
sentences: aCollectionOfSentences
    storage := aCollectionOfSentences copy! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'L s 9/19/2019 16:14:43'!
size
    ^ storage size.
! !
