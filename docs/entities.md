# Entidades

	Users
		- id
		- name
		- email
		- microsoft_uid
		- role

		enum roles:
			> super_admin = 0
			> admin = 1
			> supervisor = 2
			> agent = 3

	Teams
		- id
		- name
		- active
		- created_by_id

	Team Memberships
		- id
		- user_id (nullable)
		- team_id
		- team_role
		- email
		- pending

	Pause Types
		- id
		- team_id
		- name
		- has_time_limit
		- max_concurrent
		- requires_queue
		- active

	Pauses
		- id
		- user_id
		- team_id
		- pause_type_id
		- selected_duration_minutes (nullable)
		- started_at
		- ended_at
		- status

		list status:
			> active
			> finished
			> expired
			> cancelled

	PauseQueues
		- id
		- user_id
		- team_id
		- pause_type_id
		- selected_duration_minutes (nullable)
		- position
		- status
		- requested_at
