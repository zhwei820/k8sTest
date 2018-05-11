
from multiprocessing import Process
import os, time
from starter.config.config_util import load_config_from_env

import logging

_logger = logging.getLogger(__name__)


# 子进程要执行的代码
def run_loop(env_key="appsettings"):
    """
    死循环  定时检测配置是否更新
    :param env_key:
    :return:
    """

    def reload_app(new_settings):
        """
        hot reload app
        :return:
        """
        res = os.popen("kill -HUP `ps -ef|grep /uwsgi/| grep -v grep | awk '{print $2 }'`;").readlines()
        _logger.info("应用配置更新!! \nnew_settings: %s , \nreload res: %s," % (new_settings, res))

    settings = ""
    while True:
        new_settings = load_config_from_env(env_key)
        if settings and new_settings and new_settings != settings:
            reload_app(new_settings)
        settings = new_settings
        time.sleep(2)


def env_config_checker():
    p = Process(target=run_loop, args=())
    p.start()
    p.join()
