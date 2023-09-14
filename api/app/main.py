"""Main file of the api."""

from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def main() -> str:
    """Main controller of the api."""    
    return "Hello world"