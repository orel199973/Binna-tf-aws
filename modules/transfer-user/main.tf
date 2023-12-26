resource "aws_transfer_user" "this" {
  for_each = var.create ? toset(["user"]) : toset([])
  server_id           = var.server_id
  user_name           = var.user_name
  role                = var.role
  home_directory_type = var.home_directory_type
  policy              = var.policy
  tags                = var.tags

  # dynamic "posix_profile"{
  #   for_each     = var.posix_profile != null ? toset(["posix_profile"]) : toset([])
  #   content {
  #     gid =  lookup(posix_profile.value,"gid",null)
  #     uid =  lookup(posix_profile.value,"uid",null)
  #     secondary_gids =  lookup(posix_profile.value,"secondary_gids",null)
  #   }
  # }
  # dynamic "home_directory_mappings" {
  #   for_each = var.home_directory_mappings != null ? toset(["home_directory_mappings"]) : toset([])
  #   content {
  #     entry  = lookup(home_directory_mappings.value,"entry","/")
  #     target = lookup(home_directory_mappings.value,"target","/")
  #   }
  # }
}
