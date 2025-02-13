# uvicorn-app-server
An uvicorn app server to test some uvicorn features and other kind of technologies


## Uvicorn

```bash
uvicorn app.main:app --host '0.0.0.0' --port 8000 --reload --env-file .env --log-config logs.yaml --log-level trace --access-log --use-colors
```

## Starting and ending the project using Makefile

```bash
make setup
make clean
```