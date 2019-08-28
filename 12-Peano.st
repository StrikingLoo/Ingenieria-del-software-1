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

!I class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:36:44'!
div: aPeano
	(aPeano = I) ifTrue: [^I].
	self error:'invalid division goes to zero'! !

!I class methodsFor: 'as yet unclassified' stamp: 'LS 8/27/2019 22:48:04'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	sucesor := II.! !

!I class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:28:05'!
minus: aPeano
    self error:'invalid subtraction'! !

!I class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:33:06'!
mult: aPeano
	^aPeano.! !

!I class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:16:56'!
plus: aPeano
	^aPeano sucesor! !

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

!II class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:38:04'!
div: aPeano
    (self = aPeano) ifTrue: [^I].
    ^((self minus: aPeano) div: aPeano) plus: I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'LS 8/27/2019 22:48:04'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	sucesor := III.
	previo := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:26:31'!
minus: aPeano
    (aPeano = I)
      ifTrue: [^self previo].
	^self previo minus: aPeano previo! !

!II class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:32:38'!
mult: aPeano
    ^(self previo mult: aPeano) plus: aPeano.! !

!II class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:18:23'!
plus: aPeano
    ^self previo plus: aPeano sucesor! !

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


!classDefinition: #III category: #'12-Peano'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '12-Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'12-Peano'!
III class
	instanceVariableNames: 'sucesor previo'!

!III class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:38:33'!
div: aPeano
    (self = aPeano) ifTrue: [^I].
    ^((self minus: aPeano) div: aPeano) plus: I.! !

!III class methodsFor: 'as yet unclassified' stamp: 'LS 8/27/2019 22:48:04'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	sucesor := IIII.
	previo := II.! !

!III class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:38:33'!
minus: aPeano
    (aPeano = I)
      ifTrue: [^self previo].
	^self previo minus: aPeano previo! !

!III class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:38:33'!
mult: aPeano
    ^(self previo mult: aPeano) plus: aPeano.! !

!III class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:38:33'!
plus: aPeano
    ^self previo plus: aPeano sucesor! !

!III class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:38:33'!
previo
    previo ifNil: [self previo: I].
    ^previo! !

!III class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:38:33'!
previo: aPeano
	previo := aPeano! !

!III class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:38:33'!
removeAllNext
	sucesor ifNotNil:
	[
		sucesor removeAllNext.
		sucesor removeFromSystem.
		sucesor := nil.
	]! !

!III class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:38:33'!
sucesor
	sucesor ifNil: [ sucesor := self cloneNamed: self name, 'I'.
		sucesor previo: self].
	^sucesor! !


!classDefinition: #IIII category: #'12-Peano'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '12-Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'12-Peano'!
IIII class
	instanceVariableNames: 'sucesor previo'!

!IIII class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:38:33'!
div: aPeano
    (self = aPeano) ifTrue: [^I].
    ^((self minus: aPeano) div: aPeano) plus: I.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LS 8/27/2019 22:48:04'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	sucesor := nil.
	previo := III.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:38:33'!
minus: aPeano
    (aPeano = I)
      ifTrue: [^self previo].
	^self previo minus: aPeano previo! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:38:33'!
mult: aPeano
    ^(self previo mult: aPeano) plus: aPeano.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:38:33'!
plus: aPeano
    ^self previo plus: aPeano sucesor! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:38:33'!
previo
    previo ifNil: [self previo: I].
    ^previo! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:38:33'!
previo: aPeano
	previo := aPeano! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:38:33'!
removeAllNext
	sucesor ifNotNil:
	[
		sucesor removeAllNext.
		sucesor removeFromSystem.
		sucesor := nil.
	]! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'LS 8/26/2019 21:38:33'!
sucesor
	sucesor ifNil: [ sucesor := self cloneNamed: self name, 'I'.
		sucesor previo: self].
	^sucesor! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!