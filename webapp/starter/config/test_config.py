if __name__ == '__main__':
    import sys
    sys.path.append("../../")
from starter.config.config_reloader import env_config_checker
def test_env_config_checker():
    env_config_checker()

if __name__ == '__main__':
    test_env_config_checker()