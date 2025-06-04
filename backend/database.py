from tinydb import TinyDB
from tinydb.storages import JSONStorage
from datetime import datetime, date
import json
from pydantic import HttpUrl
from .config import settings

class DateTimeEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, (datetime, date)):
            return obj.isoformat()
        elif isinstance(obj, HttpUrl):
            return str(obj)
        return super().default(obj)

class CustomJSONStorage(JSONStorage):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.kwargs['cls'] = DateTimeEncoder

db = TinyDB(settings.DATABASE_URL, storage=CustomJSONStorage)

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