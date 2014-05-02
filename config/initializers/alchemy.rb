ALCHEMY_CONFIG = YAML.load_file("#{::Rails.root}/config/alchemy.yml")[::Rails.env]

CLIENT = AlchemyAPI.new(ALCHEMY_CONFIG['key'])
