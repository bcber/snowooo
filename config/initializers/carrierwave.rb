::CarrierWave.configure do |config|
  config.storage             = :qiniu
  config.qiniu_access_key    = "Ngx_GFQWI5Tpy8CI0MEp_w84EFwrR2YDwlUfFNTj"
  config.qiniu_secret_key    = '2NcSMZab6VlF9v49gaXjreQSy4oe7fjO4Klw5fQP'
  config.qiniu_bucket        = "snowooo"
  config.qiniu_bucket_domain = "snowooo.qiniudn.com"
  config.qiniu_bucket_private= true #default is false
  config.qiniu_can_overwrite = true
  config.qiniu_block_size    = 4*1024*1024
  config.qiniu_protocol      = "http"
end