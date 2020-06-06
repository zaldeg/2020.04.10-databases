import random

a = "qwertyuiopasdfghjklzxcvbnm"
a = list(a)
print(a)
# UPDATE media SET file_name = 'hello' where id = 1
with open("4000words.txt", "w") as file:
    for i in range(1, 4001):
        word = "".join(
            [a[random.randint(0, len(a) - 1)] for i in range(random.randint(4, 9))]
        )
        file.write(f"UPDATE media SET file_name = '{word}' WHERE id = {i};\n")
