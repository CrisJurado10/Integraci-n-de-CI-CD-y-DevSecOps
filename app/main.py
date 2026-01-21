from fastapi import FastAPI

app = FastAPI(title="DevSecOps Demo")
#Testing class
@app.get("/health")
def health():
    return {"status": "ok"}
