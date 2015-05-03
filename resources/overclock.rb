actions :set, :unset

default_action :set

attribute :preset, :kind_of => Symbol, :equal_to => [:none, :modest, :medium, :high, :turbo, :pi2], :default => :none
