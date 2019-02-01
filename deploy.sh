docker build -t pavloandriiesh/multi-client:latest -t pavloandriiesh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pavloandriiesh/multi-server:latest -t pavloandriiesh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pavloandriiesh/multi-worker:latest -t pavloandriiesh/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pavloandriiesh/multi-client:latest
docker push pavloandriiesh/multi-server:latest
docker push pavloandriiesh/multi-worker:latest


docker push pavloandriiesh/multi-client:$SHA
docker push pavloandriiesh/multi-server:$SHA
docker push pavloandriiesh/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=pavloandriiesh/multi-client:$SHA
kubectl set image deployments/server-deployment server=pavloandriiesh/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=pavloandriiesh/multi-worker:$SHA

