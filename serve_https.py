import http.server
import ssl
import sys
import os

PORT = 8443
DIRECTORY = "build/web"

class Handler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=DIRECTORY, **kwargs)

    def end_headers(self):
        # Enable cross-origin headers and camera permissions
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Cross-Origin-Opener-Policy', 'same-origin')
        self.send_header('Cross-Origin-Embedder-Policy', 'credentialless')
        self.send_header('Cache-Control', 'no-cache, no-store, must-revalidate')
        self.send_header('Pragma', 'no-cache')
        self.send_header('Expires', '0')
        super().end_headers()

if __name__ == '__main__':
    server_address = ('0.0.0.0', PORT)
    httpd = http.server.HTTPServer(server_address, Handler)
    
    context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
    context.load_cert_chain(certfile='server_ssl/cert.pem', keyfile='server_ssl/key.pem')
    httpd.socket = context.wrap_socket(httpd.socket, server_side=True)
    
    print(f"Serving HTTPS on https://0.0.0.0:{PORT} from {DIRECTORY}")
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\nStopping HTTPS server.")
        sys.exit(0)
