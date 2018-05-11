import codecs
import os

import yaml
import logging
_logger = logging.getLogger(__name__)

# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

setting_path = os.path.join(BASE_DIR, "settings.yaml")

def load_config_from_file(file_path):
    """
        从（docker）文件中取配置, k8s pod中指定对应的configMap， 更新对应的configMap， 就能更新应用配置

    :param file_path:
    :return:
    """
    setting_config = {}
    with codecs.open(file_path, mode='rb', encoding="utf-8") as f:
        setting_config.update(yaml.load(f))
    return setting_config


def get_conf():
    config = load_config_from_file(setting_path)

    return config


config = get_conf()