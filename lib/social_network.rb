module SocialNetwork
  class VK
    attr_reader :vk

    BASE_URL = "http://res.cloudinary.com/baramik/video/upload/v1440084614/"

    def initialize(oauth_token)
      @vk = VkontakteApi::Client.new(oauth_token)
    end

    def make_vk_post(runner_id)
      file_body = upload_video_file(runner_id)
      create_tmp_video_file(file_body, runner_id)
      url = self.vk.video.save.upload_url
      file_ref = "#{store_dir}/#{runner_id}.mp4"
      VkontakteApi.upload(url: url, video_file:
                                      [file_ref, MIME::Types.type_for(file_ref).first.content_type])
    end

    def upload_video_file(runner_id)
      base_url = VK::BASE_URL
      video_url = base_url + "#{runner_id}.mp4"
      resp = Faraday.get(video_url)
      resp.body
    end

    def create_tmp_video_file(file_body, file_name)
      unless File.directory?(store_dir)
        FileUtils.mkdir_p(store_dir)
      end

      File.open("#{store_dir}/#{file_name}.mp4", "wb") do |file|
        file.write(file_body)
      end
    end

    def store_dir
      "#{Rails.root}/public/uploads/video"
    end

  end

  class FB
    BASE_URL = "http://res.cloudinary.com/baramik/video/upload/v1440084614/"
    attr_reader :fb

    def initialize(oauth_token)
      @fb = Koala::Facebook::API.new(oauth_token)
    end

    def make_fb_post(runner_id)
      base_url = FB::BASE_URL
      self.fb.put_video(base_url + "#{runner_id}.mp4")
    end
  end

end