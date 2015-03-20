class TipsController < ApplicationController

  caches_page :schnell_und_gesund_abnehmen

  def mitglieder_tipps
    @tips = Suggestion.all
  end

  def schnell_und_gesund_abnehmen
  end

end
