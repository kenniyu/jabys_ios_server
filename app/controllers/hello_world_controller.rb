class HelloWorldController < ApplicationController
  def hello_world
    Pusher['game_1_channel'].trigger('my_event', {
      message: 'hello world'
    })
    Pusher['game_2_channel'].trigger('my_event', {
      message: 'hello world'
    })
  end
end
