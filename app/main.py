from fastapi import FastAPI

app = FastAPI(title="DevSecOps Demo")

@app.get("/health")
def health():
    return {"status": "ok"}
