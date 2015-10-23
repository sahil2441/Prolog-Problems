%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% SAHIL JAIN
%%%%%%%%%%%% 110281300
%%%%%%%%%%%% COMPUTER SCIENCE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% BASICS FUNCTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

union([], List2, List2).
union([Head|Tail], List2, [Head|Result]) :- 
    \+ member(Head, List2),
    union(Tail, List2, Result).
union([Head|Tail], List2, Result) :-
    member(Head, List2),
    union(Tail, List2, Result).

delete1([H|T],H,T).
delete1([H|Ys],X,[H|Zs]):-
	delete1(Ys,X,Zs).

rev([],[]).
rev([H|T],L):-
	rev(T,L1),
	append(L1,[H],L).

append([],L,L).
append([H|T],X,[H|Y]):-
	append(T,X,Y).

length1([], 0).
length1([_|Xs], M):-
	length1(Xs, N),
	M is N+1.

member(X,[X|_]).
member(X,[_|Ys]):-
	member(X,Ys).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% HELPER FUNCTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
%%	Return a member such that its negation is also present
%%
get_element_to_be_deleted(L,X):-
	member(X,L),
	member(neg(X),L),
	!.

%%
%% Basic Rule of negation
%%
check_negation(neg(neg(A)),A):-!.
check_negation(A,A):-
	A=neg(_),
	!.

%%
%% Load a file of Prolog terms into a List.
%%
file_to_list(FILE,LIST) :- 
   see(FILE), 
   inquire([],R), % gather terms from file
   rev(R,LIST),
   seen.

inquire(IN,OUT):-
   read(Data), 
   (Data == end_of_file ->   % done
      OUT = IN 
        ;    % more
      inquire([Data|IN],OUT) ) .
%%
%% Write to a file from a List
%%
write_list_to_file(Filename,List) :-
    tell(Filename),     % open file to be written 
    loop_through_list(List),
    told.               % flush buffer   

loop_through_list([]).
loop_through_list([Head|Tail]) :-
    write(Head),
    nl,
    loop_through_list(Tail).

%%
%%	Changes the query element of list to clause with a negation sign
%%	Change the head of list
%%
convert_query_to_clause([H|T],L1):-
	H=myQuery(X,Y),
	A=myClause(X,neg(Y)),
	L1=[A|T].

%%
%%	Converts the or clause into the list
%%
convert_elements_to_list([],[]):-!.
convert_elements_to_list([H|T],L):-
	H=myClause(X,Y),
	convert_helper(Y,List),
	H1=myClause(X,List),
	convert_elements_to_list(T,L1),
	append(L1,[H1],L),
	!.

%%
%%	'Actually' Converts the or clause into the list
%%
convert_helper(X,L):-
	 X=or(A,B),
	 convert_helper(A,L1),
	 convert_helper(B,L2),
	 append(L1,L2,L).

convert_helper(X,L):-
	L=[X].	

%%
%%	Start the resolution process.
%%  If the last member of list has empty list of CNF then stop.
%%
start_resolution_process(L,L):-
	get_last_element(L,A),
	A=myClause(_,[]),
	!.
%%
%%	Start the resolution process --else
%%
start_resolution_process(L,Result):-
	
	get_last_element(L,A),
	A=myClause(I,L1),

	%% find which member list contnains H1. Returns a clause.
	%% find clause in the deleted list
	delete1(L,A,DeletedList),
	find_corresponding_clause_in_list(DeletedList,L1,X),
	X\=[],

	%% J to be used as interger in resolution
	J is I+1,
	X=myClause(N,Y),
	union(Y,L1,Z),
	get_element_to_be_deleted(Z,X),
	delete1(Z,X,Z1),
	delete1(Z1,neg(X),Z2),

	Result1=resolution(N,I,Z2,J),
	append(L,Result1,Result2),
	start_resolution_process(Result2,Result),
	!.

%%
%%	This only gets called if above method could not find any element list that contains negation of element.
%%	
start_resolution_process(L,Result):-
	X='The resolution doesnt evaluate to null/false.',
	append(L,[X],Result),
	!.

%%
%%	Returns last element of a list
%%
get_last_element(L,H):-
	rev(L,[H|_]).

%%
%%	Finds a corresponding clause in list whos list contains the negation of any element from the given list.
%%
find_corresponding_clause_in_list([],_,[]):-!.

find_corresponding_clause_in_list([H|_],L1,H):-
	H=myClause(_,B),
	findall(X,search(B,L1,X),L),
	length1(L,Length),
	Length>0,
	!.

find_corresponding_clause_in_list([_|T],L1,B):-
	find_corresponding_clause_in_list(T,L1,B),
	!.

%%
%%	Compares two lists to find a common member , if exists
%%
search(L1,L2,X):-
	member(X,L1),
	check_negation(neg(X),Y),
	member(Y,L2).







%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% MAIN CODE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hw4(INPUTFILE,OUTPUTFILE):-
	file_to_list(INPUTFILE,List),
	rev(List,RevL),
	convert_query_to_clause(RevL,L1),
	rev(L1,L2),
	convert_elements_to_list(L2,L3),
	rev(L3,L4),
	%%
	%%	More Work to do with L3
	%%
	start_resolution_process(L4,L5),
	write_list_to_file(OUTPUTFILE,L5).








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% TEST CASES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test(1,X) :- 
%	getInput(N,INPUTFILE),
%	getOutput(N,OUTPUTFILE),
%	hw4(INPUTFILE,OUTPUTFILE).


%%
%%	Testing
%%

	getL1(1,L1),
	getL2(1,L2),
	union(L1,L2,X).
	

getInput(1,INPUTFILE):-
	INPUTFILE='/Users/sahiljain/Dropbox/SBU/Academics/Fall_15/ComputingWithLogic/Assignments/Prolog/Fourth/input.txt'.

getOutput(1,OUTPUTFILE):-
	OUTPUTFILE='/Users/sahiljain/Dropbox/SBU/Academics/Fall_15/ComputingWithLogic/Assignments/Prolog/Fourth/output.txt'.	

getL1(1,L):-
	L=[a,b,c].
getL2(1,L):-
	L=[b,c,d].


getList(1,L):-
	L=[
		myClause(2,or(or(neg(a_2),b_2),b_3)),
		myClause(3,or(neg(b_2),b_3))
	].

getList1(1,L):-
	L=
	[
	myClause(1,[a_1,a_2]),
	myClause(2,[neg(a_2),b_2,b_3]),
	myClause(3,[neg(b_2),b_3]),
	myClause(4,[neg(b3)]),
	myClause(5,[neg(a_1)])
	].












