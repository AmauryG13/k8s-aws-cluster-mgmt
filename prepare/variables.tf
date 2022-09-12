variable "create_group" {
  description = "Whether to create IAM group"
  type        = bool
  default     = false
}

variable "name" {
  description = "Name of IAM group"
  type        = string
  default     = "kops"
}

variable "group_users" {
  description = "List of IAM users to have in an IAM group which can assume the role"
  type        = list(string)
  default     = [
    kops,
    kops-admin,
    kops-users,
  ]
}

variable "custom_group_policy_arns" {
  description = "List of IAM policies ARNs to attach to IAM group"
  type        = list(string)
  default     = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonRoute53FullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/IAMFullAccess",
    "arn:aws:iam::aws:policy/AmazonVPCFullAccess",
    "arn:aws:iam::aws:policy/AmazonSQSFullAccess",
    "arn:aws:iam::aws:policy/AmazonEventBridgeFullAccess"
  ]
}

variable "custom_group_policies" {
  description = "List of maps of inline IAM policies to attach to IAM group. Should have `name` and `policy` keys in each element."
  type        = list(map(string))
  default     = []
}

variable "attach_iam_self_management_policy" {
  description = "Whether to attach IAM policy which allows IAM users to manage their credentials and MFA"
  type        = bool
  default     = false
}

variable "iam_self_management_policy_name_prefix" {
  description = "Name prefix for IAM policy to create with IAM self-management permissions"
  type        = string
  default     = "IAMSelfManagement-"
}

variable "aws_account_id" {
  description = "AWS account id to use inside IAM policies. If empty, current AWS account ID will be used."
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}