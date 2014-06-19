# Algorithm outline:
# 1) Find all primes up to and including number.
# 2) Set lcm at 1.
# 3) Multiply lcm by the largest multiple of each prime that remains
#    below number.
def problem_05(number)
  lcm = 1
  prime_array = find_primes_below(number)
  prime_array.each do |prime|
    i = prime
    while i <= number
      lcm = lcm * prime
      i = i * prime
    end
  end
  return lcm
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

puts problem_05(20)