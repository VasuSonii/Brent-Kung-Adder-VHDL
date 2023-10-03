import random

# Function to generate a random 32-bit binary string
def generate_random_binary():
    return ''.join(random.choice('01') for _ in range(32))

# Function to perform binary addition of two 32-bit numbers
def binary_addition(a, b, carry_in):
    result = []
    carry = carry_in
    
    for i in range(31, -1, -1):
        bit_a = int(a[i])
        bit_b = int(b[i])

        sum_bit = bit_a ^ bit_b ^ carry
        carry = (bit_a & bit_b) | (carry & (bit_a ^ bit_b))

        result.insert(0, str(sum_bit))

    return ''.join(result), carry

# Generate and write test cases to the file
with open("testcases.txt", "w") as file:
    for _ in range(7):
        input1 = generate_random_binary()
        input2 = generate_random_binary()
        input_carry = random.randint(0, 1)  # Random carry input, either 0 or 1
        result, output_carry = binary_addition(input1, input2, input_carry)
        
        # Concatenate input carry with both operands
        # Concatenate output carry with the result
        testcase = str(input_carry) + input1 + input2 + " " + str(output_carry) + result+ "\n"
        file.write(testcase)

