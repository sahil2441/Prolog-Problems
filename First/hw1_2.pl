
tartan(1):-
	write("*").

tartan(N):-
%Upper Half
	loop(N,1).
%Center Line
%	printTartan(N,N).

loop(N,I):-
	Size is 2*N-1,
	(
	I=<Size->
	J is I+1,

	(I>N->
		K is N-(I-N),
		printTartan(N,K)
		;
		printTartan(N,I)
		),
	nl,
	loop(N,J);
	write("")
	).

printStars(0).
printStars(N):-
	write('*'),
	M is N-1,
	printStars(M).

printTartan(1,1):- write("*").
printTartan(N,I):-
	Size is 2*N-1,
	M is N-1,
	J is I-1,
	(
	mod(N,2)=:=0->
		(
		I =:=1->
		printStars(Size)
		;
		tab(1),printTartan(M,J),tab(1)
		)

	;
		(
		I =:=1->
		Spaces is Size-2,
		printStars(1),tab(Spaces),printStars(1)
		;
		printStars(1), printTartan(M,J), printStars(1)
		)
	).
