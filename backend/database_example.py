from tinydb import TinyDB, Query
from pydantic import BaseModel
from typing import Optional

# 1. Define a Pydantic Model
class User(BaseModel):
    id: int
    name: str
    email: str
    age: Optional[int] = None

# 2. Initialize TinyDB
# This will create a 'db.json' file in your project directory
db = TinyDB('db.json')

# Clear the database for a clean start (optional)
db.truncate()

# 3. Insert data using the Pydantic model
def add_user(user: User):
    # Convert Pydantic model to a dictionary for TinyDB
    db.insert(user.model_dump())
    print(f"Added user: {user.name}")

# 4. Retrieve data from TinyDB and convert it back to a Pydantic model
def get_user_by_id(user_id: int) -> Optional[User]:
    UserQuery = Query()
    # Retrieve the dictionary from TinyDB
    user_data = db.get(UserQuery.id == user_id)
    if user_data:
        # Convert the dictionary back to a Pydantic model
        return User(**user_data)
    return None

def get_all_users():
    users = []
    for item in db.all():
        users.append(User(**item))
    return users

# --- Example Usage ---
if __name__ == "__main__":
    # Create some user instances using Pydantic
    user1 = User(id=1, name="Alice", email="alice@example.com", age=30)
    user2 = User(id=2, name="Bob", email="bob@example.com")
    user3 = User(id=3, name="Charlie", email="charlie@example.com", age=25)

    # Add users to the database
    add_user(user1)
    add_user(user2)
    add_user(user3)

    print("\n--- All Users ---")
    all_users = get_all_users()
    for user in all_users:
        print(user)

    print("\n--- Searching for a user ---")
    found_user = get_user_by_id(2)
    if found_user:
        print(f"Found user by ID: {found_user}")
    else:
        print("User not found.")

    print("\n--- Searching for a non-existent user ---")
    not_found_user = get_user_by_id(99)
    if not_found_user:
        print(f"Found user by ID: {not_found_user}")
    else:
        print("User not found.") 