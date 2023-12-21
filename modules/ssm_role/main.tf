########################################################################
#   Module: SSM Instance Role
#
#   @Author: Harisankar Ramachandran <mrsank@live.in>
#   @Date:   20.12.2023
#   @Version: v1.0.0
########################################################################

####################################
## AWS SSM Role
####################################

resource "aws_iam_role" "ssm_role" {
  name = var.ssm_role_name

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Effect" : "Allow",
      "Principal" : {
        "Service" : "ec2.amazonaws.com"
      },
      "Action" : "sts:AssumeRole"
    }]
  })
}

####################################
## AWS SSM Policy
####################################

data "aws_iam_policy" "AmazonSSMManagedInstanceCore" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# attach the policy to the role
resource "aws_iam_role_policy_attachment" "attach_ssm_policy" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = data.aws_iam_policy.AmazonSSMManagedInstanceCore.arn
}

# create the instance profile
resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = var.ssm_instance_profile_name
  role = aws_iam_role.ssm_role.name
}
