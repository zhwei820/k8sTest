import codecs
import os

import yaml
import logging
_logger = logging.getLogger(__name__)

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def load_config_from_file(file_path):
    setting_config = {}
    with codecs.open(file_path, mode='rb', encoding="utf-8") as f:
        setting_config.update(yaml.load(f))
    return setting_config

def load_config_from_env(env_key = "appsettings"):
    """
    从（docker）环境变量中取配置, k8s pod中指定对应的configMap， 更新对应的configMap， 就能更新应用配置
    :param env_key:
    :return:
    """
    setting_config = {}
    print(len(os.environ))
    print(os.environ)

    try:
        env_val = os.environ.get(env_key, "")
        setting_config = yaml.load(env_val)
    except Exception as e:
        _logger.error(e)
    return setting_config


def get_conf():
    config = load_config_from_env() or load_config_from_file(os.path.join(BASE_DIR, "settings.yaml"))

    return config


config = get_conf()