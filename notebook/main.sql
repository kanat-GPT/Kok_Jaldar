from langchain.agents import AgentExecutor, create_tool_calling_agent
from langchain_core.prompts import ChatPromptTemplate
from langchain_community.tools.sql_database.tool import QuerySQLDataBaseTool, InfoSQLDatabaseTool, ListSQLDatabaseTool
from langchain_community.utilities import SQLDatabase

# 1. Подключаемся к базе (у тебя уже есть db)
# db = SQLDatabase.from_uri("твоя_строка_подключения")

# 2. Создаём инструменты (обязательно!)
tools = [
    QuerySQLDataBaseTool(db=db),        # выполняет любые SQL-запросы
    InfoSQLDatabaseTool(db=db),         # показывает структуру таблиц
    ListSQLDatabaseTool(db=db),         # список таблиц
]

# 3. Жёсткий промпт — чтобы агент вёл себя как надо
prompt = ChatPromptTemplate.from_messages([
    ("system", """
Ты — аналитик данных в компании.
Для каждой бизнес-задачи строго следуй шаблону:

1. Придумай понятное имя VIEW на английском в CamelCase (например: RevenueByCategory, TopProductsByMargin)
2. Создай его: CREATE OR REPLACE VIEW имя_вью AS SELECT ...
3. СРАЗУ ЖЕ выполни: SELECT * FROM имя_вью ORDER BY выручка DESC LIMIT 20
4. В Final Answer покажи только:
   - Короткий вывод на русском (2–3 предложения)
   - Таблицу с результатами

НИКОГДА не заканчивай после CREATE VIEW.
Всегда делай SELECT из только что созданного VIEW.
Не пиши SQL в Final Answer, если пользователь явно не просит.
"""),
    ("placeholder", "{chat_history}"),
    ("human", "{input}"),
    ("placeholder", "{agent_scratchpad}"),
])

# 4. Создаём агента новым способом (2024–2025 стандарт)
agent = create_tool_calling_agent(llm=llm, tools=tools, prompt=prompt)

agent_executor = AgentExecutor(
    agent=agent,
    tools=tools,
    verbose=True,
    handle_parsing_errors=True,   # спасает от всех OutputParserException
    max_iterations=20
)

# 5. Теперь можно запускать!
result = agent_executor.invoke({
    "input": "Какие категории и товары приносят больше всего выручки? Создай VIEW и покажи топ."
})

print(result["output"])