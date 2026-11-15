c = get_config()

# ブラウザを自動起動しない
c.ServerApp.open_browser = False

# このPC自身からのアクセスだけを受け付ける
c.ServerApp.ip = "127.0.0.1"

# URLを固定する
c.ServerApp.port = 8888
c.ServerApp.port_retries = 0
