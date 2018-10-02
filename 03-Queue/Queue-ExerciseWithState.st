!classDefinition: #QueueTest category: #'Queue-ExerciseWithState'!
TestCase subclass: #QueueTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-ExerciseWithState'!

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test01QueueShouldBeEmptyWhenCreated

	| queue |

	queue _ Queue new.

	self assert: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test02EnqueueAddElementsToTheQueue

	| queue |

	queue _ Queue new.
	queue enqueue: 'Something'.

	self deny: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test03DequeueRemovesElementsFromTheQueue

	| queue |

	queue _ Queue new.
	queue enqueue: 'Something'.
	queue dequeue.

	self assert: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test04DequeueReturnsFirstEnqueuedObject

	| queue firstQueued secondQueued |

	queue _ Queue new.
	firstQueued _ 'Something1'.
	secondQueued _ 'Something2'.
	queue enqueue: firstQueued.
	queue enqueue: secondQueued.
	
	self assert: queue dequeue equals: firstQueued.! !

!QueueTest methodsFor: 'test' stamp: 'CGCM 9/27/2018 16:34:58'!
test05QueueBehavesFIFO

	| queue firstQueued secondQueued |

	queue _ Queue new.
	firstQueued _ 'First'.
	secondQueued _ 'Second'.
	queue enqueue: firstQueued.
	queue enqueue: secondQueued.

	self assert: queue dequeue equals: firstQueued.
	self assert: queue dequeue equals: secondQueued.
	self assert: queue isEmpty.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test06NextReturnsFirstEnqueuedObject

	| queue firstQueued |

	queue _ Queue new.
	firstQueued _ 'Something'.
	queue enqueue: firstQueued.

	self assert: queue next equals: firstQueued.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test07NextDoesNotRemoveObjectFromQueue

	| queue firstQueued |

	queue _ Queue new.
	firstQueued _ 'Something'.
	queue enqueue: firstQueued.

	queue next.
	self assert: queue size equals: 1.! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test08CanNotDequeueWhenThereAreNoObjectsInTheQueue

	| queue |

	queue _ Queue new.
	
	self
		should: [ queue dequeue ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Queue queueEmptyErrorDescription ].! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test09CanNotDequeueWhenThereAreNoObjectsInTheQueueAndTheQueueHadObjects

	| queue |

	queue _ Queue new.
	queue enqueue: 'Something'.
	queue dequeue.

	self
		should: [ queue dequeue ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Queue queueEmptyErrorDescription ].! !

!QueueTest methodsFor: 'test' stamp: 'HAW 9/26/2018 23:15:51'!
test10CanNotNextWhenThereAreNoObjectsInTheQueue

	| queue |

	queue _ Queue new.

	self
		should: [ queue next ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Queue queueEmptyErrorDescription ].! !


!classDefinition: #BasicQueue category: #'Queue-ExerciseWithState'!
Object subclass: #BasicQueue
	instanceVariableNames: 'contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-ExerciseWithState'!


!classDefinition: #EmptyQueue category: #'Queue-ExerciseWithState'!
BasicQueue subclass: #EmptyQueue
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-ExerciseWithState'!

!EmptyQueue methodsFor: 'as yet unclassified' stamp: 'ap 10/1/2018 22:01:30'!
dequeue

	^self error: Queue queueEmptyErrorDescription.! !

!EmptyQueue methodsFor: 'as yet unclassified' stamp: 'ap 10/1/2018 21:56:57'!
enqueue: aThing

	^contents := QueueWithElements with: aThing.! !

!EmptyQueue methodsFor: 'as yet unclassified' stamp: 'ap 10/1/2018 22:02:41'!
enqueue: aThing to:contents

	^contents .! !

!EmptyQueue methodsFor: 'as yet unclassified' stamp: 'ap 10/1/2018 22:01:11'!
initialize
! !

!EmptyQueue methodsFor: 'as yet unclassified' stamp: 'ap 10/1/2018 21:54:41'!
isEmpty
	^true! !

!EmptyQueue methodsFor: 'as yet unclassified' stamp: 'ap 10/1/2018 21:52:38'!
next

	^self error: Queue queueEmptyErrorDescription! !

!EmptyQueue methodsFor: 'as yet unclassified' stamp: 'ap 10/1/2018 21:54:04'!
size

	^0! !


!classDefinition: #QueueWithElements category: #'Queue-ExerciseWithState'!
BasicQueue subclass: #QueueWithElements
	instanceVariableNames: 'elements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-ExerciseWithState'!

!QueueWithElements methodsFor: 'as yet unclassified' stamp: 'ap 10/1/2018 21:46:09'!
dequeue

	^elements removeFirst.! !

!QueueWithElements methodsFor: 'as yet unclassified' stamp: 'ap 10/1/2018 21:46:58'!
enqueue: aThing

	^elements addLast: aThing.! !

!QueueWithElements methodsFor: 'as yet unclassified' stamp: 'ap 10/1/2018 21:43:58'!
initialize

	elements:=OrderedCollection new.! !

!QueueWithElements methodsFor: 'as yet unclassified' stamp: 'ap 10/1/2018 21:59:44'!
initializeWith: aThing

	contents:=self.
	elements:=OrderedCollection with:aThing.! !

!QueueWithElements methodsFor: 'as yet unclassified' stamp: 'ap 10/1/2018 21:54:50'!
isEmpty
	^false! !

!QueueWithElements methodsFor: 'as yet unclassified' stamp: 'ap 10/1/2018 21:53:08'!
next

	^elements first.! !

!QueueWithElements methodsFor: 'as yet unclassified' stamp: 'ap 10/1/2018 21:54:19'!
size

	^elements size.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'QueueWithElements class' category: #'Queue-ExerciseWithState'!
QueueWithElements class
	instanceVariableNames: ''!

!QueueWithElements class methodsFor: 'as yet unclassified' stamp: 'ap 10/1/2018 21:51:03'!
with: aThing

	^self basicNew initializeWith:aThing! !


!classDefinition: #Queue category: #'Queue-ExerciseWithState'!
Object subclass: #Queue
	instanceVariableNames: 'contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Queue-ExerciseWithState'!

!Queue methodsFor: 'initialization' stamp: 'ap 10/1/2018 21:43:20'!
initialize
	contents := EmptyQueue new.! !


!Queue methodsFor: 'operations' stamp: 'ap 10/1/2018 21:44:15'!
dequeue

	^contents dequeue.! !

!Queue methodsFor: 'operations' stamp: 'ap 10/1/2018 22:03:01'!
enqueue: aThing
	
	^contents enqueue:aThing to:contents.! !

!Queue methodsFor: 'operations' stamp: 'ap 10/1/2018 21:53:17'!
next
	
	^contents next! !

!Queue methodsFor: 'operations' stamp: 'GR 9/28/2018 15:09:14'!
size
	^contents size! !


!Queue methodsFor: 'testing' stamp: 'GR 9/28/2018 15:46:10'!
isEmpty
	^contents isEmpty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Queue class' category: #'Queue-ExerciseWithState'!
Queue class
	instanceVariableNames: 'contents'!

!Queue class methodsFor: 'error descriptions'!
queueEmptyErrorDescription
	^ 'Queue is empty'.! !
