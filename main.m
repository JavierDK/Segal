function main
N = 50;
for i = 1:1:N
	for j = 1:1:N
		if (i == j)
			good(i,j) = 1;		
		else
			good(i,j) = abs(i-j)/(N^2);
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

%simpleIteration(good, b', 10);
%simpleIteration(bad, b', 100);
%seidelIteration(good, b', 10);
%seidelIteration(bad, b', 500);
%sqRelaxation(good, b', 10, 0.8);
%sqRelaxation(bad, b', 500, 1.1);
%conjGradient(good, b', 30)
%conjGradient(bad, b', 500)
gauss(good, b');


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

function simpleIteration (A, b, it)
	x = b;
	C = eye(length(b)) - A;
	for i = 1:1:it
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

function seidelIteration (A, b, it)
	x = b;
	N = length(b);
	C = eye(N) - A;
	for i = 1:1:it
		indep(i) = i;
		new_x = x;
		v = A*x - b;
		val(i) = norm(v');
		for j = 1:1:N
			new_x(j) = (C*new_x + b)(j);
		end;
		v = new_x - x;
		an_val(i) = norm(v');
		x = new_x;
	end
	plot(indep, val, "1", indep, an_val, "3");
end;


function sqRelaxation(A, b, it, alpha)
	x = b;
	N = length(b);
	C = eye(N) - A;
	for i = 1:1:it
		indep(i) = i;
		new_x = x;
		v = A*x - b;
		val(i) = norm(v');
		for j = 1:1:N
			new_x(j) = (C*new_x + b)(j);
		end;
		new_x = alpha*new_x + (1 - alpha)*x;
		v = new_x - x;
		an_val(i) = norm(v');
		x = new_x;
	end
	plot(indep, val, "1", indep, an_val, "3");
end

function conjGradient(A, b, it)
	x = b;
	N = length(b);
	p_prev = zeros(N,1);
	for i = 1:1:it
		indep(i) = i;
		g = A*x - b;
		if (i == 1)
			koeff = 0;
		else
			koeff = g'*(A*p_prev)/(p_prev'*(A*p_prev));
		end
		v = A*x - b;
		val(i) = norm(v');
		p = -g + koeff*p_prev;
		alpha = - (g'*p)/(p'*(A*p));
		next_x = x + alpha*p;
		v = next_x - x;
		an_val(i) = norm(v');
		x = next_x;
		p_prev = p;
	end
	plot(indep, val, "1", indep, an_val, "3");
end

function val = fi(A, b, x)
	val = 0;
	val = 0.5*(A*x)'*x - b'*x ;
end

function res = getMax(arr, used)
	N = length(used);
%	disp(used);
	arr = abs(arr);
	[sarr, ind] = sort(-arr);
	res = -1;
	for i = 1: 1: N
		if (used(ind(i)) == 0 & res == -1)
			res = ind(i);
			return;
		end;
	end
end

function gauss(A, b)
	N = length(b);
	for i = 1:1:N
		used(i) = 0;
		x(i) = 0;
	end
	for i = 1:1:N
		ind = getMax(A(i, :), used);
%		disp(ind);
		used(ind) = 1;
		ord(i) = ind;
		for j = i+1:1:N
			div = A(j, ind)/ A(i, ind);
			A(j, :) = A(j, :) .- div * A(i, :);
			b(j) = b(j) - div*b(i); 
		end
	end
	for i = N:-1:1
		x(ord(i)) = b(i) - A(i, :)*x';
		x(ord(i)) = x(ord(i))/A(i, ord(i));
	end;
	disp(norm((A*x' - b)'));
end

