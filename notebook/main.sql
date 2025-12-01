from langchain_community.tools.sql_database.tool import QuerySQLDataBaseTool
from langchain_community.utilities import SQLDatabase
from langchain.agents import initialize_agent, AgentType
from langchain_google_genai import ChatGoogleGenerativeAI
from langchain.prompts import SystemMessagePromptTemplate
from langchain.schema import SystemMessage
import os


# --- API KEY ---
os.environ["GOOGLE_API_KEY"] = "AIzaSyDxgUeydspoMTOUh0GzdFhBFYTmLPuPkww"

# --- DATABASE ---
db = SQLDatabase.from_uri(
    "mysql+mysqlconnector://root:0898811657@localhost:3306/qwer"
)
tool = QuerySQLDataBaseTool(db=db)
system_message = SystemMessage(content="""
Ты — SQL-ассистент, работающий строго с БД MySQL.
Всегда используй синтаксис MySQL.

ЗАПРЕЩЕНО:
- использовать sqlite_master
- использовать PRAGMA
- писать SQL для SQLite
- использовать ключевые слова или функции SQLite

ОБЯЗАТЕЛЬНО:
- Использовать INFORMATION_SCHEMA для получения списков таблиц
- Использовать DESCRIBE или SHOW CREATE TABLE для структуры
- Писать SQL, совместимый только с MySQL 5.7+ / MySQL 8+
""")
# --- LLM ---
llm = ChatGoogleGenerativeAI(
    model="gemini-2.5-flash",
    temperature=0
)

# --- AGENT ---
agent = initialize_agent(
    tools=[tool],
    llm=llm,
    agent=AgentType.ZERO_SHOT_REACT_DESCRIPTION,
    verbose=True
)

# --- RUN ---
response = agent.run("Сколько строк во всех таблицах?")
print(response)