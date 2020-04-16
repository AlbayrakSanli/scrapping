require_relative '../lib/scrapping'

describe "Nom des crypto avec leur valeur associée" do
  it "Ca vérifie s'il y a une récupération d'information" do
    expect(crypto_money).not_to be_nil
  end
end
