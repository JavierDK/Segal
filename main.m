function main
N = 50;
for i = 1:1:N
	for j = 1:1:N
		if (i == j)
			good(i,j) = 1;		
		else
			good(i,j) = abs(i-j)/(N^4);
		end
	end
end

for i = 1:1:N
	for j = 1:1:N
		bad(i, j) = 1/(i + j - 1);
	end
end

for i = 1:1:N
	b(i) = unifrnd(-1, 1);
end

disp(norm(b));

ret_value = 0;

%disp(good)

%disp(bad)

end;


function res = norm ( x )
  res = 0;
  if (isvector(x))
	res = sqrt(x*x');
  else
	error("Not a vector");
  end
end;