docker build -t aidfgdocker/multi-client:latest -t aidfgdocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aidfgdocker/multi-server:latest -t aidfgdocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aidfgdocker/multi-worker:latest -t aidfgdocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push aidfgdocker/multi-client:latest
docker push aidfgdocker/multi-server:latest
docker push aidfgdocker/multi-worker:latest

docker push aidfgdocker/multi-client:$SHA
docker push aidfgdocker/multi-server:$SHA
docker push aidfgdocker/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=aidfgdocker/multi-server:$SHA
kubectl set image deployments/client-deployment client=aidfgdocker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aidfgdocker/multi-worker:$SHA
