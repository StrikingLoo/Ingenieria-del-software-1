'From Cuis 5.0 [latest update: #3958] on 14 November 2019 at 9:33:31 pm'!
!classDefinition: #BookstoreFacade category: #TusLibros!
Object subclass: #BookstoreFacade
	instanceVariableNames: 'catalog carts validUsers lastCartId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!BookstoreFacade methodsFor: 'interface' stamp: 'C. L. 11/14/2019 20:59:47'!
add: aQuantity of: anItem to: aCartId
	(carts at: aCartId) add: aQuantity of: anItem.! !

!BookstoreFacade methodsFor: 'interface' stamp: 'C. L. 11/14/2019 21:17:58'!
createCartFor: aUserId withPassword: aPassword
	| cartId |
	(validUsers includesKey: aUserId) ifFalse: [self error: (self class nonExistentUserErrorMessage)].
	(aPassword = (validUsers at: aUserId)) ifFalse: [self error: (self class wrongPasswordErrorMessage)].
	
	cartId := self nextCartId.
	carts at: cartId put: (Cart acceptingItemsOf: catalog).
	^cartId.! !

!BookstoreFacade methodsFor: 'interface' stamp: 'C. L. 11/14/2019 21:02:35'!
listCart: aCartId
	
	(carts includesKey: aCartId) ifFalse: [self error: (self class nonExistentCartErrorDescription)].
	^(carts at: aCartId) list.! !


!BookstoreFacade methodsFor: 'cart id - private' stamp: 'C. L. 11/14/2019 21:10:48'!
nextCartId
	| idToReturn |
	idToReturn := lastCartId.
	lastCartId := lastCartId + 1.
	^idToReturn .! !


!BookstoreFacade methodsFor: 'initialization' stamp: 'C. L. 11/14/2019 21:11:01'!
initializeAcceptingItemsOf: aCatalog withUsers: users
	catalog := aCatalog.
	validUsers := users.
	carts := Dictionary new.
	lastCartId := 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BookstoreFacade class' category: #TusLibros!
BookstoreFacade class
	instanceVariableNames: ''!

!BookstoreFacade class methodsFor: 'error messages' stamp: 'C. L. 11/14/2019 21:15:24'!
cartForUserAlreadyCreatedErrorMessage
	^'A cart is already created for this user'.! !

!BookstoreFacade class methodsFor: 'error messages' stamp: 'C. L. 11/14/2019 18:59:43'!
nonExistentCartErrorDescription
	^'There is no cart with the provided cart ID.'.! !

!BookstoreFacade class methodsFor: 'error messages' stamp: 'C. L. 11/14/2019 20:12:33'!
nonExistentUserErrorMessage
	^'The user does not exist in the database'.! !

!BookstoreFacade class methodsFor: 'error messages' stamp: 'C. L. 11/14/2019 20:12:52'!
wrongPasswordErrorMessage
	^'The password is incorrect'.! !


!BookstoreFacade class methodsFor: 'instance creation' stamp: 'C. L. 11/14/2019 20:17:33'!
acceptingItemsOf: aCatalog withUsers: users
	^self new initializeAcceptingItemsOf: aCatalog withUsers: users! !
