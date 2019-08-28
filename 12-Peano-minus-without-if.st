!classDefinition: #I category: #'12-Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '12-Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'12-Peano'!
I class
	instanceVariableNames: 'sucesor'!

!I class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 12:42:04'!
* aPeano
	^aPeano.! !

!I class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 12:41:20'!
+ aPeano
	^aPeano sucesor! !

!I class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 12:45:44'!
- aPeano
    self error:'invalid subtraction'! !

!I class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 12:46:26'!
/ aPeano
	(aPeano = I) ifTrue: [^I].
	self error:'invalid division'! !

!I class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 12:51:21'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	sucesor := II.! !

!I class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 12:23:20'!
invertedMinus: aPeano
	"This function represents the operation aPeano - self"
	"aPeano has to be greater than I"
	^aPeano previo.! !

!I class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:14:33'!
sucesor
	sucesor := II.
	^sucesor! !


!classDefinition: #II category: #'12-Peano'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '12-Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'12-Peano'!
II class
	instanceVariableNames: 'sucesor previo'!

!II class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 12:42:29'!
* aPeano
    ^(self previo * aPeano) + aPeano.! !

!II class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 12:43:46'!
+ aPeano
    ^self previo + aPeano sucesor! !

!II class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 12:45:44'!
- aPeano
	^aPeano invertedMinus: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 12:46:26'!
/ aPeano
    (self = aPeano) ifTrue: [^I].
    ^((self - aPeano) / aPeano) + I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 12:51:21'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	sucesor := nil.
	previo := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'C. L. 8/28/2019 12:45:44'!
invertedMinus: aPeano
	"This function represents the operation aPeano - self"
	"aPeano has to be greater than I"
	^(aPeano previo) - (self previo).! !

!II class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:22:45'!
previo
    previo ifNil: [self previo: I].
    ^previo! !

!II class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:11:12'!
previo: aPeano
	previo := aPeano! !

!II class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:12:47'!
removeAllNext
	sucesor ifNotNil:
	[
		sucesor removeAllNext.
		sucesor removeFromSystem.
		sucesor := nil.
	]! !

!II class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:10:50'!
sucesor
	sucesor ifNil: [ sucesor := self cloneNamed: self name, 'I'.
		sucesor previo: self].
	^sucesor! !

I initializeAfterFileIn!
II initializeAfterFileIn!