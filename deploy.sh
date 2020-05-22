docker build -t mkayhan/multi-client:latest -t mkayhan/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t mkayhan/multi-server:latest -t mkayhan/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t mkayhan/multi-worker:latest -t mkayhan/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push mkayhan/multi-client:latest
docker push mkayhan/multi-server:latest
docker push mkayhan/multi-worker:latest

docker push mkayhan/multi-client:$GIT_SHA
docker push mkayhan/multi-server:$GIT_SHA
docker push mkayhan/multi-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=mkayhan/multi-server:$GIT_SHA 
kubectl set image deployments/client-deployment client=mkayhan/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=mkayhan/multi-worker:$GIT_SHA