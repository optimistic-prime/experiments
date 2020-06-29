import boto3

accounts = [
    'dev-aws',
    #'test-aws',
    #'roadrunner',
    #'contoso',
    #'adp-wholesale',
    #'adp-chat',
    #'adp-711',
    #'cw',
    #'frontier',
    #'mercy-health',
    #'development',
]


def main(account):
    session = boto3.session.Session(profile_name=account)
    ec2 = session.resource('ec2')

    reservations = ec2.describe_instances()['Reservations']
    instances = [reservation['Instances'] for reservation in reservations]

    for instance in instances:
        instance_info = instance[0]

        name_tag = print_name_or_instance_id(instance_info)

        instance_type = instance_info['InstanceType']
        warn(instance_type, name_tag)


def warn(i_type, i_name):

    if 'x1' in i_type or 'r5' in i_type or 'm5.4x' in i_type:
        print(i_name)
        print(i_type)
        print()


def print_name_or_instance_id(info):

    try:
        names = [tag['Value'] for tag in info['Tags'] if tag['Key'] == 'Name']

        # should only be one Name
        name = names[0]

        tag = name

    except Exception:
        tag = info['InstanceId']

    return tag


if __name__ == "__main__":
    for account in accounts:
        main(account)
