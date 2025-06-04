import chainlit as cl
from chainlit import run_sync
from langchain.tools import BaseTool


class HumanInputChainlit(BaseTool):
    """Tool that permet de poser une question à l’utilisateur en direct."""

    name = "human"
    description = (
        "Tu peux poser une question à l'humain si tu as besoin de clarification ou d'une réponse que tu ne peux pas inférer."
    )
    user_profile = ""

    def _run(
        self,
        query: str,
        run_manager=None,
    ) -> str:
        """Utilise l’outil pour poser une question à l’utilisateur."""

        res = run_sync(cl.AskUserMessage(content=query).send())
        if res:
            return res["content"]
        else:
            return "L'utilisateur n'a pas répondu"
