!classDefinition: #InvalidSlideError category: #'22-TerniLapilli'!
Error subclass: #InvalidSlideError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '22-TerniLapilli'!


!classDefinition: #PlayingAfterGameOver category: #'22-TerniLapilli'!
Error subclass: #PlayingAfterGameOver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '22-TerniLapilli'!


!classDefinition: #PlayingOnNonEmptySquareError category: #'22-TerniLapilli'!
Error subclass: #PlayingOnNonEmptySquareError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '22-TerniLapilli'!


!classDefinition: #PlayingOutOfBoundsError category: #'22-TerniLapilli'!
Error subclass: #PlayingOutOfBoundsError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '22-TerniLapilli'!


!classDefinition: #TerniLapilliTest category: #'22-TerniLapilli'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '22-TerniLapilli'!

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'L S 10/10/2019 17:26:11'!
test01XPlaysFirst
    | terniLapilliBoard |
    
    terniLapilliBoard := TerniLapilli new.
    self assert: terniLapilliBoard playsNext equals: 'X'! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'L S 10/10/2019 17:24:01'!
test02CanPlaceFirstPeg
    
    |terniLapilliBoard|
    terniLapilliBoard := TerniLapilli new.
    terniLapilliBoard play: 1@1.
    self assert: (terniLapilliBoard onPosition: 1@1) equals: 'X'
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'L S 10/10/2019 17:26:03'!
test03PlayerOGoesSecond
    
    |terniLapilliBoard|
    terniLapilliBoard := TerniLapilli new.
    terniLapilliBoard play: 1@1.
    self assert: terniLapilliBoard playsNext equals: 'O'
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'L S 10/10/2019 17:30:09'!
test04CanPlaceSecondPeg
    
    |terniLapilliBoard|
    terniLapilliBoard := TerniLapilli new.
    terniLapilliBoard play: 1@1.
    terniLapilliBoard play: 1@2.
    self assert: (terniLapilliBoard onPosition: 1@2) equals: 'O'
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'L S 10/10/2019 17:36:08'!
test05EmptySquareIsEmpty
    
    |terniLapilliBoard|

    terniLapilliBoard := TerniLapilli new.
    self assert: (terniLapilliBoard onPosition: 1@2) equals: '-'
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'L S 10/10/2019 17:47:13'!
test06CannotPlayOutOfBounds
    
    |terniLapilliBoard|

    terniLapilliBoard := TerniLapilli new.
    self should: [terniLapilliBoard play: 4@4] raise: PlayingOutOfBoundsError 
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'L S 10/10/2019 17:48:44'!
test07CannotPlayOverTakenSquare
    
    |terniLapilliBoard|

    terniLapilliBoard := TerniLapilli new.
    terniLapilliBoard play: 1@1.
    self should: [terniLapilliBoard play: 1@1] raise: PlayingOnNonEmptySquareError 
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'L S 10/10/2019 18:09:12'!
test08NoPlayerWinsInFirstTurn
    
    |terniLapilliBoard|

    terniLapilliBoard := TerniLapilli new.
    terniLapilliBoard play: 1@1.
    self assert: terniLapilliBoard whoWon equals: '-'.
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'C. L. 10/16/2019 21:29:43'!
test09PlayerOWinsVertically
    
	  |terniLapilliBoard|
	
	terniLapilliBoard := TerniLapilli new.
	terniLapilliBoard play: 1@1.
	terniLapilliBoard play: 1@2.
	terniLapilliBoard play: 2@1.
	terniLapilliBoard play: 2@2.
	terniLapilliBoard play: 3@3.
	terniLapilliBoard play: 3@2.
	self assert: (terniLapilliBoard whoWon) equals: 'O'.
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'L S 10/10/2019 18:19:17'!
test09PlayerXWinsHorizontally
    
	  |terniLapilliBoard|
	
	terniLapilliBoard := TerniLapilli new.
	terniLapilliBoard play: 1@1.
	terniLapilliBoard play: 2@1.
	terniLapilliBoard play: 1@2.
	terniLapilliBoard play: 2@2.
	terniLapilliBoard play: 1@3.
	self assert: (terniLapilliBoard whoWon) equals: 'X'.
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'C. L. 10/16/2019 21:29:56'!
test10PlayerXWinsHorizontally
    
	  |terniLapilliBoard|
	
	terniLapilliBoard := TerniLapilli new.
	terniLapilliBoard play: 3@1.
	terniLapilliBoard play: 2@1.
	terniLapilliBoard play: 3@2.
	terniLapilliBoard play: 2@2.
	terniLapilliBoard play: 3@3.
	self assert: (terniLapilliBoard whoWon) equals: 'X'.
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'L S 10/10/2019 18:21:48'!
test10PlayerXWinsVertically
    
	  |terniLapilliBoard|
	
	terniLapilliBoard := TerniLapilli new.
	terniLapilliBoard play: 1@1.
	terniLapilliBoard play: 2@2.
	terniLapilliBoard play: 2@1.
	terniLapilliBoard play: 2@3.
	terniLapilliBoard play: 3@1.
	self assert: (terniLapilliBoard whoWon) equals: 'X'.
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'L S 10/10/2019 18:50:23'!
test11PlayerOWinsVerticallyOthers
    
	  |terniLapilliBoard|
	
	terniLapilliBoard := TerniLapilli new.
	terniLapilliBoard play: 1@1.
	terniLapilliBoard play: 1@2.
	terniLapilliBoard play: 2@1.
	terniLapilliBoard play: 2@2.
	terniLapilliBoard play: 3@3.
	terniLapilliBoard play: 3@2.
	self assert: (terniLapilliBoard whoWon) equals: 'O'.
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'C. L. 10/16/2019 21:30:11'!
test11PlayerXWinsDiagonallyDownward
    
	  |terniLapilliBoard|
	
	terniLapilliBoard := TerniLapilli new.
	terniLapilliBoard play: 1@1.
	terniLapilliBoard play: 2@1.
	terniLapilliBoard play: 2@2.
	terniLapilliBoard play: 2@3.
	terniLapilliBoard play: 3@3.
	
	self assert: terniLapilliBoard whoWon equals: 'X'.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'C. L. 10/16/2019 21:30:19'!
test12PlayerXWinsDiagonallyUpward
    
	  |terniLapilliBoard|
	
	terniLapilliBoard := TerniLapilli new.
	terniLapilliBoard play: 3@1.
	terniLapilliBoard play: 2@1.
	terniLapilliBoard play: 2@2.
	terniLapilliBoard play: 2@3.
	terniLapilliBoard play: 1@3.
	
	self assert: terniLapilliBoard whoWon equals: 'X'.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'L S 10/10/2019 18:50:45'!
test12PlayerXWinsHorizontallyOthers
    
	  |terniLapilliBoard|
	
	terniLapilliBoard := TerniLapilli new.
	terniLapilliBoard play: 3@1.
	terniLapilliBoard play: 2@1.
	terniLapilliBoard play: 3@2.
	terniLapilliBoard play: 2@2.
	terniLapilliBoard play: 3@3.
	self assert: (terniLapilliBoard whoWon) equals: 'X'.
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'L S 10/10/2019 19:09:00'!
test13XCanMovePegWhen6PiecesAreOnTheBoard
    
	  |terniLapilliBoard|
	
	terniLapilliBoard := TerniLapilli new.
	terniLapilliBoard play: 3@1.
	terniLapilliBoard play: 2@1.
	terniLapilliBoard play: 3@2.
	terniLapilliBoard play: 2@2.
	terniLapilliBoard play: 1@1.
	terniLapilliBoard play: 3@3.
	terniLapilliBoard slide: 1@1 to: 1@2.
	self assert: (terniLapilliBoard onPosition: 1@1) equals: '-'.
	self assert: (terniLapilliBoard onPosition: 1@2) equals: 'X'.
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'L S 10/10/2019 19:59:18'!
test14XCannotMovePegWhenMovingFromInvalidSquare
    
	  |terniLapilliBoard|
	
	terniLapilliBoard := TerniLapilli new.
	terniLapilliBoard play: 3@1.
	terniLapilliBoard play: 2@1.
	terniLapilliBoard play: 3@2.
	terniLapilliBoard play: 2@2.
	terniLapilliBoard play: 1@1.
	terniLapilliBoard play: 3@3.
	
	self should: [terniLapilliBoard slide: 3@3 to: 2@3.] raise: InvalidSlideError .
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'C. L. 10/16/2019 20:07:47'!
test15XCannotMovePegWhenMovingToTakenSquare
    
	  |terniLapilliBoard|
	
	terniLapilliBoard := TerniLapilli new.
	terniLapilliBoard play: 3@1.
	terniLapilliBoard play: 2@1.
	terniLapilliBoard play: 3@2.
	terniLapilliBoard play: 2@2.
	terniLapilliBoard play: 1@1.
	terniLapilliBoard play: 3@3.
	
	self should: [terniLapilliBoard slide: 1@1 to: 2@1.] raise: InvalidSlideError .
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'C. L. 10/16/2019 21:27:11'!
test16XCannotMovePegWhenMovingToTheSameSquare
    
	  |terniLapilliBoard|
	
	terniLapilliBoard := TerniLapilli new.
	terniLapilliBoard play: 3@1.
	terniLapilliBoard play: 2@1.
	terniLapilliBoard play: 3@2.
	terniLapilliBoard play: 2@2.
	terniLapilliBoard play: 1@1.
	terniLapilliBoard play: 3@3.
	
	self should: [terniLapilliBoard slide: 1@1 to: 1@1.] raise: InvalidSlideError .
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'L S 10/10/2019 20:07:07'!
test16XCannotSlideMoreThanOneSpaceVertically
    
	  |terniLapilliBoard|
	
	terniLapilliBoard := TerniLapilli new.
	terniLapilliBoard play: 3@1.
	terniLapilliBoard play: 2@1.
	terniLapilliBoard play: 3@2.
	terniLapilliBoard play: 2@2.
	terniLapilliBoard play: 1@1.
	terniLapilliBoard play: 3@3.
	
	self should: [terniLapilliBoard slide: 1@1 to: 1@3.] raise: InvalidSlideError .
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'L S 10/10/2019 20:08:47'!
test17XCannotSlideMoreThanOneSpaceHorizontally
    
	  |terniLapilliBoard|
	
	terniLapilliBoard := TerniLapilli new.
	terniLapilliBoard play: 2@3.
	terniLapilliBoard play: 2@1.
	terniLapilliBoard play: 3@2.
	terniLapilliBoard play: 2@2.
	terniLapilliBoard play: 1@1.
	terniLapilliBoard play: 3@3.
	
	self should: [terniLapilliBoard slide: 1@1 to: 3@1.] raise: InvalidSlideError .
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'L S 10/10/2019 20:17:47'!
test18PlayerXWinsDiagonallyDownward
    
	  |terniLapilliBoard|
	
	terniLapilliBoard := TerniLapilli new.
	terniLapilliBoard play: 1@1.
	terniLapilliBoard play: 2@1.
	terniLapilliBoard play: 2@2.
	terniLapilliBoard play: 2@3.
	terniLapilliBoard play: 3@3.
	
	self assert: terniLapilliBoard whoWon equals: 'X'.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'C. L. 10/16/2019 21:28:00'!
test18XCannotSlideMoreThanOneSpaceVertically
    
	  |terniLapilliBoard|
	
	terniLapilliBoard := TerniLapilli new.
	terniLapilliBoard play: 3@1.
	terniLapilliBoard play: 2@1.
	terniLapilliBoard play: 3@2.
	terniLapilliBoard play: 2@2.
	terniLapilliBoard play: 1@1.
	terniLapilliBoard play: 3@3.
	
	self should: [terniLapilliBoard slide: 1@1 to: 1@3.] raise: InvalidSlideError .
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'L S 10/10/2019 20:18:28'!
test19PlayerXWinsDiagonallyUpward
    
	  |terniLapilliBoard|
	
	terniLapilliBoard := TerniLapilli new.
	terniLapilliBoard play: 3@1.
	terniLapilliBoard play: 2@1.
	terniLapilliBoard play: 2@2.
	terniLapilliBoard play: 2@3.
	terniLapilliBoard play: 1@3.
	
	self assert: terniLapilliBoard whoWon equals: 'X'.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'L S 10/17/2019 01:01:52'!
test19XCannotSlideAlongANonPrincipalDiagonal
    
	  |terniLapilliBoard|
	
	terniLapilliBoard := TerniLapilli new.
	terniLapilliBoard play: 2@2.
	terniLapilliBoard play: 2@3.
	terniLapilliBoard play: 3@2.
	terniLapilliBoard play: 3@1.
	terniLapilliBoard play: 3@3.
	terniLapilliBoard play: 1@2.
	
	self should: [terniLapilliBoard slide: 3@2 to: 2@1.] raise: InvalidSlideError .
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'L S 10/17/2019 17:39:05'!
test20PuttingABunchOfPieces

 |terniLapilliBoard|
	
	terniLapilliBoard := TerniLapilli new.
	terniLapilliBoard play: 1@1.
	terniLapilliBoard play: 1@2.
	terniLapilliBoard play: 2@1.
	terniLapilliBoard play: 2@2.
	self assert: terniLapilliBoard placingOver equals: false.
	terniLapilliBoard play: 3@2.
	terniLapilliBoard play: 3@1.
	self should: [terniLapilliBoard play: 1@3.] raise: PlayingAfterGameOver .
	
	
	

    
! !


!classDefinition: #TerniLapilli category: #'22-TerniLapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'nextPlayer board'
	classVariableNames: ''
	poolDictionaries: ''
	category: '22-TerniLapilli'!

!TerniLapilli methodsFor: 'moving' stamp: 'L S 10/17/2019 17:37:24'!
play: aPosition
    (self hasPositionInsideBounds: aPosition) ifFalse: [ PlayingOutOfBoundsError signal ].
    ( (self onPosition: aPosition) = '-') ifFalse: [PlayingOnNonEmptySquareError signal ].
    ( self gameOver) ifTrue: [PlayingAfterGameOver signal ].
    ( self placingOver) ifTrue: [PlayingAfterGameOver signal ]. 
    board at: aPosition put: self playsNext.
    
    (self playsNext = 'X') ifTrue: [nextPlayer :='O'] ifFalse: [nextPlayer := 'X']! !

!TerniLapilli methodsFor: 'moving' stamp: 'C. L. 10/16/2019 21:02:46'!
slide: aStartingPosition to: anEndingPosition
    (self neighborsAlongBoardLinesFrom: aStartingPosition to: anEndingPosition) ifFalse: [InvalidSlideError signal].
    (self player: nextPlayer playedOn: aStartingPosition) ifFalse: [InvalidSlideError signal].
    (self isValidBlankPosition: anEndingPosition) ifFalse: [InvalidSlideError signal].
    
    board removeKey: aStartingPosition ifAbsent: [].
    self play: anEndingPosition .

! !


!TerniLapilli methodsFor: 'moving restrictions' stamp: 'L S 10/17/2019 01:04:01'!
canGoAlongDiagonalLineFrom: aStartingPosition to: anEndingPosition
	| positions |
	positions := Set with: aStartingPosition with: anEndingPosition .
	^(self validDiagonals anySatisfy: [:diagonal | diagonal includesAllOf: positions])! !

!TerniLapilli methodsFor: 'moving restrictions' stamp: 'C. L. 10/16/2019 20:38:04'!
canGoAlongHorizontalLineFrom: aStartingPosition to: anEndingPosition
	^(aStartingPosition x = anEndingPosition x).! !

!TerniLapilli methodsFor: 'moving restrictions' stamp: 'C. L. 10/16/2019 20:37:08'!
canGoAlongLineFrom: aStartingPosition to: anEndingPosition
	^(self canGoAlongHorizontalLineFrom: aStartingPosition to: anEndingPosition)
		or: (self canGoAlongVerticalLineFrom: aStartingPosition to: anEndingPosition)
		or: (self canGoAlongDiagonalLineFrom: aStartingPosition to: anEndingPosition).! !

!TerniLapilli methodsFor: 'moving restrictions' stamp: 'C. L. 10/16/2019 20:38:22'!
canGoAlongVerticalLineFrom: aStartingPosition to: anEndingPosition
	^(aStartingPosition y = anEndingPosition y).! !

!TerniLapilli methodsFor: 'moving restrictions' stamp: 'C. L. 10/16/2019 21:15:00'!
neighborsAlongBoardLinesFrom: aStartingPosition to: anEndingPosition
	^((self hasPositionInsideBounds: aStartingPosition) and: (self hasPositionInsideBounds: anEndingPosition))
		and: (( aStartingPosition = anEndingPosition ) not)
		and: ((aStartingPosition x - anEndingPosition x) abs <= 1)
		and: ((aStartingPosition y - anEndingPosition y) abs <= 1)
		and: (self canGoAlongLineFrom: aStartingPosition to: anEndingPosition).! !

!TerniLapilli methodsFor: 'moving restrictions' stamp: 'L S 10/17/2019 17:36:43'!
placingOver
    ^ (board occurrencesOf: nextPlayer) = 3! !

!TerniLapilli methodsFor: 'moving restrictions' stamp: 'L S 10/17/2019 01:05:20'!
validDiagonals
    |ascendingDiagonal descendingDiagonal mainDiagonals|
    ascendingDiagonal := Set with: (1@1) with: (2@2) with: (3@3).
    descendingDiagonal := Set with: (1@3) with: (2@2) with: (3@1).
    mainDiagonals := Set with: ascendingDiagonal with: descendingDiagonal .
    ^mainDiagonals! !


!TerniLapilli methodsFor: 'winning conditions' stamp: 'L S 10/10/2019 20:47:06'!
gameOver
    ^(self won: 'X') or: (self won: 'O')! !

!TerniLapilli methodsFor: 'winning conditions' stamp: 'L S 10/10/2019 19:05:03'!
horizontalVictory: aPlayer onRow: aRow
    ^(#(1 2 3) allSatisfy: [:column | self player: aPlayer playedOn: aRow@column])! !

!TerniLapilli methodsFor: 'winning conditions' stamp: 'L S 10/10/2019 19:03:50'!
verticalVictory: aPlayer onColumn: aColumn
    ^(#(1 2 3) allSatisfy: [:row | self player: aPlayer playedOn: row@aColumn])! !

!TerniLapilli methodsFor: 'winning conditions' stamp: 'L S 10/10/2019 18:15:31'!
whoWon
    (self won: 'X' ) ifTrue:  [^'X'].
    (self won: 'O' ) ifTrue:  [^'O'].
    ^'-'! !

!TerniLapilli methodsFor: 'winning conditions' stamp: 'L S 10/10/2019 20:43:49'!
won: aPlayer
    | victory |
    victory := self wonHorizontally: aPlayer .
    victory := victory or: (self wonVertically: aPlayer).
    victory := victory or: (self wonDiagonally: aPlayer).
    
    ^victory ! !

!TerniLapilli methodsFor: 'winning conditions' stamp: 'L S 10/10/2019 20:21:01'!
wonDiagonally: aPlayer
    | victory |
    victory := (#(1 2 3) allSatisfy: [:coordinate | self player: aPlayer playedOn: coordinate @ coordinate ]).
    victory := victory or: (#(1 2 3) allSatisfy: [:coordinate | self player: aPlayer playedOn: coordinate @ (4 - coordinate) ]).
    ^victory! !

!TerniLapilli methodsFor: 'winning conditions' stamp: 'L S 10/10/2019 18:46:14'!
wonHorizontally: aPlayer
    |victory|
    victory := false.
    #(1 2 3) collect: [:row | victory := victory or: (self horizontalVictory: aPlayer onRow: row)].
    ^victory! !

!TerniLapilli methodsFor: 'winning conditions' stamp: 'L S 10/10/2019 18:48:17'!
wonVertically: aPlayer
    |victory|
    victory := false.
    #(1 2 3) collect: [:column | victory := victory or: (self verticalVictory: aPlayer onColumn: column)].
    ^victory! !


!TerniLapilli methodsFor: 'initialization' stamp: 'L S 10/17/2019 01:03:01'!
initialize
    nextPlayer := 'X'.
    board := Dictionary new.

    ! !


!TerniLapilli methodsFor: 'accessing' stamp: 'C. L. 10/16/2019 20:16:38'!
hasPositionInsideBounds: aPosition
    ^(aPosition x between: 1 and: 3) and: (aPosition y between: 1 and: 3).! !

!TerniLapilli methodsFor: 'accessing' stamp: 'C. L. 10/16/2019 20:18:35'!
isValidBlankPosition: aPosition
    ^(self hasPositionInsideBounds: aPosition) and: ((self onPosition: aPosition) = '-')! !

!TerniLapilli methodsFor: 'accessing' stamp: 'C. L. 10/16/2019 20:19:42'!
onPosition: aPosition
    (self hasPositionInsideBounds: aPosition) ifFalse: [PlayingOutOfBoundsError signal].
    ^board at: aPosition ifAbsent: [^'-']! !

!TerniLapilli methodsFor: 'accessing' stamp: 'L S 10/10/2019 18:30:27'!
player: aPlayer playedOn: aPosition
    ^(self onPosition: aPosition) = aPlayer ! !

!TerniLapilli methodsFor: 'accessing' stamp: 'L S 10/10/2019 17:27:43'!
playsNext
    ^nextPlayer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'22-TerniLapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'L S 10/10/2019 20:45:55'!
gameOver
	^(self won: 'X') or: (self won: 'O')! !
