%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% SAHIL JAIN
%%%%%%%%%%%% 110281300
%%%%%%%%%%%% COMPUTER SCIENCE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% BASICS FUNCTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rev([],[]).
rev([H|T],L):-
	rev(T,L1),
	append(L1,[H],L).

append([],L,L).
append([H|T],X,[H|Y]):-
	append(T,X,Y).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% HELPER FUNCTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% MAIN CODE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hw4(INPUTFILE,OUTPUTFILE):-
	file_to_list(INPUTFILE,List),
	rev(List,RevL),
	convert_query_to_clause(RevL,L1),
	rev(L1,L2),
	%%
	%%	More Work to do with L2
	%%
	convert_elements_to_list(L2,L3),
	rev(L3,L4),
	write_list_to_file(OUTPUTFILE,L4).








%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% TEST CASES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

test(1) :- 
	getInput(N,INPUTFILE),
	getOutput(N,OUTPUTFILE),
	hw4(INPUTFILE,OUTPUTFILE).


	%%
	%%	Testing convert list
	%%

%	getList(1,L),
%	convert_elements_to_list(L,N).

getInput(1,INPUTFILE):-
	INPUTFILE='/Users/sahiljain/Dropbox/SBU/Academics/Fall_15/ComputingWithLogic/Assignments/Prolog/Fourth/input.txt'.

getOutput(1,OUTPUTFILE):-
	OUTPUTFILE='/Users/sahiljain/Dropbox/SBU/Academics/Fall_15/ComputingWithLogic/Assignments/Prolog/Fourth/output.txt'.	

getList(1,L):-
	L=[
		myClause(2,or(or(neg(a_2),b_2),b_3)),
		myClause(3,or(neg(b_2),b_3))
	].













