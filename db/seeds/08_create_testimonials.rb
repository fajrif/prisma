# CREATE Testimonials
Testimonial.delete_all

testimonials = [
  { name: "Frank Vidal", title: "Asia Pasific Director Adcity", company_name: "Havas", img: "havas.png", en_message: "Prisma sees the benefits of true digital adoption, bringing DOOH into the digital media ecosystem. Mostly, Prisma Sales team demonstrates, every single day, responsiveness and dedication to clients’ satisfaction far beyond expectations. You are in very safe hands!", id_message: "Prisma benar-benar melihat manfaat dari adopsi digital yang sesungguhnya, membawa DOOH masuk ke dalam ekosistem media digital. Yang paling menonjol, tim Sales Prisma selalu responsif dan totalitas dalam memastikan kepuasan klien, bahkan sering melebihi harapan. Bareng Prisma, kamu ada di tangan yang tepat!" },
  { name: "Lim Wimawan", title: "Head of Marketing", company_name: "Dana", img: "dana.png", en_message: "Prisma is a major Out-of-Home company that is credible, trustworthy, competitively priced, responsible, and offers comprehensive services along with excellent client support.", id_message: "Prisma itu perusahaan Out-of-Home besar yang kredibel, dapat dipercaya, memiliki harga yang kompetitif, bertanggung jawab dan mempunyai whole service dan client service yang bagus." },
  { name: "Sawitri", title: "Country Marketing Manager", company_name: "JobStreet", img: "jobstreet.png", en_message: "Prisma Advertising successfully brought our vision to life by executing our creative design exceptionally well. We hope that improved visibility will help this campaign reach all stakeholders and achieve the goal of the Better Matches campaign: enabling AI Jobstreet by SEEK to help companies find the right talent, and job seekers to land their dream careers quickly and easily.", id_message: "Prisma Advertising berhasil mewujudkan visi kami dengan mengimplementasikan desain kreatif kami dengan sangat baik. Kami harap visibilitas yang lebih baik, membuat kampanye kami ini dapat menjangkau seluruh pemangku kepentingan dan tujuan kampanye Better Matches ini dapat tercapai, yakni AI Jobstreet by SEEK membantu perusahaan mendapatkan tenaga kerja yang cocok, dan pencari kerja dengan karir idamannya Dengan cepat dan mudah." },
]

# Create testimonials
testimonials.each do |data|
  t = Testimonial.new(name: data[:name], title: data[:title], company_name: data[:company_name], message: data[:en_message])
  t.image.attach(io: Rails.root.join("public/clients/#{data[:img]}").open, filename: data[:img])
  Mobility.with_locale(:id) {
    t.message = data[:id_message]
  }
  t.save
  puts "Create Client: #{t.name}"
end
