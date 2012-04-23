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


ret_value = 0;

%simpleIteration(good, b');
%simpleIteration(bad, b');
seidelIteration(good, b');
%seidelIteration(bad, b');
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

function simpleIteration (A, b)
	x = b;
	C = eye(length(b)) - A;
	for i = 1:1:100
		indep(i) = i;
		v = A*x - b;
		val(i) = norm(v');
		new_x = C*x + b;
		v = new_x - x;
		an_val(i) = norm(v');
		x = new_x;
	end;
	plot(indep, val, "1", indep, an_val, "3");
end;

function seidelIteration (A, b)
end;