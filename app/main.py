from app.utils.helpers import configure_logger

logger = configure_logger("main")


async def app(scope, receive, send):
    logger.info(f"🚀 New connection: {scope}")
    logger.info(f"📦 Received: {await receive()}")

    assert scope["type"] == "http"
    await send(
        {
            "type": "http.response.start",
            "status": 200,
            "headers": [
                [b"content-type", b"text/plain"],
            ],
        }
    )
    await send(
        {
            "type": "http.response.body",
            "body": b"Hello, world!",
        }
    )
