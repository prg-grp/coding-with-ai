# 18 Code Reviews

In many organzations, when a programmer writes some code, the code is not integrated in production before a fellow programmer checks that it does not contain any issue. This process is referred to as code review and it is adopted by many software companies.

https://developers.google.com/blockly/guides/contribute/get-started/pr_review_process


## 18.1 Review of Hashing Code

Using your favorite AI tool, write a code review for the following code snippet.



```python
import hashlib
import json
import os

CREDENTIALS_FILE = "users.json"

def load_users():
    """Load user data from file."""
    if not os.path.exists(CREDENTIALS_FILE):
        return {}
    with open(CREDENTIALS_FILE, "r") as f:
        return json.load(f)

def save_users(users):
    """Save user data to file."""
    with open(CREDENTIALS_FILE, "w") as f:
        json.dump(users, f)

def hash_password_md5(password):
    """Hash a password using MD5."""
    return hashlib.md5(password.encode()).hexdigest()

def register_user(users):
    username = input("Choose a username: ")
    if username in users:
        print("❌ Username already exists.")
        return
    password = input("Choose a password: ")
    users[username] = hash_password_md5(password)
    save_users(users)
    print("✅ Registration successful.")

def login_user(users):
    username = input("Username: ")
    password = input("Password: ")
    hashed = hash_password_md5(password)
    if username in users and users[username] == hashed:
        print("✅ Login successful!")
    else:
        print("❌ Invalid username or password.")

def main():
    users = load_users()

    while True:
        print("\n=== Simple Password Manager ===")
        print("1. Register")
        print("2. Login")
        print("3. Exit")
        choice = input("Choose an option: ")

        if choice == "1":
            register_user(users)
        elif choice == "2":
            login_user(users)
        elif choice == "3":
            break
        else:
            print("Invalid option.")

if __name__ == "__main__":
    main()
```

**Hint:** The review shoudl consider that MD5 is not secure for password storage in real applications—use bcrypt, argon2, or pbkdf2 for real-world scenarios


## 18.2 Review of database accessc code

Using your favorite AI tool, write a code review for the following code snippet.



```python
import sqlite3
import os

DB_FILE = "example.db"

def setup_database():
    """Create a users table and insert a sample user."""
    if os.path.exists(DB_FILE):
        os.remove(DB_FILE)

    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    c.execute("CREATE TABLE users (username TEXT, password TEXT)")
    c.execute("INSERT INTO users VALUES ('admin', 'password123')")
    conn.commit()
    conn.close()

def vulnerable_login(username, password):
    """Login function vulnerable to SQL injection."""
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    
    # ⚠️ Vulnerable line: unsafely constructing SQL
    query = f"SELECT * FROM users WHERE username = '{username}' AND password = '{password}'"
    print(f"Running query: {query}")
    
    c.execute(query)
    result = c.fetchone()
    conn.close()

    if result:
        print("✅ Login successful!")
    else:
        print("❌ Login failed.")

def main():
    setup_database()

    print("=== Insecure Login Demo ===")
    username = input("Username: ")
    password = input("Password: ")

    vulnerable_login(username, password)

if __name__ == "__main__":
    main()
```

**Hint:** This code is intentionally insecure and should never be used in a real application. It’s strictly for teaching purposes to highlight the dangers of SQL injection.


## 18.3 Checklists for Code Reviews

It is common practice to use checklists to ensure that all important aspects of the code are reviewed. For example, both ISO and IEEE provide checklists for code reviews [1] [2]. Ask the AI to write a code review (e.g., of one of the code snippets above) using Google's checklist for code reviews availanble at: https://google.github.io/eng-practices/review/reviewer/looking-for.html

[1] IEEE Std 1028-2008: IEEE Standard for Software Reviews and Audits ￼ ￼.

[2] ISO/IEC 20246:2017: Software and systems engineering – Work product reviews ￼







