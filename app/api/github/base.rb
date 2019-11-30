module Github
	class Base < Grape::API
		mount Github::V1::Score
	end
end