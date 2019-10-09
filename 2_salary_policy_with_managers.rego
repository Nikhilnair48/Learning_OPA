package learning

# SLIGHT TWEAKS & MORE COMMENTS TO THE DEMO AT Open Source Summit '19 - https://www.youtube.com/watch?v=Lca5u_ODS5s [timestamp of demo: starting at 22:45]

# THE FOLLOWING POLICY EVALUATES TO TRUE FOR TWO CONDITIONS: AN EMPLOYEE MAY LOOK UP THEIR OWN SALARY 
# AND A MANAGER (ALSO AN EMPLOYEE) MAY LOOK UP THEIR OWN SALARY AS WELL AS SALARIES OF ANY EMPLOYEES THEY MANAGE

# BELOW POLICY BUILDS ON 1_simple_salary_policy.rego

# BY DEFAULT, POLICY HAS BEEN VIOLAED
default allow = false

# TO RETURN A COMPLIANCE WITH POLICY,
allow = true {
	input.method = "GET"                    # FOR ALL GET REQUESTS...
    input.path = ["salary", employee_id]    # FOR THE PATH CONTAING A LIST OF "salary" AND VARIABLE OF employee_id...
    input.user = employee_id                # THE VARIABLE, employee_id, SHOULD MATCH THE USER
}

allow = true {
    input.method = "GET"
    input.path = ["salary" , employee_id]
    managers[employee_id][input.user]
}

managers = {
    "john" : {"alice", "eve"},
    "kathy" : {"ron"}
}

# WRITING TEST CASES
test_allow {
    allow with input as { "method" : "GET", "path" : ["salary", "kathy"], "user" : "ron" }
}

# FOR THE INPUT,
# {
# 	"method" : "GET",
#   "path" : ["salary", "kathy"],
#   "user" : "ron"
# }
# THE OUTPUT WILL BE:
# # Evaluated package in 62.609 µs.
# {
#   "result": {
#     "allow": true,
#     "managers": {
#       "john": [
#         "alice",
#         "eve"
#       ],
#       "kathy": [
#         "ron"
#       ]
#     }
#   }
# }
# TRANSLATION: SUCCESS. KATHY (THE MANAGER) MAY VIEW THE SALARY OF RON.

# FOR THE INPUT,
# {
# 	"method" : "GET",
#   	"path" : ["salary", "kathy"],
#   	"user" : "eve"
# }
# THE OUTPUT WILL BE:
# Evaluated package in 60.48 µs.
# {
#   "result": {
#     "allow": false,
#     "managers": {
#       "john": [
#         "alice",
#         "eve"
#       ],
#       "kathy": [
#         "ron"
#       ]
#     }
#   }
# }
# TRANSLATION: KATHY MAY NOT VIEW THE SALARY OF EVE. JOHN THE THE MANAGER OF EVE.
