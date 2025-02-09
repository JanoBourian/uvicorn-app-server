import logging
import logging.config
import yaml
import os

LOG_CONFIG_FILE = os.getenv("LOG_CONFIG_FILE", "logs.yaml")


def configure_logger(name: str) -> logging.Logger:
    try:
        if os.path.exists(LOG_CONFIG_FILE):
            with open(LOG_CONFIG_FILE, "r") as f:
                log_config = yaml.safe_load(f)
                logging.config.dictConfig(log_config)
        else:
            logging.basicConfig(level=logging.INFO)

        logger = logging.getLogger(name)
        logger.debug(f"🔧 Logger initialized for {name}")
        return logger

    except Exception as e:
        logging.basicConfig(level=logging.DEBUG)
        logger = logging.getLogger(name)
        logger.error(f"⚠️ Failed to load logging configuration: {e}")
        return logger
