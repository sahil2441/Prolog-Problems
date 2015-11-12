

size(1,3).
size(N,FN) :-
	M is N-1,
	size(M,FM),
	FN is 2*FM-1.

%Base Case
lace(1,1,_) :- write('*'),write('*'),write('*').
lace(1,2,_) :- write('*'),tab(1),write('*').
lace(1,3,_) :- write('*'),write('*'),write('*').

alternateStarAndSpace(I,I):- write('*').
alternateStarAndSpace(I,K) :-

		mod(I,2) =:= 1 ->
			write('*'),
			J is I+1,
			alternateStarAndSpace(J,K);	

		tab(1),
		J is I+1,
		alternateStarAndSpace(J,K).

spacesAndStar(I,DN)  :-
	HALFDN is DN/2,
	M is DN-I+1,
	Stars is HALFDN-M,
	REMAININGSPACES is HALFDN-Stars-M,

	tab(M),
	printStars(Stars),
	tab(REMAININGSPACES).

printStars(0).
printStars(N):-
	write('*'),
	M is N-1,
	printStars(M).

spacesAndStarRevese(I,DN) :-
	HALFDN is DN/2,
	M is DN-I+1,
	Stars is HALFDN-M,
	REMAININGSPACES is HALFDN-Stars-M,

	tab(REMAININGSPACES),
	printStars(Stars),
	tab(M).

%Main Method - - - - - - - 
start(1):-
write('*'),write('*'),write('*'),nl,
write('*'),tab(1),write('*'),nl,
write('*'),write('*'),write('*'),nl.

start(N) :-
	size(N,K),
	Max is N,
	loopForlace(1,K,N,Max).

loopForlace(I,TOP,N,Max) :-
	(
	I=<TOP->
	lace(N,I,Max),
	J is I+1,
	loopForlace(J,TOP,N,Max);
	write("")
		).

lace(N,I,Max) :-
	K is N-1,
	size(N,D1),
	size(K,D2),
	DN is D1-D2,
	HALFDN is DN/2,
	OnePlus is DN+1,
	NoOfStars is DN-I+1,

	(
		mod(N,2) =:= 1->
		(
			I =:=1 ->
			printStars(NoOfStars), lace(K,I,Max) ,printStars(NoOfStars)
			;
			
			I < DN ->
			NoOfSpaces is DN-I,
			printStars(1), tab(NoOfSpaces), lace(K,I,Max), tab(NoOfSpaces), printStars(1)
			;

			I =:= DN ->
			lace(K,I,Max)
			;

			I > OnePlus ->
			Delta is I- OnePlus,
			NewIndex is OnePlus- Delta,
			lace(N,NewIndex,Max);
			write("")
			)
		;

		Max>N->(
			I=<HALFDN ->
			M is 0,
			Z is 2*I-1,
			tab(M),
			alternateStarAndSpace(1,Z),
			tab(M),
			nl;
	
			I > OnePlus ->
			Delta is I- OnePlus,
			NewIndex is OnePlus- Delta,
			lace(N,NewIndex,Max);

			Index is I- HALFDN,
			spacesAndStar(I,DN),
			lace(K,Index,Max),
			spacesAndStarRevese(I,DN),
			nl

			);
	
	% If I is greater than DN+1 then subtract DN+1 from I, that will be delta.
	% and substitute I to I-Delta.

	(I=<HALFDN ->
	M is DN-I+1,
	Z is 2*I-1,
	tab(M),
	alternateStarAndSpace(1,Z),
	tab(M),
	nl;
	
	I > OnePlus ->
	Delta is I- OnePlus,
	NewIndex is OnePlus- Delta,
	lace(N,NewIndex,Max);

	Index is I- HALFDN,
	spacesAndStar(I,DN),
	lace(K,Index,Max),
	spacesAndStarRevese(I,DN),
	nl)).








