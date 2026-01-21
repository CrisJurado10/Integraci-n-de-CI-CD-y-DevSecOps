from fastapi import FastAPI

app = FastAPI(title="DevSecOps Demo")
#Testing class 2
@app.get("/health")
def health():
    return {"status": "ok"}
