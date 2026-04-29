module CourseHelper
  def embed_video(video_url)
    return nil if video_url.blank?

    if video_url.include?("youtube.com") || video_url.include?("youtu.be")
      youtube_id = video_url.split("v=").last.split("&").first
      if video_url.include?("youtu.be")
        youtube_id = video_url.split("/").last
      end
      
      content_tag(:div, class: "video-container relative pb-[56.25%] h-0 overflow-hidden") do
        content_tag(:iframe, "", 
          src: "https://www.youtube.com/embed/#{youtube_id}", 
          frameborder: "0", 
          allow: "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture", 
          allowfullscreen: true,
          class: "absolute top-0 left-0 w-full h-full rounded-lg"
        )
      end
    elsif video_url.include?("vimeo.com")
      vimeo_id = video_url.split("/").last
      content_tag(:div, class: "video-container relative pb-[56.25%] h-0 overflow-hidden") do
        content_tag(:iframe, "", 
          src: "https://player.vimeo.com/video/#{vimeo_id}", 
          frameborder: "0", 
          allow: "autoplay; fullscreen; picture-in-picture", 
          allowfullscreen: true,
          class: "absolute top-0 left-0 w-full h-full rounded-lg"
        )
      end
    else
      # Default to a simple link or HTML5 video tag if it's a direct file
      if video_url.match?(/\.(mp4|webm|ogg)$/i)
         content_tag(:video, controls: true, class: "w-full rounded-lg") do
           content_tag(:source, "", src: video_url)
         end
      else
        link_to "Watch Video", video_url, target: "_blank", class: "text-blue-500 underline"
      end
    end
  end
end
