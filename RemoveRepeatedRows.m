function result = RemoveRepeatedRows(A)
 index = [];
 for i=1:size(A,1)-1
   for j=i+1:size(A,1)
     if A(i,:) == A(j,:)
       index = [index j];
     end
   end
 end
 A(index,:) = [];
 result = A;
end

