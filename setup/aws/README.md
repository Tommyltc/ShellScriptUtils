# AWS Note
### Setup Load balancer

1. Prepare SSL cert
2. SSL cert domain should be `tommyltc.com`
3. Create cert in **Certificate Manager**
4. To validate the domain ownership, create CNAME record in DNS (Godaddy)
5. Provided info in aws cert manager

||Name|Value|
|-|-|-|
|Showing in AWS|\_16e420f40a9b93209bfbf9e395d6cf65.tommyltc.com.|\_62c8585f3595d073f89194f552facde6.hkvuiqjoua.acm-validations.aws.|
|Input to Godaddy|\_16e420f40a9b93209bfbf9e395d6cf65| \_62c8585f3595d073f89194f552facde6.hkvuiqjoua.acm-validations.aws|

6. Wait for validation _**arround half an hour**_
7. Create load balancer for instance and got a **DNS name**
8. Create CNAME record in DNS in DNS (Godaddy)

||Name|Value|
|-|-|-|
|Showing in AWS||MyLoadbalance-253777324.ap-northeast-1.elb.amazonaws.com|
|Input to Godaddy|*|MyLoadbalance-253777324.ap-northeast-1.elb.amazonaws.com|

9. Set listener in HTTP:80 & HTTPS:443 with cert
10. Set Forwarding rules if necessary (Rules matching and forward to **Target Groups**)
  1. Setup **Target Groups**
  2. Create group and mapping the Load balancer to ec2 instance port
  3. set Forwarding rules
  2. if host is web.tommyltc.com then forward to **Target Groups**
