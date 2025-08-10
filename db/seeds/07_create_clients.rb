# CREATE Client
Client.delete_all

clients = [
  { name: "Three", img: "three.png" },
  { name: "Batik Keris", img: "batik-keris.png" },
  { name: "blibli", img: "blibli.png" },
  { name: "BYD", img: "byd.png" },
  { name: "Chevron", img: "chevron.png" },
  { name: "Cool Vita", img: "cool-vita.png" },
  { name: "Dana", img: "dana.png" },
  { name: "Freeport", img: "freeport.png" },
  { name: "G20", img: "g20.png" },
  { name: "Gojek", img: "gojek.png" },
  { name: "Havas", img: "havas.png" },
  { name: "ID Express", img: "id-express.png" },
  { name: "Indofood", img: "indofood.png" },
  { name: "JobStreet", img: "jobstreet.png" },
  { name: "Kalbe", img: "kalbe.png" },
  { name: "Kanzler", img: "kanzler.png" },
  { name: "Kimia Farma", img: "kimia-farma.png" },
  { name: "Lazada", img: "lazada.png" },
  { name: "Bank Mandiri", img: "mandiri.png" },
  { name: "Mekari", img: "mekari.png" },
  { name: "Netflix", img: "netflix.png" },
  { name: "Nutrifood", img: "nutrifood.png" },
  { name: "Pertamina", img: "pertamina.png" },
  { name: "PLN", img: "pln.png" },
  { name: "Pocari Sweat", img: "pocari-sweat.png" },
  { name: "Prime Video", img: "prime-video.png" },
  { name: "Prudential", img: "prudential.png" },
  { name: "Samsung", img: "samsung.png" },
  { name: "Sasa", img: "sasa.png" },
  { name: "Sprite", img: "sprite.png" },
  { name: "Telkom", img: "telkom.png" },
  { name: "Tokopedia", img: "tokopedia.png" }
]

# Create Client
clients.each do |client|
  c = Client.new(company_name: client[:name])
  c.image.attach(io: Rails.root.join("public/clients/#{client[:img]}").open, filename: client[:img])
  c.save
  puts "Create Client: #{c.company_name}"
end
