require 'open-uri'
class ImageWorker
  include Sidekiq::Worker

  @@bucket = 'http://snowooo.qiniudn.com'
  @@largewartermark = 'largewartermark'
  @@bucket = 'snowooo'
  @@expires_in = 13.hours
  @@mediumwartermark = 'mediumwartermark'
  @@smallwartermark = 'smallwartermark'
  @@tmpImageBasePath = Rails.root.join 'tmp/images'

  @@logger ||= Logger.new("#{Rails.root}/log/image.log")
  

  def perform(id)
    snowboard = Snowboard.find(id)
    images = snowboard.images

    images.each do |img|

      path = @@tmpImageBasePath.join(snowboard.name+File.basename(img.small))
      download(img.small, path)

    #   img

    #   imagePath = imagesPath.join(snowboard.name+File.basename(img.large))
    #   imageName = (snowboard.name+File.basename(img.large)).split(' ').join('')
      

    #   originalUrl = bucket+imageName+'-imagewartermark'
    #   download_url = Qiniu::Auth.authorize_download_url(originalUrl)
    #   img.update(qilarge: download_url)
      
    end

  end

  def download(fromUrl,path)
    open(path, 'wb') do |file|
        file << open(fromUrl).read
    end

    return File.file? path
  end

  def upload(path)
    put_policy = Qiniu::Auth::PutPolicy.new(
        'snowooo',     # 存储空间
        @@bucket,        # 最终资源名，可省略，即缺省为“创建”语义
        @@expires_in,  #相对有效期，可省略，缺省为3600秒后 uptoken 过期
        # deadline     绝对有效期，可省略，指明 uptoken 过期期限（绝对值），通常用于调试
    )

    code, result, response_headers = Qiniu::Storage.upload_with_put_policy(
        put_policy,     # 上传策略
        path,     # 本地文件名
        File.basename(path),             #最终资源名，可省略，缺省为上传策略 scope 字段中指定的Key值
        #x_var            用户自定义变量，可省略，需要指定为一个 Hash 对象
    )
    return code == 200
  end

  def removeDownload(path)
    File.delete path
    return true
  end
end