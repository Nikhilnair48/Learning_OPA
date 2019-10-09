package learning

# SLIGHT TWEAKS TO THE DEMO AT Open Source Summit '19 - https://www.youtube.com/watch?v=Lca5u_ODS5s [timestamp of demo: starting at 18:28]

# THE FOLLOWING POLICY EVALUATES TO TRUE FOR ONE CONDITION: A EMPLOYEE MAY LOOK UP THEIR SALARY. 

# BY DEFAULT, POLICY HAS BEEN VIOLAED
default allow = false

# TO RETURN A COMPLIANCE WITH POLICY,
allow = true {
	input.method = "GET"                    # FOR ALL GET REQUESTS...
    input.path = ["salary", employee_id]    # FOR THE PATH CONTAING A LIST OF "salary" AND VARIABLE OF employee_id...
    input.user = employee_id                # THE VARIABLE, employee_id, SHOULD MATCH THE USER
}

# FOR THE BELOW INPUT,
# {
# 	"method" : "GET",
#   	"path" : ["salary", "john"],
#   	"user" : "john"
# }
# THE OUTPUT WILL BE:
# Evaluated package in 40.806 µs.
# {
#   "result": {
#     "allow": true
#   }
# }
# TRANSLATION: SUCCESS. JOHN MAY LOOK UP THE SALARY OF JOHN.

# FOR THE BELOW INPUT,
# {
# 	"method" : "GET",
#   	"path" : ["salary", "john"],
#   	"user" : "kathy"
# }
# THE OUTPUT WILL BE:
# Evaluated package in 44.058 µs.
# {
#   "result": {
#     "allow": false
#   }
# }
# TRANSLATION: FAIL. KATHY MAY NOT LOOK UP THE SALARY OF JOHN.