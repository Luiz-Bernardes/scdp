puts "Limpando dados..."

PauseQueue.delete_all
Pause.delete_all
PauseType.delete_all
TeamMembership.delete_all
Team.delete_all

puts "=============================="
puts "Criando dados de desenvolvimento..."
puts "=============================="

# ---------------------------------------------------
# Usuários
# ---------------------------------------------------

admin = User.find_or_create_by!(email: "admin@scdp.com") do |u|
  u.name = "Administrador"
  u.role = :admin
  u.provider = "google"
  u.provider_uid = SecureRandom.uuid
end

supervisor = User.find_or_create_by!(email: "supervisor@scdp.com") do |u|
  u.name = "Supervisor"
  u.role = :supervisor
  u.provider = "google"
  u.provider_uid = SecureRandom.uuid
end

luiz = User.find_or_create_by!(email: "luizhenbernardes@gmail.com") do |u|
  u.name = "Luiz Bernardes"
  u.role = :agent
  u.provider = "google"
  u.provider_uid = SecureRandom.uuid
end

pedro = User.find_or_create_by!(email: "pedro@scdp.com") do |u|
  u.name = "Pedro"
  u.role = :agent
  u.provider = "google"
  u.provider_uid = SecureRandom.uuid
end

ana = User.find_or_create_by!(email: "ana@scdp.com") do |u|
  u.name = "Ana"
  u.role = :agent
  u.provider = "google"
  u.provider_uid = SecureRandom.uuid
end

joao = User.find_or_create_by!(email: "joao@scdp.com") do |u|
  u.name = "João"
  u.role = :agent
  u.provider = "google"
  u.provider_uid = SecureRandom.uuid
end

marcos = User.find_or_create_by!(email: "marcos@scdp.com") do |u|
  u.name = "Marcos"
  u.role = :agent
  u.provider = "google"
  u.provider_uid = SecureRandom.uuid
end

# ---------------------------------------------------
# Time
# ---------------------------------------------------

team = Team.find_or_create_by!(name: "Ticket Manager") do |t|
  t.created_by = admin
  t.active = true
end

# ---------------------------------------------------
# Memberships
# ---------------------------------------------------

[
  admin,
  supervisor,
  luiz,
  pedro,
  ana,
  joao,
  marcos
].each do |user|

  TeamMembership.find_or_create_by!(
    team: team,
    user: user
  ) do |membership|
    membership.email = user.email
    membership.pending = false
  end

end

# ---------------------------------------------------
# Pause Types
# ---------------------------------------------------

intervalo = PauseType.find_or_create_by!(
  team: team,
  name: "Pausa Intervalo"
) do |p|
  p.has_time_limit = true
  p.max_duration_minutes = 120
  p.max_concurrent = 6
  p.requires_queue = true
  p.active = true
end

laboral = PauseType.find_or_create_by!(
  team: team,
  name: "Pausa Laboral"
) do |p|
  p.has_time_limit = false
  p.max_concurrent = 6
  p.requires_queue = true
  p.active = true
end

banheiro = PauseType.find_or_create_by!(
  team: team,
  name: "Pausa Banheiro"
) do |p|
  p.has_time_limit = false
  p.max_concurrent = 10
  p.requires_queue = true
  p.active = true
end


# ---------------------------------------------------
# Pausas ativas
# ---------------------------------------------------

Pause.find_or_create_by!(
  user: pedro,
  pause_type: intervalo,
  team: team,
  status: :active
) do |pause|
  pause.started_at = 8.minutes.ago
  pause.selected_duration_minutes = 10
  pause.expires_at = pause.started_at + pause.selected_duration_minutes.minutes
end

Pause.find_or_create_by!(
  user: ana,
  pause_type: intervalo,
  team: team,
  status: :active
) do |pause|
  pause.started_at = 2.minutes.ago
  pause.selected_duration_minutes = 20
  pause.expires_at = pause.started_at + pause.selected_duration_minutes.minutes
end

# ---------------------------------------------------
# Fila
# ---------------------------------------------------

PauseQueue.find_or_create_by!(
  pause_type: intervalo,
  user: marcos
) do |queue|
  queue.team = team
  queue.position = 1
  queue.requested_at = Time.current
end

PauseQueue.find_or_create_by!(
  pause_type: intervalo,
  user: luiz
) do |queue|
  queue.team = team
  queue.position = 2
  queue.requested_at = Time.current + 5.seconds
end

puts
puts "✔ Seed concluído!"
puts
puts "Time: #{team.name}"
puts "Usuários: #{User.count}"
puts "Tipos de pausa: #{PauseType.count}"
puts "Pausas ativas: #{Pause.occupying_slot.count}"
puts "Fila: #{PauseQueue.count}"
puts