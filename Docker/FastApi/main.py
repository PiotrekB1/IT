from fastapi import FastAPI
import os
app = FastAPI()

env_var = os.getenv("RESPONSE")
@app.get("/")
def serve_main():
    return {"message": env_var}
