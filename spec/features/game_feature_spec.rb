require "rails_helper"

RSpec.feature "Connect Four game", type: :feature, js: true do
  scenario 'determines a winner for two humans' do
    visit '/'
    moves = [0,1,0,1,0,1,0]
    moves.each do |move|
      click_on(move.to_s)
    end
    expect(page).to have_text('Player 1 wins!')
  end
  scenario 'completes a game with two computers' do
    visit '/'
    select('1', from: 'search-depth-selector')
    find('#player1computer').click
    find('#player2computer').click
    expect(page).to have_text('Player 1 wins!') | have_text('Player 2 wins!') | have_text('Tie game!')
  end
end
