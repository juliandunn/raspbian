use_inline_resources if defined?(use_inline_resources)

# These are defaults from raspi-config
preset_map = {
  :none => {
    :clock => 700,
    :core => 250,
    :sdram => 400,
    :overvolt => 0
  },
  :modest => {
    :clock => 800,
    :core => 250,
    :sdram => 400,
    :overvolt => 0
  },
  :medium => {
    :clock => 900,
    :core => 250,
    :sdram => 450,
    :overvolt => 2
  },
  :high => {
    :clock => 950,
    :core => 250,
    :sdram => 450,
    :overvolt => 6
  },
  :turbo => {
    :clock => 1000,
    :core => 500,
    :sdram => 600,
    :overvolt => 6
  },
  :pi2 => {
    :clock => 1000,
    :core => 500,
    :sdram => 500,
    :overvolt => 2
  }
}

action :set do
  replace_or_add 'set clock' do
    path '/boot/config.txt'
    pattern '^arm_freq=.*'
    line "arm_freq=#{preset_map[@new_resource.preset][:clock]}"
  end

  replace_or_add 'set core' do
    path '/boot/config.txt'
    pattern '^core_freq=.*'  
    line "core_freq=#{preset_map[@new_resource.preset][:core]}"
  end

  replace_or_add 'set sdram' do
    path '/boot/config.txt'
    pattern '^sdram_freq=.*'
    line "sdram_freq=#{preset_map[@new_resource.preset][:sdram]}"
  end

  replace_or_add 'set overvolt' do
    path '/boot/config.txt'
    pattern '^over_voltage=.*'
    line "over_voltage=#{preset_map[@new_resource.preset][:overvolt]}"
  end
end

action :unset do
  delete_lines 'unset clock' do
    path '/boot/config.txt'
    pattern '^arm_freq.*'
  end

  delete_lines 'unset core' do
    path '/boot/config.txt'
    pattern '^core_freq.*'
  end

  delete_lines 'unset sdram' do
    path '/boot/config.txt'
    pattern '^sdram_freq.*'
  end

  delete_lines 'unset overvolt' do
    path '/boot/config.txt'
    pattern '^over_voltage.*'
  end
end
