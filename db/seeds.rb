I18n.locale = :en
preference_1 = Preference.create! name: "Women's Fashion"
preference_2 = Preference.create! name: "Children's Fashion"
preference_3 = Preference.create! name: "Men's Fashion"

I18n.locale = :es
preference_1.name = "Ropa de mujeres"
preference_1.save
preference_2.name = "Ropa de niños"
preference_2.save
preference_3.name = "Ropa de hombres"
preference_3.save

User.create! email: 'first_user@mail.com'
