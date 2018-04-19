function [L,U,P] = luFactor(A)
%luFactor This function uses LU Decomposition to factorize a square matrix
%   INPUTS:
%       A- the matrix to be factorized (must be a square matrix)
%   OUTPUTS:
%       L- lower triangular matrix containing the ratios used for
%       elimination
%       U- upper triangular matrix containing the results of the Gauss
%       elimination with pivoting
%       P- a permutation matrix that describes the resulting matrix of
%       pivoting
[row_number,column_number]=size(A); %takes in the size of the matrix 
if row_number~=column_number || (row_number==1&&column_number==1) %checks to make sure the matrix is square and not a single number
    error("Please input valid a square matrix")
end
P=eye(row_number,column_number); %Initializes the permutation matrix with the same dimensions as A
L=zeros(row_number,column_number);
U=A; %Initializes U as A so A isn't changed in the process of the function
for j=1:column_number-1
    maxValueCheck=max(abs(U(j:row_number,j))); %Checks for the maximum value needed for pivoting
    for i=1:row_number
        if maxValueCheck==abs(U(i,i)) %If the maximum value DOESNT need to be pivoted around it will use this process.
            for new_counter=j:(row_number-1)
                modifier_ratio=(U((new_counter+1),j)/U(j,j)); %Calculates the ratio used for elimination
                modifier_row=U(j,:).*modifier_ratio; %Multiplies the row above the terms being eliminated by the ratio
                U((new_counter+1),:)=U((new_counter+1),:)-modifier_row; %Stores the new "modified" row in its correct place in the U matrix 
                L((new_counter+1),j)=modifier_ratio; %Stores the new ratio in its correct place in the L matrix
            end
        elseif maxValueCheck==abs(U(i,j)) %If the maximum value DOES need to be pivoted around it will use this process.
            pivPos=i; %Stores the row to pivot upwards as pivPos
            U([pivPos j],:)=U([j pivPos],:); %Pivots the U matrix
            P([pivPos j],:)=P([j pivPos],:); %Pivots the P matrix
            L([pivPos j],:)=L([j pivPos],:); %Pivots the L matrix
            for new_counter=j:(row_number-1)
                modifier_ratio=(U((new_counter+1),j)/U(j,j)); %Calculates the ratio used for elimination
                modifier_row=U(j,:).*modifier_ratio; %Multiplies the row above the terms being eliminated by the ratio
                U((new_counter+1),:)=U((new_counter+1),:)-modifier_row; %Stores the new "modified" row in its correct place in the U matrix 
                L((new_counter+1),j)=modifier_ratio;  %Stores the new ratio in its correct place in the L matrix
            end
        end
    end
end
L_identity=eye(row_number,column_number); %Creates an identity matrix to place "1"s across the diagonal of the L matrix
L=L+L_identity; %Adds the generated "1"s to the L matrix
%display(U)
%display(L)
%display(P)
end