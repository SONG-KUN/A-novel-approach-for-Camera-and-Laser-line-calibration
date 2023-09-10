function [ L_matrix, L,L_matrix_dual] = PluckerLineFromTwoPlanes(A,B)

%PluckerLineFromTwoPlanes:
% Input: two column vectors of 4 elements with plane parameters a,b,c,d ->
% ax+by+cz+d=0
%Output:    4x4 matrix L_matrix accordingly to Zissermann second edition page 70
%           column vector of 6 elements L (l_14:l_24:l_34:l_23:l_13:l_12)
%           4x4 matrix L_matrix accordingly to Zissermann second edition page 70
%   Note: the line represented by Zissermann is a vector of 6 elements L (l_12:l_13:l_14:l_23:l_42:l_34)
L_matrix=zeros(4,4);
L_matrix_dual=A*B'-B*A';
L_matrix(1,2)=L_matrix_dual(3,4);
L_matrix(1,3)=L_matrix_dual(2,4);
%L_matrix(1,3)=L_matrix_dual(4,2); % accordingly to Zissermann
L_matrix(1,4)=L_matrix_dual(2,3);
L_matrix(2,3)=L_matrix_dual(1,4);
L_matrix(2,4)=L_matrix_dual(1,3);
%L_matrix(4,2)=L_matrix_dual(1,3); % accordingly to Zissermann
L_matrix(3,4)=L_matrix_dual(1,2);

L_matrix(2,1)=-L_matrix_dual(3,4);
L_matrix(3,1)=-L_matrix_dual(2,4);
L_matrix(4,1)=-L_matrix_dual(2,3);
L_matrix(3,2)=-L_matrix_dual(1,4);
L_matrix(4,2)=-L_matrix_dual(1,3);
L_matrix(4,3)=-L_matrix_dual(1,2);

%L=[L_matrix(1,2) L_matrix(1,3) L_matrix(1,4) L_matrix(2,3) L_matrix(4,2) L_matrix(3,4)]; % accordingly to Zissermann
L=[L_matrix(1,4) L_matrix(4,2) L_matrix(3,4) L_matrix(2,3) L_matrix(1,3) L_matrix(1,2)];

end

