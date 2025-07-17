# Create Gallery
Gallery.delete_all

# create video gallery
puts "Create Gallery Videos"

videos = [{
	en: "Indonesia Energy (NYSE American: INDO) is Increasingly Expansive",
	cn: "印度尼西亚能源（纽约证券交易所美国股票代码：INDO）的业务日益扩张",
	video_url: "https://www.youtube.com/watch?v=_3r9RLD7FjA"
}, {
	en: "Indonesia Energy Corporation Limited (NYSE American: INDO) Rings The Opening Bell",
	cn: "印度尼西亚能源有限公司（纽约证券交易所美国股票代码：INDO）敲响开市钟",
	video_url: "https://www.youtube.com/watch?v=_WTJreg_0DQ"
}, {
	en: "Indonesia Energy (NYSE American: INDO) Virtual Road Show with President Frank Ingriselli",
	cn: "印度尼西亚能源公司（纽约证券交易所美国股票代码：INDO）与总裁 Frank Ingriselli 进行虚拟路演",
	video_url: "https://www.youtube.com/watch?v=4gTNNXYRqzc"
}]

videos.each_with_index do |g, i|
	gallery = Gallery.new(title: g[:en])
	gallery.image.attach(io: Rails.root.join("vendor/assets/images/videos/video-#{i+1}.png").open, filename: "video-#{i+1}.png")
	gallery.video_url = g[:video_url]
	Mobility.with_locale(:cn) {
		gallery.title = g[:cn]
	}
	gallery.save
	puts "Create Gallery: #{gallery.title}"
end
