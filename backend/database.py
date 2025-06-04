from tinydb import TinyDB, table
from tinydb.middlewares import CachingMiddleware
from tinydb.storages import JSONStorage
from .config import settings

# Using CachingMiddleware for performance
# storage = CachingMiddleware(JSONStorage)
# db = TinyDB(settings.DATABASE_URL, storage=storage)

# Simpler setup without CachingMiddleware for now, can be added if performance becomes an issue.
db = TinyDB(settings.DATABASE_URL)

# Define tables (collections)
UserTable = db.table('users')
GymTable = db.table('gyms')
GroupActivityTeamTable = db.table('group_activity_teams')
# Potentially a table for Revoked Tokens if using a blacklist strategy for JWT logout
# RevokedTokenTable = db.table('revoked_tokens')

# You can also get a table instance dynamically if needed:
# def get_table(table_name: str) -> table.Table:
#     return db.table(table_name)

# Ensure proper closure of the DB if necessary, though TinyDB typically handles this well.
# def close_db():
#     db.close() 