file "/opt/phabricator" do
  action :create
end

%w{ phabriactor libphutil arcanist }.each do |repo|
  git "/opt/phabricator/#{repo}" do
    repository "git@github.com:facebook/#{repo}.git"
    reference "master"
    action :checkout
  end
end

php_fpm_pool "phabricator" do
  process_manager "dynamic"
  max_requests 200
  php_options 'php_admin_flag[log_errors]' => 'on', 'php_admin_value[memory_limit]' => '128M'
end