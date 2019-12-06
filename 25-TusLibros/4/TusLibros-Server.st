!classDefinition: #RealClock category: #'TusLibros-Server' stamp: 'C. L. 12/5/2019 22:10:45'!
Clock subclass: #RealClock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Server'!

!RealClock methodsFor: 'as yet unclassified' stamp: 'C. L. 12/1/2019 13:07:12'!
now
	^(DateAndTime now).! !

!RealClock methodsFor: 'as yet unclassified' stamp: 'C. L. 12/1/2019 21:48:56'!
today
	^(self now date).! !


!classDefinition: #AlwaysSucceedingMerchantProcessor category: #'TusLibros-Server' stamp: 'C. L. 12/5/2019 22:10:45'!
MerchantProcessor subclass: #AlwaysSucceedingMerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Server'!

!AlwaysSucceedingMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'C. L. 12/1/2019 21:36:15'!
debit: anAmount from: aCreditCard
	! !


!classDefinition: #TusLibrosServerController category: #'TusLibros-Server' stamp: 'C. L. 12/5/2019 22:10:45'!
Object subclass: #TusLibrosServerController
	instanceVariableNames: 'webServer port stringGenius tusLibrosSystemFacade salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Server'!

!TusLibrosServerController methodsFor: 'enabling services' stamp: 'C. L. 11/28/2019 13:23:11'!
destroy
	
	webServer ifNotNil:[webServer destroy].! !

!TusLibrosServerController methodsFor: 'enabling services' stamp: 'C. L. 11/28/2019 13:23:11'!
startListening
	
	webServer startListener.

	^ 'Listening on port: ', self port asString.
	! !

!TusLibrosServerController methodsFor: 'enabling services' stamp: 'C. L. 11/28/2019 13:23:11'!
stopListening
	
	webServer stopListener.
	
	^'Stopped listening from port: ', self port asString! !


!TusLibrosServerController methodsFor: 'initialization' stamp: 'C. L. 12/1/2019 00:20:24'!
createService: aServiceName for: aWebServer doOrSend404: aClosure

	aWebServer addService: aServiceName action:[:request |
		[aClosure value: request]
		on: Error 
		do: [ :anError |
			request send404Response: (anError messageText) ]].
! !

!TusLibrosServerController methodsFor: 'initialization' stamp: 'C. L. 12/1/2019 21:36:42'!
initializeWith: aPortNumber authenticatingWith: users acceptingItemsOf: aCatalog measuringTimeWith: aClock
	
	merchantProcessor := AlwaysSucceedingMerchantProcessor new.
	salesBook := OrderedCollection new.
	
	tusLibrosSystemFacade := TusLibrosSystemFacade
			authenticatingWith: users
			acceptingItemsOf: aCatalog
			registeringOn: salesBook
			debitingThrought: merchantProcessor
			measuringTimeWith: aClock.
	
	port:= aPortNumber.
	
	webServer := WebServer new listenOn: aPortNumber.
	
	self refreshServices.! !

!TusLibrosServerController methodsFor: 'initialization' stamp: 'C. L. 11/28/2019 13:23:11'!
port
	"Use a random port to minimise chances of concurrently running test suites clashing."
	"^ port
		ifNil: [port := (10000 to: 50000) atRandom]"
	
	^port ifNil: [port:=8080].
	
	! !

!TusLibrosServerController methodsFor: 'initialization' stamp: 'C. L. 12/1/2019 13:32:03'!
refreshServices
	(self services) keysAndValuesDo: [:serviceName :serviceBehavior |
		self createService: serviceName for: webServer doOrSend404: serviceBehavior.
		].! !

!TusLibrosServerController methodsFor: 'initialization' stamp: 'C. L. 12/5/2019 22:07:13'!
services
	| allServices |
	allServices := Dictionary new.
	
	allServices at: '/createCart' put: [:request | |userId password cartId cartIdAsJSON|
		userId := request fields at: 'user'.
		password := request fields at: 'password'.
		cartId := tusLibrosSystemFacade createCartFor: userId authenticatedWith: password.
		cartIdAsJSON := WebUtils jsonEncode: (cartId asString).
		self sendResponseAsUTF8: cartIdAsJSON toRequest: request.
		].
	
	allServices at: '/addToCart' put: [:request | |cartId bookISBN cartIdAsJSON|
		cartId := (request fields at: 'cartId') asInteger.
		bookISBN := request fields at: 'book'.
		tusLibrosSystemFacade add: bookISBN toCartIdentifiedAs: cartId.
		cartIdAsJSON := WebUtils jsonEncode: (cartId asString).
		self sendResponseAsUTF8: cartIdAsJSON toRequest: request.
		].
	
	allServices at: '/removeFromCart' put: [:request | |cartId bookISBN cartIdAsJSON|
		cartId := (request fields at: 'cartId') asInteger.
		bookISBN := request fields at: 'book'.
		tusLibrosSystemFacade remove: bookISBN fromCartIdentifiedAs: cartId.
		cartIdAsJSON := WebUtils jsonEncode: (cartId asString).
		self sendResponseAsUTF8: cartIdAsJSON toRequest: request.
		].
	
	allServices at: '/detailView' put:[:request | |bookISBN cartId bookInfo bookInfoAsJSON|
		bookISBN := request fields at: 'book'.
		cartId := ((request fields at: 'cartId') asInteger) .
		bookInfo := tusLibrosSystemFacade detailsFor: bookISBN inCartIdentifiedAs: cartId .
		bookInfoAsJSON := WebUtils jsonEncode: bookInfo.
		self sendResponseAsUTF8: bookInfoAsJSON toRequest: request.
		].
	
	allServices at: '/cartView' put:[:request | |cartId cartInfo cartDetails cartDetailsAsJSON|
		cartId := (request fields at: 'cartId') asInteger.
		cartInfo := tusLibrosSystemFacade listCartAsDictIdentifiedAs: cartId.
		cartDetails := (cartInfo keys) collect: [:anItemKey | tusLibrosSystemFacade detailsFor: anItemKey inCartIdentifiedAs: cartId].
		cartDetailsAsJSON := WebUtils jsonEncode: cartDetails.
		self sendResponseAsUTF8: cartDetailsAsJSON toRequest: request.
		].
	
	allServices at: '/catalogView' put:[:request | |cartId catalogInfo catalogInfoAsJSON|
		cartId := (request fields at: 'cartId') asInteger.
		catalogInfo := tusLibrosSystemFacade catalogItemDetailsForCartIdentifiedAs: cartId.
		catalogInfoAsJSON := WebUtils jsonEncode: catalogInfo.
		self sendResponseAsUTF8: catalogInfoAsJSON toRequest: request.
		].
	
	allServices at: '/checkout' put:[:request | |cartId userId ticket ticketAsJSON|
		cartId := (request fields at: 'cartId') asInteger.
		userId := request fields at: 'user'.
		ticket := tusLibrosSystemFacade
				checkOutCartIdentifiedAs: cartId
				withCreditCardNumbered: '1234567890123456'
				ownedBy: userId
				expiringOn: (Month current).
		ticketAsJSON := WebUtils jsonEncode: ticket.
		self sendResponseAsUTF8: ticketAsJSON toRequest: request.
		].
	
	allServices at: '/purchasesHistory' put:[:request | |userId password purchases purchasesAsJSON|
		userId := request fields at: 'user'.
		password := request fields at: 'password'.
		purchases := tusLibrosSystemFacade listPurchasesOf: userId authenticatingWith: password.
		purchasesAsJSON := WebUtils jsonEncode: purchases.
		self sendResponseAsUTF8: purchasesAsJSON toRequest: request.
		].
	
	^allServices.
! !


!TusLibrosServerController methodsFor: 'private' stamp: 'C. L. 11/28/2019 14:43:29'!
sendResponseAsUTF8: content toRequest: request 
		request send200Response: (content asUtf8) 
				 contentType: 'application/json; charset=utf-8' do: [:resp | 
					resp headerAt: 'Access-Control-Allow-Origin' put: '*'.].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosServerController class' category: #'TusLibros-Server' stamp: 'C. L. 12/5/2019 22:10:45'!
TusLibrosServerController class
	instanceVariableNames: ''!

!TusLibrosServerController class methodsFor: 'instance creation' stamp: 'C. L. 12/1/2019 21:20:45'!
listeningOn: aPortNumber

	^self new initializeWith: aPortNumber
			authenticatingWith: (self defaultUserList)
			acceptingItemsOf: (self defaultCatalog)
			measuringTimeWith: RealClock new.! !


!TusLibrosServerController class methodsFor: 'tuslibros initialization defaults' stamp: 'C. L. 12/1/2019 14:00:29'!
defaultCatalog
	| catalog |
	catalog := Catalog new.
	catalog add: '1234123412' named: 'El nombre del viento' by: 'Patrick Rothfuss' withPrice: 500.
	catalog add: '5678567856' named: 'El Guardián del último fuego' by: 'Cristina Bajo' withPrice: 200.
	^ catalog.! !

!TusLibrosServerController class methodsFor: 'tuslibros initialization defaults' stamp: 'C. L. 11/28/2019 14:19:44'!
defaultSalesBook
	^Collection new.! !

!TusLibrosServerController class methodsFor: 'tuslibros initialization defaults' stamp: 'C. L. 11/28/2019 13:30:22'!
defaultUserList
	| users |
	users := Dictionary new.
	users at: 'Caro' put: 'cosasDeCaro'.
	users at: 'Lucho' put: 'cosasDeLucho'.
	^users.! !
