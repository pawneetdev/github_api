module Github
    module V1
        class Score < Grape::API
        
            version 'v1', using: :path
            format :json
            prefix :api

            resource :score do

                params do
                    requires :username, type: String
                end
            
                get '/:username' do
                    indi_score = { 'IssuesEvents': 7, 'IssueCommentEvent': 6, 'PushEvent': 5, 'PullRequestReviewEvent': 4, 'WatchEvent': 3, 'CreateEvent': 2 }

                    response = HTTParty.get("https://api.github.com/users/#{params[:username]}/events/public").parsed_response

                    return { "error": "User does not exist" } if response.empty?

                    score = 0

                    begin
                        response.each do |r|
                            score+=(indi_score[r["type"].to_sym].present? ? indi_score[r["type"].to_sym] : 1)
                        end

                        return {"username": params[:username], "score": score}
                    rescue
                        { "error": response["message"] }
                    end
                end
            end
        end
    end
end