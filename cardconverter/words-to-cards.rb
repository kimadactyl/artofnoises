require 'rubygems'
require 'RMagick'
require 'csv'
include Magick

$imagepath = 'images/'
cardlist = '../wordlist.csv'

# Function to create all the cards
def create_card(caption)

	# Create blank image
	c = Image.new(822,597)

	# Create caption
	t = Magick::Image.read("caption:#{caption}") {
			self.font = 'Cambria-Regular'
	    self.stroke = 'transparent'
	    self.fill = 'black'
	    self.size = "822x597"
	    self.gravity = Magick::CenterGravity
	}.first

	# Composite image with text
	c.composite!(t, 0, 0, Magick::SrcOverCompositeOp)

	# Write the fil;e, first making a nice filename
	file = caption.gsub(/( )/, '_').downcase
	c.write($imagepath + file + ".png")
	# Log to the console
	print $imagepath + file + ".png written \n"
	# Destroy it or your computer grinds to a halt, oops
	c.destroy!
end

# Choose the row index as appropriate for your needs
CSV.foreach(cardlist) do |row|
	text = row[1]
	create_card(text)
end