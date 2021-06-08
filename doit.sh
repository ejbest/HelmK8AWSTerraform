set -x
rm -Rf ./mychart
helm create mychart
helm install example ./mychart --set service.type=NodePort
export NODE_PORT=$(kubectl get --namespace default -o jsonpath="{.spec.ports[0].nodePort}" services example-mychart)
export NODE_IP=$(kubectl get nodes --namespace default -o jsonpath="{.items[0].status.addresses[0].address}")
echo http://$NODE_IP:$NODE_PORT/
sleep 5
curl http://$NODE_IP:$NODE_PORT/
