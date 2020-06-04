RSRC='vpcendpoint-sts'

date
aws cloudformation create-stack --stack-name unsupervised-infra-test-$RSRC-stack \
  --template-body file://templates/unsupervised-infra-test-$RSRC-stack.yaml \
  --parameters ParameterKey=ParameterEnvironmentSlug,ParameterValue=infra-test \
  --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM

# s3
# iam
# vpc
# cluster
# nodegrp
# nodegrpnodesaz1
# nodegrpnodesaz2
# efs
# vpcendpoint-sts

###########
#vpc
###########
               #ParameterKey=ParameterAvailabilityZone01,ParameterValue=us-east-1a \
               #ParameterKey=ParameterAvailabilityZone02,ParameterValue=us-east-1b \
               #ParameterKey=ParameterPrivateSubnetCidr1,ParameterValue=10.0.160.0/23 \
               #ParameterKey=ParameterPrivateSubnetCidr2,ParameterValue=10.0.164.0/23 \
               #ParameterKey=ParameterPublicSubnetCidr1,ParameterValue=10.0.162.0/23 \
               #ParameterKey=ParameterPublicSubnetCidr2,ParameterValue=10.0.166.0/23 \
               #ParameterKey=ParameterVpcCidr,ParameterValue=10.0.160.0/20 \

###########
#cluster
###########
               #ParameterKey=ParameterEksVersion,ParameterValue=1.15 \

###########
#nodegrpnodesaz1 and az2
###########
               #ParameterKey=ParameterWorkerNodeAmi,ParameterValue=ami-0dc7713312a7ec987 \
