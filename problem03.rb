# Algorithm outline:
# 1) Find all primes below sqrt(number)
# 2) Remove nonfactors from this list of primes
# 3) Multiply prime factors together. If they exceed sqrt(number), stop.
# 4) If not, find another factor to test for primality.
#    (note that we have found all potential factors in step #1)
# 5) If not prime, then keep repeating steps #3-4 for each new number
#    until a prime is found.
def problem_03(number)
  prime_list = find_primes_below(Math.sqrt(number).floor)
  prime_factors = Array.new()

  prime_list.each do |i|
    if is_factor_of(number, i)
      prime_factors.push(i)
    end
  end

  partial_fact = array_product(prime_factors)
  while partial_fact <= Math.sqrt(number)
    remaining_fact = number/partial_fact
    is_divisible_by = find_divisor(remaining_fact, prime_list)
    unless is_divisible_by
      prime_factors.push(remaining_fact)
    end
    partial_fact = array_product(prime_factors)
  end

  return prime_factors.max
end

# Returns an array of all primes below number, inclusive.
# Uses Sieve of Eratosthenes algorithm
def find_primes_below(number)
	primes = Array.new(number + 1, true)
  primes[0] = false
  primes[1] = false
  prime_count = primes.length - 2
	index = 2
	while index < primes.length
		multiple = 2
    number_not_prime = index * multiple
    while number_not_prime < primes.length
      if primes[number_not_prime] == true
        primes[number_not_prime] = false
        prime_count = prime_count - 1
      end
      multiple = multiple + 1
      number_not_prime = index * multiple
    end
    index = index + 1
	end
  
  # Convert boolean array to integer array
  prime_integers = Array.new(prime_count, nil)
  count = 0
  (0..primes.length).each do |i|
    if primes[i] == true
      prime_integers[count] = i
      count = count + 1
    end
  end
  return prime_integers
end

def is_factor_of(number, candidate)
  if number % candidate == 0
    return true
  else
    return false
  end
end

# Finds a divisor for number in array. Returns false if no divisor is found.
def find_divisor(number, array)
  array.each do |i|
    if number % i == 0
      return i
    end
  end
  return false
end

def array_product(array)
  product = 1
  array.each do |i|
    product = product * i
  end
  return product
end
 
puts problem_03(600851475143)
