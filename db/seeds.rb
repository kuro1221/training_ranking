# ユーザー
user = User.create!(name: "テストユーザー")

# トレーニングメニュー
menu = TrainingMenu.create!(name: "エンドレス腕立て伏せ", rule: "時間内にできるだけ多く行う")

# 記録（countはある想定）
TrainingRecord.create!(
  user: user,
  training_menu: menu,
  count: 50,
  recorded_at: Time.current
)
