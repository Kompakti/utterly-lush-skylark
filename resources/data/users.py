USERS = {
    "standard_user": "secret_sauce",
    "locked_out_user": "secret_sauce",
    "problem_user": "secret_sauce",
    "performance_glitch_user": "secret_sauce",
    "error_user": "secret_sauce",
    "visual_user": "secret_sauce",
}

# locked_out_user is a valid account but is blocked from logging in
LOGINABLE_USERS = [username for username in USERS if username != "locked_out_user"]
