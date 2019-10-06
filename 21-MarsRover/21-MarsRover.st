!classDefinition: #MarsRoverInvalidCommand category: #'21-MarsRover'!
Error subclass: #MarsRoverInvalidCommand
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverInvalidCommand class' category: #'21-MarsRover'!
MarsRoverInvalidCommand class
	instanceVariableNames: ''!

!MarsRoverInvalidCommand class methodsFor: 'error message' stamp: 'C. L. 10/6/2019 13:17:40'!
description
	^'The rover received an invalid command.'! !


!classDefinition: #MarsRoverTest category: #'21-MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!MarsRoverTest methodsFor: 'testing' stamp: 'C. L. 10/6/2019 13:48:46'!
test01EmptyCommandSetStaysPut
	| aRover |
	
	aRover := MarsRover atPosition: 0@0 facing: $S.
	
	aRover move: ''.
	
	self assert: 0@0 equals: aRover position.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'C. L. 10/6/2019 13:48:54'!
test02AnFMovesTheRoverForward
	| aRover |
	
	aRover := MarsRover atPosition: 0@0 facing: $S.
	
	aRover move: 'f'.
	
	self assert: 0@-1 equals: aRover position.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'C. L. 10/6/2019 13:49:01'!
test03ABMovesTheRoverBackwards
	| aRover |
	
	aRover := MarsRover atPosition: 0@0 facing: $S.
	
	aRover move: 'b'.
	
	self assert: 0@1 equals: aRover position.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'C. L. 10/6/2019 14:36:08'!
test04AnRRotatesTheRoverClockwise
	| aRover |
	
	aRover := MarsRover atPosition: 0@0 facing: $S.
	
	aRover move: 'r'.
	
	self assert: 0@0 equals: aRover position.
	self assert: $W equals: aRover direction.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'C. L. 10/6/2019 12:03:32'!
test05AnLRotatesTheRoverCounterClockwise
	| aRover |
	
	aRover := MarsRover atPosition: 0@0 facing: $S.
	
	aRover move: 'l'.
	
	self assert: 0@0 equals: aRover position.
	self assert: $E equals: aRover direction.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'C. L. 10/6/2019 13:25:46'!
test06AnInvalidCommandThrowsAnException
	| aRover |
	
	aRover := MarsRover atPosition: 0@0 facing: $S.
	
	self should: [aRover move: 'x'] raise: MarsRoverInvalidCommand.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'C. L. 10/6/2019 13:27:50'!
test07TheRoverCanExecuteMultipleCommands
	| aRover |
	
	aRover := MarsRover atPosition: 0@0 facing: $S.
	
	aRover move: 'ff'.
	
	self assert: (0@-2) equals: aRover position .! !

!MarsRoverTest methodsFor: 'testing' stamp: 'C. L. 10/6/2019 13:32:45'!
test08AnRRotatesTheRoverClockwiseWhenFacingNorth
	| aRover |
	
	aRover := MarsRover atPosition: 0@0 facing: $N.
	
	aRover move: 'r'.
	
	self assert: 0@0 equals: aRover position.
	self assert: $E equals: aRover direction.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'C. L. 10/6/2019 13:52:32'!
test09AnLRotatesTheRoverCounterClockwiseWhenFacingNorth
	| aRover |
	
	aRover := MarsRover atPosition: 0@0 facing: $N.
	
	aRover move: 'l'.
	
	self assert: 0@0 equals: aRover position.
	self assert: $W equals: aRover direction.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'C. L. 10/6/2019 14:03:25'!
test10RotatingAndThenMovingForwardWorks
	| aRover |
	
	aRover := MarsRover atPosition: 0@0 facing: $S.
	
	aRover move: 'lf'.
	
	self assert: 1@0 equals: aRover position.! !

!MarsRoverTest methodsFor: 'testing' stamp: 'C. L. 10/6/2019 14:03:34'!
test11RotatingAndThenMovingBackwardsWorks
	| aRover |
	
	aRover := MarsRover atPosition: 0@0 facing: $S.
	
	aRover move: 'lb'.
	
	self assert: -1@0 equals: aRover position.! !


!classDefinition: #CardinalPoint category: #'21-MarsRover'!
Object subclass: #CardinalPoint
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!CardinalPoint methodsFor: 'modifying' stamp: 'C. L. 10/6/2019 14:22:38'!
rotateCCW
	self subclassResponsibility ! !

!CardinalPoint methodsFor: 'modifying' stamp: 'C. L. 10/6/2019 14:22:36'!
rotateCW
	self subclassResponsibility ! !


!CardinalPoint methodsFor: 'accessing' stamp: 'C. L. 10/6/2019 14:21:59'!
asCharacter
	self subclassResponsibility ! !

!CardinalPoint methodsFor: 'accessing' stamp: 'C. L. 10/6/2019 14:21:51'!
asVector
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalPoint class' category: #'21-MarsRover'!
CardinalPoint class
	instanceVariableNames: ''!

!CardinalPoint class methodsFor: 'instance creation' stamp: 'C. L. 10/6/2019 14:41:12'!
with: aCardinalPointSymbol
	(aCardinalPointSymbol  = $N) ifTrue: [^North new].
	(aCardinalPointSymbol  = $S) ifTrue: [^South new].
	(aCardinalPointSymbol  = $E) ifTrue: [^East new].
	(aCardinalPointSymbol  = $W) ifTrue: [^West new].
	! !


!classDefinition: #East category: #'21-MarsRover'!
CardinalPoint subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!East methodsFor: 'modifying' stamp: 'C. L. 10/6/2019 14:41:38'!
rotateCCW
	^North new.! !

!East methodsFor: 'modifying' stamp: 'C. L. 10/6/2019 14:41:44'!
rotateCW
	^South new.! !


!East methodsFor: 'accessing' stamp: 'C. L. 10/6/2019 14:25:10'!
asCharacter
	^$E.! !

!East methodsFor: 'accessing' stamp: 'C. L. 10/6/2019 14:25:01'!
asVector
	^(1@0)! !


!classDefinition: #North category: #'21-MarsRover'!
CardinalPoint subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!North methodsFor: 'modifying' stamp: 'C. L. 10/6/2019 14:41:51'!
rotateCCW
	^West new.! !

!North methodsFor: 'modifying' stamp: 'C. L. 10/6/2019 14:41:57'!
rotateCW
	^East new.! !


!North methodsFor: 'accessing' stamp: 'C. L. 10/6/2019 14:23:46'!
asCharacter
	^$N.! !

!North methodsFor: 'accessing' stamp: 'C. L. 10/6/2019 14:23:36'!
asVector
	^(0@1).! !


!classDefinition: #South category: #'21-MarsRover'!
CardinalPoint subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!South methodsFor: 'modifying' stamp: 'C. L. 10/6/2019 14:42:04'!
rotateCCW
	^East new.! !

!South methodsFor: 'modifying' stamp: 'C. L. 10/6/2019 14:42:10'!
rotateCW
	^West new.! !


!South methodsFor: 'accessing' stamp: 'C. L. 10/6/2019 14:25:59'!
asCharacter
	^$S.! !

!South methodsFor: 'accessing' stamp: 'C. L. 10/6/2019 14:26:10'!
asVector
	^(0@-1).! !


!classDefinition: #West category: #'21-MarsRover'!
CardinalPoint subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!West methodsFor: 'modifying' stamp: 'C. L. 10/6/2019 14:42:17'!
rotateCCW
	^South new.! !

!West methodsFor: 'modifying' stamp: 'C. L. 10/6/2019 14:42:22'!
rotateCW
	^North new.! !


!West methodsFor: 'accessing' stamp: 'C. L. 10/6/2019 14:25:27'!
asCharacter
	^$W.! !

!West methodsFor: 'accessing' stamp: 'C. L. 10/6/2019 14:25:42'!
asVector
	^(-1@0).! !


!classDefinition: #MarsRover category: #'21-MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction behaviorForCommandDict'
	classVariableNames: ''
	poolDictionaries: ''
	category: '21-MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'C. L. 10/6/2019 14:43:15'!
initializeAtPosition: aStartingPosition facing: aDirection
	position := aStartingPosition .
	direction := CardinalPoint with: aDirection.
	
	behaviorForCommandDict := Dictionary new.
	behaviorForCommandDict add: $f->[position := position + direction asVector].
	behaviorForCommandDict add: $b->[position := position - direction asVector].
	behaviorForCommandDict add: $r->[direction := direction rotateCW].
	behaviorForCommandDict add: $l->[direction := direction rotateCCW].! !


!MarsRover methodsFor: 'moving' stamp: 'C. L. 10/6/2019 14:18:41'!
move: aCommandSequence
	aCommandSequence do: [:aCommand | (self behaviorForCommand: aCommand) value].! !


!MarsRover methodsFor: 'accessing' stamp: 'C. L. 10/6/2019 14:37:29'!
direction
	^direction asCharacter .! !

!MarsRover methodsFor: 'accessing' stamp: 'C. L. 10/6/2019 14:46:13'!
isValidCommand: aCommand
	^( behaviorForCommandDict includesKey: aCommand )! !

!MarsRover methodsFor: 'accessing' stamp: 'C. L. 10/6/2019 11:33:23'!
position
	^position! !


!MarsRover methodsFor: 'private' stamp: 'C. L. 10/6/2019 14:46:13'!
behaviorForCommand: aCommand
	
	(self isValidCommand: aCommand) ifFalse: [MarsRoverInvalidCommand signal].
	^ (behaviorForCommandDict at: aCommand).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'21-MarsRover'!
MarsRover class
	instanceVariableNames: 'position'!

!MarsRover class methodsFor: 'instance creation' stamp: 'C. L. 10/6/2019 11:30:29'!
atPosition: aStartingPosition facing: aDirection 
	^self new initializeAtPosition: aStartingPosition facing: aDirection .! !


!MarsRover class methodsFor: 'errors' stamp: 'C. L. 10/6/2019 12:06:16'!
invalidCommandErrorDescription
	^'Invalid command.'! !
