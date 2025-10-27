# Clear existing data
puts "Cleaning database..."
StudentQuestion.destroy_all
LearningPlan.destroy_all
TestResult.destroy_all
LearningNote.destroy_all
LearningRecord.destroy_all
Question.destroy_all
Video.destroy_all
Material.destroy_all
Lesson.destroy_all
Course.destroy_all
User.destroy_all

puts "Creating users..."

# 管理者
admin = User.create!(
  name: "システム管理者",
  email: "admin@example.com",
  password: "password123",
  password_confirmation: "password123",
  role: :admin
)

# 教師（保護者）2名
teacher1 = User.create!(
  name: "田中 太郎",
  email: "tanaka@example.com",
  password: "password123",
  password_confirmation: "password123",
  role: :teacher
)

teacher2 = User.create!(
  name: "田中 花子",
  email: "hanako@example.com",
  password: "password123",
  password_confirmation: "password123",
  role: :teacher
)

# 生徒 2名
student1 = User.create!(
  name: "田中 一郎",
  email: "ichiro@example.com",
  password: "password123",
  password_confirmation: "password123",
  role: :student
)

student2 = User.create!(
  name: "田中 次郎",
  email: "jiro@example.com",
  password: "password123",
  password_confirmation: "password123",
  role: :student
)

puts "Created #{User.count} users"

puts "Creating courses..."

# 数学コース
math_course = Course.create!(
  title: "中学数学 基礎",
  description: "中学1年生から3年生までの数学の基礎を学びます。代数、幾何、関数など幅広い内容をカバーします。",
  teacher: teacher1
)

# 英語コース
english_course = Course.create!(
  title: "英語 基礎コース",
  description: "英文法の基礎から、読解、リスニング、スピーキングまで総合的に学びます。",
  teacher: teacher2
)

# 理科コース
science_course = Course.create!(
  title: "理科 実験と観察",
  description: "物理、化学、生物、地学の基礎を実験や観察を通して学びます。",
  teacher: teacher1
)

puts "Created #{Course.count} courses"

puts "Creating lessons for Math course..."

# 数学のレッスン
math_lesson1 = Lesson.create!(
  title: "正負の数",
  description: "正の数と負の数について学び、四則演算を理解します。",
  content: "正負の数は数学の基礎です。プラスとマイナスの概念を理解しましょう。",
  course: math_course,
  order_index: 1
)

math_lesson2 = Lesson.create!(
  title: "文字式",
  description: "文字を使って数量を表現する方法を学びます。",
  content: "xやyなどの文字を使って、数量や関係を表現する方法を学びます。",
  course: math_course,
  order_index: 2
)

math_lesson3 = Lesson.create!(
  title: "方程式",
  description: "一次方程式の解き方を学びます。",
  content: "方程式を解くことで、未知の数を求めることができます。",
  course: math_course,
  order_index: 3
)

puts "Creating lessons for English course..."

# 英語のレッスン
english_lesson1 = Lesson.create!(
  title: "基本的な挨拶と自己紹介",
  description: "英語での挨拶と自己紹介の仕方を学びます。",
  content: "Hello, My name is... I'm from... などの基本的な表現を学びます。",
  course: english_course,
  order_index: 1
)

english_lesson2 = Lesson.create!(
  title: "be動詞と一般動詞",
  description: "英語の基本となる動詞の使い方を学びます。",
  content: "be動詞（am, is, are）と一般動詞の違いと使い方を理解します。",
  course: english_course,
  order_index: 2
)

puts "Creating lessons for Science course..."

# 理科のレッスン
science_lesson1 = Lesson.create!(
  title: "植物の観察",
  description: "植物の構造と成長について学びます。",
  content: "根、茎、葉の役割と、植物がどのように成長するかを観察します。",
  course: science_course,
  order_index: 1
)

puts "Created #{Lesson.count} lessons"

puts "Creating materials..."

# 教材の作成
Material.create!(
  title: "正負の数 練習問題",
  description: "正負の数の計算練習問題集です。",
  material_type: :text,
  lesson: math_lesson1
)

Material.create!(
  title: "文字式の基本ルール",
  description: "文字式を書くときのルールをまとめた資料です。",
  material_type: :pdf,
  lesson: math_lesson2
)

Material.create!(
  title: "英語挨拶フレーズ集",
  description: "日常で使える英語の挨拶表現をまとめました。",
  material_type: :text,
  lesson: english_lesson1
)

puts "Created #{Material.count} materials"

puts "Creating questions..."

# テスト問題の作成
Question.create!(
  content: "(-3) + 5 = ?",
  question_type: :short_answer,
  correct_answer: "2",
  lesson: math_lesson1
)

Question.create!(
  content: "(-2) × (-4) = ?",
  question_type: :short_answer,
  correct_answer: "8",
  lesson: math_lesson1
)

Question.create!(
  content: "次の文の空欄に適切な be動詞を入れなさい: I ___ a student.",
  question_type: :short_answer,
  correct_answer: "am",
  lesson: english_lesson2
)

Question.create!(
  content: "植物が光合成を行うのに必要なものを選びなさい。\nA) 水と二酸化炭素\nB) 水と酸素\nC) 酸素と二酸化炭素",
  question_type: :multiple_choice,
  correct_answer: "A",
  lesson: science_lesson1
)

puts "Created #{Question.count} questions"

puts "Creating learning records..."

# 学習記録
LearningRecord.create!(
  student: student1,
  lesson: math_lesson1,
  duration: 45,
  completed: true,
  completed_at: 1.day.ago
)

LearningRecord.create!(
  student: student1,
  lesson: math_lesson2,
  duration: 30,
  completed: false
)

LearningRecord.create!(
  student: student2,
  lesson: english_lesson1,
  duration: 60,
  completed: true,
  completed_at: 2.days.ago
)

puts "Created #{LearningRecord.count} learning records"

puts "Creating learning notes..."

# 学習メモ
LearningNote.create!(
  student: student1,
  lesson: math_lesson1,
  content: "負の数同士をかけると正の数になることを覚えておく！"
)

LearningNote.create!(
  student: student2,
  lesson: english_lesson1,
  content: "Nice to meet you. の返事は Nice to meet you, too. です。"
)

puts "Created #{LearningNote.count} learning notes"

puts "Creating learning plans..."

# 学習計画（分散学習）
LearningPlan.create!(
  student: student1,
  lesson: math_lesson3,
  scheduled_at: 1.day.from_now,
  completed: false
)

LearningPlan.create!(
  student: student1,
  lesson: math_lesson1,
  scheduled_at: 7.days.from_now, # 復習
  completed: false
)

LearningPlan.create!(
  student: student2,
  lesson: english_lesson2,
  scheduled_at: 2.days.from_now,
  completed: false
)

puts "Created #{LearningPlan.count} learning plans"

puts "Creating student questions..."

# 生徒からの質問
StudentQuestion.create!(
  student: student1,
  lesson: math_lesson2,
  question: "文字式で、x × 2 を 2x と書くのはなぜですか？",
  answer: "数学では、かけ算の記号（×）を省略して書く慣習があります。2xは「2とxをかける」という意味です。",
  answered_at: 1.hour.ago
)

StudentQuestion.create!(
  student: student2,
  lesson: english_lesson1,
  question: "How are you? と聞かれたら、何と答えればいいですか？",
  answer: nil, # まだ回答されていない
  answered_at: nil
)

puts "Created #{StudentQuestion.count} student questions"

puts "Creating test results..."

# テスト結果
question1 = Question.find_by(content: "(-3) + 5 = ?")
question2 = Question.find_by(content: "(-2) × (-4) = ?")

TestResult.create!(
  student: student1,
  question: question1,
  answer: "2",
  correct: true,
  score: 10
)

TestResult.create!(
  student: student1,
  question: question2,
  answer: "8",
  correct: true,
  score: 10
)

puts "Created #{TestResult.count} test results"

puts "\n=========================================="
puts "Seed data created successfully!"
puts "=========================================="
puts "Users:"
puts "  Admin: admin@example.com / password123"
puts "  Teacher 1: tanaka@example.com / password123"
puts "  Teacher 2: hanako@example.com / password123"
puts "  Student 1: ichiro@example.com / password123"
puts "  Student 2: jiro@example.com / password123"
puts "=========================================="
puts "Courses: #{Course.count}"
puts "Lessons: #{Lesson.count}"
puts "Materials: #{Material.count}"
puts "Questions: #{Question.count}"
puts "Learning Records: #{LearningRecord.count}"
puts "Learning Notes: #{LearningNote.count}"
puts "Learning Plans: #{LearningPlan.count}"
puts "Student Questions: #{StudentQuestion.count}"
puts "Test Results: #{TestResult.count}"
puts "=========================================="
