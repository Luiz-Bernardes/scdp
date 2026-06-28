# Autenticação(Arquitetura)

	Next.js
		→ Microsoft OAuth
		→ Rails API callback
		→ valida usuário
		→ vincula convite pendente
		→ gera JWT

	Fluxo:

		Admin convida > joao@empresa.com

		↓

		team_memberships
			email = joao@empresa.com
			pending = true

		↓

		Usuário faz login Microsoft

		↓

		Microsoft retorna:
			- email
			- uid
			- name

		↓

		Rails procura convite pendente

		↓

		Se existir:
			vincula user
			pending = false

		↓

		Gera JWT