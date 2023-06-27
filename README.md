
1. Listar o nome dos services em execução e obter o nome do serviço relacionado ao Nginx
```bash
docker service ls --format {{.Name}} | grep nginx
docker container ls --format {{.Names}} | grep nginx
```

2. Atribuir o valor das váriaveis
```bash
export nginx_service=$(docker container ls --format {{.Names}} | grep nginx)
export nginx_container=$(docker container ls --format {{.Name}} | grep nginx)
```
3. Validar imprimindo o valor da variável
```bash
echo $nginx_service, $nginx_container
```
4. Parar o serviço
```bash
docker service scale $nginx=0
```
5. Aguardar 10 segundos para o overall do serviço
```bash
sleep 10
```

6. Copiar os certificados para dentro do container
```bash
docker cp README.md $nginx:/usr/share/nginx/html
```

7. Start the service
```bash
docker service scale $nginx=1
```
